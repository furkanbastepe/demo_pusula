# Mobile Web Emulator Wrapper Design

## Overview
Reconfigure the Pusula Flutter project's web output to function as a highly performant, embedded mobile emulator utilizing the Flutter WASM (CanvasKit) renderer and `hostElement` API.

## Architecture
- **Compiler:** Flutter WASM / CanvasKit for maximum UI performance.
- **Integration Method:** Flutter Web will be hosted inside a specific HTML `div` element via `engineInitializer.initializeEngine({ hostElement: ... })`, rather than occupying the full viewport.
- **Frontend Stack:** Vanilla HTML/CSS/JS for the emulator shell to maintain a clean boundary and high performance.

## Components
1. **Device Frame Container (`.device-frame`):**
   - Pure CSS iPhone Pro style frame.
   - Glassmorphism effects, dynamic shadows, and premium layout (`ui-ux-pro-max` aesthetic standards).
   - Constrained aspect ratio mimicking a typical mobile device (e.g., 9:19.5).
2. **Flutter Host Background:**
   - Dark "Forge" style background or soft neon gradients.
   - Micro-animations for the background environment for immersion.
3. **Flutter Root (`#flutter_host`):**
   - The DOM target for the Flutter engine.
   - Padded to emulate device bezels, cutouts (notch/dynamic island).
4. **Loading Screen (`.flutter-loader`):**
   - Premium SVG animation spinner that covers the frame while WASM files download.
   - Smooth CSS `fade-out` transition upon Flutter app initialization.

## Initialization Flow
1. **DOM Ready:** The HTML/CSS frame is displayed instantly.
2. **Download Phase:** `flutter_bootstrap.js` fetches the WASM payload.
3. **Engine Boot:** Flutter engine runs in the context of the `.device-frame`.
4. **App Ready:** Loader is dismissed, `runApp()` takes control of the host element.

## Handled Use Cases & Testing
- Ensuring mouse drag/touch behaviors emulate mobile touch gracefully.
- Responsive centering within varying desktop viewport sizes.
- Handling older browser fallback if WebGL/WASM is not supported.
