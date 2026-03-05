#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════════
# PUSULA — Post-Build Patcher
# Patches the generated flutter_bootstrap.js to:
#   1. Mount Flutter into #flutter_target (hostElement) instead of full body
#   2. Hide the loader when the app starts
#   3. Show error screen if initialization fails
# ═══════════════════════════════════════════════════════════════════════════════

set -e

BUILD_DIR="build/web"
BOOTSTRAP="$BUILD_DIR/flutter_bootstrap.js"

if [ ! -f "$BOOTSTRAP" ]; then
  echo "❌ Error: $BOOTSTRAP not found. Run 'flutter build web --wasm' first."
  exit 1
fi

echo "🔧 Patching flutter_bootstrap.js for emulator shell..."

# The generated flutter_bootstrap.js ends with a default _flutter.loader.load() call like:
#   _flutter.loader.load({
#     serviceWorkerSettings: {
#       serviceWorkerVersion: "XXXXX"
#     }
#   });
#
# We replace this default load() call with our custom one that:
#   - passes onEntrypointLoaded callback
#   - uses hostElement to target #flutter_target
#   - manages the loader visibility

# Use Python for reliable multi-line search-and-replace
python3 << 'PYTHON_SCRIPT'
import re, sys

filepath = "build/web/flutter_bootstrap.js"

with open(filepath, "r") as f:
    content = f.read()

# Match the final _flutter.loader.load({ ... }); call
# This is the auto-generated default bootstrap call
pattern = r'_flutter\.loader\.load\(\{[\s\S]*?serviceWorkerVersion:\s*"(\d+)"[\s\S]*?\}\);'

match = re.search(pattern, content)
if not match:
    print("⚠️  Could not find default _flutter.loader.load() call. Skipping patch.")
    sys.exit(0)

sw_version = match.group(1)

replacement = f'''_flutter.loader.load({{
  serviceWorkerSettings: {{
    serviceWorkerVersion: "{sw_version}"
  }},
  onEntrypointLoaded: async function(engineInitializer) {{
    try {{
      var appRunner = await engineInitializer.initializeEngine({{
        hostElement: document.querySelector('#flutter_target'),
      }});
      var loader = document.getElementById('loader');
      if (loader) loader.classList.add('hidden');
      await appRunner.runApp();
    }} catch (e) {{
      console.error('Flutter initialization error:', e);
      var loader = document.getElementById('loader');
      if (loader) loader.classList.add('hidden');
      var errorEl = document.getElementById('browser-error');
      if (errorEl) errorEl.classList.add('visible');
    }}
  }}
}});'''

new_content = content[:match.start()] + replacement + content[match.end():]

with open(filepath, "w") as f:
    f.write(new_content)

print(f"✅ Patched flutter_bootstrap.js (SW version: {sw_version})")
print("   → Flutter will mount to #flutter_target")
print("   → Loader will auto-hide on app start")
print("   → Error screen will show on failure")
PYTHON_SCRIPT

echo "🎉 Post-build patching complete!"
