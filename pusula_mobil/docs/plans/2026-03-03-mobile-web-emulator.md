# Mobile Web Emulator Wrapper Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Transform the Flutter Web build into a highly performant, embedded mobile emulator within a custom HTML/CSS device frame using the `hostElement` API.

**Architecture:** We will modify `web/index.html` to include a structured `.device-frame` and a `#flutter_target` div. We will update the Flutter initialization script to target this specific div instead of the entire body. We will also add a premium CSS loader and background styling.

**Tech Stack:** HTML, CSS, JavaScript, Flutter Web (WASM/CanvasKit)

---

### Task 1: Create the Emulator UI Structure

**Files:**
- Modify: `web/index.html`
- Create: `web/styles.css`

**Step 1: Write the HTML structure in `index.html`**

Update `web/index.html` to include the new DOM structure inside the `<body>` tag, replacing any existing content. We also need to link `styles.css`.

```html
<link rel="stylesheet" href="styles.css">
```

```html
<body>
  <div class="emulator-environment">
    <div class="device-frame">
      <div class="dynamic-island"></div>
      <div id="flutter_target"></div>
      
      <!-- Loader -->
      <div class="flutter-loader" id="loader">
        <div class="spinner"></div>
      </div>
    </div>
  </div>
  
  <script src="flutter_bootstrap.js" async></script>
</body>
```

**Step 2: Add CSS for the UI in `styles.css`**

Create `web/styles.css` and add premium styling for the emulator environment, device frame (with glassmorphism and shadow effects), and the loader.

**Step 3: Commit**

```bash
git add web/index.html web/styles.css
git commit -m "feat(web): add emulator ui structure and styles"
```

### Task 2: Configure Flutter Engine Initialization

**Files:**
- Modify: `web/index.html`

**Step 1: Override Flutter Bootstrap Initialization**

Modify `web/index.html` to customize how Flutter initializes, ensuring it mounts to `#flutter_target` and removes the loader when finished. 
Since Flutter 3.22+, `flutter_bootstrap.js` handles default initialization. We may need to use `{{flutter_js}}` and custom `engineInitializer` logic inside a script tag instead of `<script src="flutter_bootstrap.js" async></script>`, or configure `flutter_bootstrap.js` customization if supported.

```html
<script>
  window.addEventListener('load', function() {
    _flutter.loader.loadEntrypoint({
      onEntrypointLoaded: async function(engineInitializer) {
        let appRunner = await engineInitializer.initializeEngine({
          hostElement: document.querySelector('#flutter_target'),
        });
        document.getElementById('loader').style.display = 'none';
        await appRunner.runApp();
      }
    });
  });
</script>
```

**Step 2: Commit**

```bash
git add web/index.html
git commit -m "feat(web): configure flutter hostElement to emulator frame"
```

### Task 3: Test and Verify Build

**Files:**
- None

**Step 1: Run Flutter Web Server**

Run a local web server to test the implementation.
```bash
flutter run -d chrome --web-renderer canvaskit
```
(Or build it: `flutter build web --wasm` and serve it locally)

Expected: The app loads inside the mobile frame centered on the screen, not full screen. The loader shows and then hides.

**Step 2: Commit Final Changes**

```bash
git add .
git commit -m "chore(web): finalize web emulator wrapper implementation"
```
