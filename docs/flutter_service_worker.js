'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "345b8ab7f46062bb54fbb1f0b5f1f168",
"version.json": "b3ad4f57b857e8387b1b73799b464093",
"index.html": "f9211ec57c56bc7b455d6cc259d1e476",
"/": "f9211ec57c56bc7b455d6cc259d1e476",
"main.dart.js": "2871764aad352d27ee5ef0abfd461ec8",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "388bc079f9792439735037a339559a42",
"assets/AssetManifest.json": "f989b81f530321edf78a95d9a42cef69",
"assets/NOTICES": "5f2df38b3dd13ceed08e416c49d7d210",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "643c90068a16ef39ddc453551cc3eafe",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "d5cdab3423cd35c9b83d23b07781d039",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "3c6ea061a407aa7d06e71a9906549b05",
"assets/fonts/MaterialIcons-Regular.otf": "1858d2810a99c3b53194eedac28102a1",
"assets/assets/images/svg/installment.svg": "5272b7adef169b24a185c382fcadd4f5",
"assets/assets/images/svg/credit_card.svg": "7b998aa6c82a517c3ee2b2f7d3357554",
"assets/assets/images/svg/credit_sale.svg": "52cdd3ef709d871eba94dc461e1a2340",
"assets/assets/images/svg/cash_sale.svg": "a1233b6f97566180bd8e206a917e8f8c",
"assets/assets/images/svg/total_sale.svg": "52cdd3ef709d871eba94dc461e1a2340",
"assets/assets/images/svg/supplier.svg": "5048f1102d2714ca508fb37e762e705e",
"assets/assets/images/gear.png": "97be0efe0b5f5dc42afc223b0fcd908a",
"assets/assets/images/img.icons8.png": "8dc388339018d528a5ccaf300cab2131",
"assets/assets/images/add-file.png": "771e567014f29fba696b6b0927f0d3c4",
"assets/assets/images/invoice.png": "1b01819ad7ab81d6c9dc3adfab2272a3",
"assets/assets/images/category_edit.svg": "f8c57120671b4e702dd30e5134a0b752",
"assets/assets/images/apple-logo.png": "4f658b9a7d067de5238644b78d8d09cc",
"assets/assets/images/setting/account.svg": "2817d3436d8a5baa6e2fbc85239d5aaa",
"assets/assets/images/setting/logout.svg": "6f0c65d0efcad083ac299103db89a184",
"assets/assets/images/setting/order.svg": "5b6dbee02ff32c7f323b32384691e3b6",
"assets/assets/images/setting/dark_mode.svg": "b3f7d030c3027af76f812faf81a59db8",
"assets/assets/images/setting/category.svg": "079572c91febcea0f96c16b787278632",
"assets/assets/images/setting/add_item.svg": "aa044070d41d312854409d77040adf0c",
"assets/assets/images/setting/change_password_head_icon.svg": "bed2e06da14396451d7cb7f468f96556",
"assets/assets/images/setting/customer_installment.svg": "a1a835b8d51f3e43f096ad9cd9b8ce50",
"assets/assets/images/setting/change_password.svg": "15b2f654f07fa1ccd4ebc667a81dd8b2",
"assets/assets/images/setting/profile.svg": "a8a9ae7a5f00ada7f19adf40150c4aab",
"assets/assets/images/setting/supplier.svg": "d51dc964fec8a4cb21e09d98e8907af4",
"assets/assets/images/setting/change_language.svg": "3fda80fbd2ad44538eb14260b196dece",
"assets/assets/images/setting/supplier_installment.svg": "1398501e0baf4c62bb351f4143f25fbf",
"assets/assets/images/setting/customer.svg": "89220515d8b05095ef4080deb203c0aa",
"assets/assets/images/whatsapp.png": "2c186cc0c57f59a93681e611c686813d",
"assets/assets/images/google.png": "ca2f7db280e9c773e341589a81c15082",
"assets/assets/images/bottom/dashboard.png": "4a41d63f4202b26b11b5c74b4f11c53a",
"assets/assets/images/bottom/delivery-box.png": "ca7fe95deb07b58f25d83ecc71cc20db",
"assets/assets/images/bottom/product.png": "d5010d3e6317b3dd4c9c7aa400447a05",
"assets/assets/images/bottom/customer.png": "13fa7c5eecd7c68dd21e7e622a98cf49",
"assets/assets/images/bottom/svg.png": "6a676f059db671b8ef16bdd32dddf814",
"assets/assets/images/close.png": "7c5860a3c724f421783f9fa2ec82455d",
"assets/assets/images/bottom_navigation_bar/sale.svg": "119261489bf7a24aa71c959157e5adf1",
"assets/assets/images/bottom_navigation_bar/dashboard.svg": "3c2cfc9720f9b5a7c7e3832325a9b516",
"assets/assets/images/bottom_navigation_bar/setting.svg": "f8d47d4d042bdae9f97cd01a50dcb6af",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
