'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "e97027883a7d968a40536bc07d9c9d71",
"version.json": "662915149a2bc6c609e170249ecc257b",
"index.html": "551156a85d38bc2bcf97c60be70e94fb",
"/": "551156a85d38bc2bcf97c60be70e94fb",
"styles.css": "76bfc588f971a6f30b22b1ba7a9e89f3",
"main.dart.js": "fb866b7f369f1fd224cc0863c268a075",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.mjs": "0c9c5a68a1a20218c567a457a49b259e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "c96a3c58e2bbe023b82d2354ea28e864",
"main.dart.wasm": "edf5bbfa3d7103938e5108d1c446c23b",
"assets/AssetManifest.json": "66f6f736da1dd41d88bd841761f0a467",
"assets/NOTICES": "811096cac0d4318ec2607387149921a4",
"assets/FontManifest.json": "33ab002bb6a456cdc60c2eb75e7bc49e",
"assets/AssetManifest.bin.json": "848302a0c7d0acd93cefa486b3947720",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/lucide_icons_flutter/assets/lucide.ttf": "5b249b2a80c50f482a9bc65046acd324",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w500.ttf": "2380c4b0a5e2fc1290cdd266003d6a5e",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w100.ttf": "64144aa1aa76d2b82813658df2a26c79",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w300.ttf": "930b720a5d939c5e880b5b5db9087ad1",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w400.ttf": "0fa0c68ca0b2e71120150346577b89cf",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w600.ttf": "1dd6fffeb3cb7e347be36f9d80e51767",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w200.ttf": "d88bfd6ad62ffb93fb21a930431405f7",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "242d3924f53af94c795edd6c0c5aa324",
"assets/fonts/MaterialIcons-Regular.otf": "b8eb43d79266a70fd3d44656e53867a9",
"assets/assets/images/merve.jpg": "77ce857e196ce10c11f2a773319b785c",
"assets/assets/images/yasli.jpg": "fda628bd2ca65520878944714fb60372",
"assets/assets/images/sosyal.jpg": "893cf74495a4c7c1f64a894b0b5a19ae",
"assets/assets/images/mert.jpg": "4d714097dfc62afae4aae9c9e1860fb3",
"assets/assets/images/ahmet.jpg": "416d783be9cd39d3b64a68ebe2518698",
"assets/assets/images/veri.webp": "ab50da3f43a6b242b97e87c5d21e0753",
"assets/assets/images/kosgeb.jpg": "e22070964f6af94bb5ef266dd4c18d76",
"assets/assets/images/agac.jpg": "3a779615fb0095214a74c869596f7595",
"assets/assets/images/kobi.jpeg": "952215e635baf11afc58f1b8770a41e6",
"assets/assets/images/zeynep.jpeg": "953551a9045fec1abb5225f6ccc88add",
"assets/assets/images/trafikibb.jpg": "5b373646714f7c7e43d21f95423eaedb",
"assets/assets/images/trafik.jpeg": "784d94f6150177bde54d0538968ab6a6",
"assets/assets/images/Marketing.png": "8c80d6234f828b3555b1d45ce62a7fe9",
"assets/assets/images/miras.jpg": "30914fb5f96c4113188792153f423e75",
"assets/assets/images/api.png": "2e429bdb8ef8b312e0e6885c10ff2e9b",
"assets/assets/images/fatma.jpg": "559ce830e6d3471b167b2394c4ab8ff4",
"assets/assets/images/chatbot.png": "9793491266a1881d9f1e725064aff6f4",
"assets/assets/learning/courses/python/course.json": "e065e0b1973fd3fec72c724cfe0fece8",
"assets/assets/learning/courses/python/lessons/python-basics-1.json": "348455facd183a9f76f91514b024030e",
"assets/assets/learning/courses/python/lessons/python-basics-2.json": "4f01b273c5dea029898c1bcfda4d3902",
"assets/assets/learning/courses/python/lessons/python-basics-3.json": "d7f085db1248ba09c50fa253e760d32c",
"assets/assets/learning/courses/sql/course.json": "5d8c5d98bd4180c1d22d96e180ba27d1",
"assets/assets/learning/courses/sql/lessons/sql-basics-1.json": "d160b25c0b1cb30628658af69954a84a",
"assets/assets/learning/courses/sql/lessons/sql-basics-2.json": "8e018cc91779f28f6d9eac4f6a0b957b",
"assets/assets/learning/courses/sql/lessons/sql-basics-3.json": "44cc33e7e43717b7b9eab0edc5bdb778",
"assets/assets/projects/ecommerce-handcrafts-store.json": "ebf6208e00804bf0e05b351de0e8d0ab",
"assets/assets/projects/data-analyst-restaurant.json": "1140ad0bf521ebfbaf7f74bbe0f17aae",
"assets/assets/projects/software-dev-todo-app.json": "cbbf95a67a918ba56008c5b37449d59d",
"assets/assets/projects/digital-marketing-campaign.json": "038004bac577f75cc6f771016767e065",
"assets/assets/projects/ai-sentiment-analysis.json": "0f1301e815c5d24a6fe8cb383d374559",
"assets/assets/projects/digital-designer-menu.json": "68303a13e826bd4360ef91c65c0a837d",
"assets/assets/problems/problem_traffic_analysis.json": "73206d660e7d566faaa62acc61a5b906",
"assets/assets/problems/problem_air_quality.json": "01531c7cdb1066e9391120f1a31e1665",
"assets/assets/problems/problem_elderly_education.json": "6989986fd365f5ec057664074b2442bd",
"assets/assets/problems/problem_student_mentorship.json": "06c3df6209eb83dd143334f5050a642f",
"assets/assets/problems/problem_health_appointment.json": "07b1693a0240275cba4d08ce6bb00baf",
"assets/assets/problems/problem_social_assistance.json": "ebdb24562ba8871b5c4d64c79e422f01",
"assets/assets/problems/problem_cultural_heritage.json": "91ced85a342ffa09696ac1970a835e52",
"assets/assets/problems/problem_waste_management.json": "3e4163e15100cd04be97dfb032ae4b4f",
"assets/assets/problems/problem_smart_parking.json": "9fa3e62def4eb83b08eab5dce0201a1b",
"assets/assets/problems/problem_local_business_digital.json": "23057d1f42dc60868ed69981c20f08bf",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
