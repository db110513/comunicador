'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "8322aab9744b1989088a1f9465807a4b",
"assets/AssetManifest.bin.json": "22c80e760efdc21178e669d783279f4a",
"assets/AssetManifest.json": "bf5728d7d1e2ffb3c6b773d15d11deca",
"assets/assets/meusPictogrames/agafar.png": "8ae3a395bedd895b896ef264fca43cc3",
"assets/assets/meusPictogrames/anar.png": "56d68442529a787681d34bd1e939b279",
"assets/assets/meusPictogrames/ara.png": "c594e079951a86af87fd10c49709067e",
"assets/assets/meusPictogrames/avi.png": "cbc789e239729771f584f4ea325b10c1",
"assets/assets/meusPictogrames/avia.png": "76d65a8ae30c7ea3d4f0fa4fdda4e79e",
"assets/assets/meusPictogrames/bin.png": "830133591be0d68bd843a026eed48980",
"assets/assets/meusPictogrames/bossaPa.png": "705d023e443c9d6075707ad6527f6876",
"assets/assets/meusPictogrames/botiga.png": "b6769a1074e46ea1d9e9e8062e93a426",
"assets/assets/meusPictogrames/burlete.png": "1b7b29564f8841ab5dfffc1b224999a2",
"assets/assets/meusPictogrames/cacaolat.png": "930a0bce435e1e0f1cc7eb02b822d217",
"assets/assets/meusPictogrames/carles.jpg": "8313a75ad60527e5b7087cf88bfda4d6",
"assets/assets/meusPictogrames/carnPeix.png": "bc10eb34bea4a796a0c57e508bef91a5",
"assets/assets/meusPictogrames/casa.png": "4880a2421cf36b6c9cccffed2495c4ae",
"assets/assets/meusPictogrames/centreComercial.png": "3f980cc7aa98ae09de8f7fcab2f1a308",
"assets/assets/meusPictogrames/classe.png": "ad8541bc0f214091cb25e3b341fa947d",
"assets/assets/meusPictogrames/click.png": "5ffb36d246771a43aa2862c5d242d6ea",
"assets/assets/meusPictogrames/coc.png": "1efaf56315e504343a2010f972aaa30d",
"assets/assets/meusPictogrames/colorFormaMida.png": "b69b32e52abbbf466add3c2efe397b1c",
"assets/assets/meusPictogrames/comEstas.png": "e751c07e1fd97af9449d135f72ced5cc",
"assets/assets/meusPictogrames/compota.png": "c933240113a26d35cf6f8719cc9f59bb",
"assets/assets/meusPictogrames/contxi.png": "8de5488ae201b1de96872d5e4029b7cc",
"assets/assets/meusPictogrames/copy.png": "567c9a09c570295f08309cc51dbee60d",
"assets/assets/meusPictogrames/correfoc.png": "6901ae6c1d7f00e8cc78b5b3017af3e0",
"assets/assets/meusPictogrames/cosSalut.png": "9ac29a224dbceece804220086b6a79fc",
"assets/assets/meusPictogrames/del.png": "d2017dfff383408b499e906ee43b27e6",
"assets/assets/meusPictogrames/dijous.png": "967b3d2fb7bac8182ddbc623efde5f60",
"assets/assets/meusPictogrames/dilluns.png": "f1dea0886c6a570b8a260fba8cb63a65",
"assets/assets/meusPictogrames/dimarts.png": "720ddf0459c399c25e83f4f19310bd91",
"assets/assets/meusPictogrames/dimecres.png": "a1177443949e7905cd94799b4556cb66",
"assets/assets/meusPictogrames/dinar.png": "904e139aaa55f79d4e6731f531c39197",
"assets/assets/meusPictogrames/dissabte.png": "ed8f633cc1a48f6a9c1f6f52fa8a3b89",
"assets/assets/meusPictogrames/diumuenge.png": "43ae11d593e33d33cf57ac65dd203fbc",
"assets/assets/meusPictogrames/divendres.png": "256feea56b26d6d6e84226960f5c6172",
"assets/assets/meusPictogrames/dolc.png": "5ec77af4172ced87f79bf6a091e38099",
"assets/assets/meusPictogrames/dreta.png": "fc9b62a8bba768d13e67e38a74587a6d",
"assets/assets/meusPictogrames/emFaMal.png": "a84572e9f299a8ec07de9ac78f6eb93e",
"assets/assets/meusPictogrames/enganxar.png": "e8a7db3b5b69c8fa203cb7b644aeed03",
"assets/assets/meusPictogrames/engranatge.png": "bd5f8ec979f06ccd85e2295487b28192",
"assets/assets/meusPictogrames/esclairs.png": "e85ef34eb418c4fa6fa9d01f6b11d05b",
"assets/assets/meusPictogrames/escollir.png": "aaf1b38e46f0a443347d6adbbc19ea97",
"assets/assets/meusPictogrames/esperar.png": "9dcff1f103f6fe70be5ffa2ee967386d",
"assets/assets/meusPictogrames/esquerra.png": "ea2b726559e2401505b55969c309b798",
"assets/assets/meusPictogrames/esther.jpg": "559d9ae910a0ba1a91e42688f75eef73",
"assets/assets/meusPictogrames/fanta.png": "ee7bf94878ff10f870327eeb8d5d7db0",
"assets/assets/meusPictogrames/fer.png": "5eb4092392078f688439bc82de5adbb6",
"assets/assets/meusPictogrames/fred.png": "1e3bc955f58490a2cdfe94ae352e1d91",
"assets/assets/meusPictogrames/funciona.png": "c0f747b773211b41286dc58c1e9427ef",
"assets/assets/meusPictogrames/garatge.png": "b7dfb48be8a34b9e400c816536d3eabc",
"assets/assets/meusPictogrames/gracies.png": "8dd3d1e69893f33b30d0949e6310292a",
"assets/assets/meusPictogrames/guarnirArbre.png": "c8c0280c15c5ef0551a6c11b2be7b75d",
"assets/assets/meusPictogrames/home.png": "049d2aedc3f7abe47f2cf3a2ca5b2f54",
"assets/assets/meusPictogrames/horaDe.png": "b81917d0901250d9f1a6f5de51fb5078",
"assets/assets/meusPictogrames/iogurt.png": "3e31e439b999e62156b8b0acff5de174",
"assets/assets/meusPictogrames/joan.jpg": "ead11812b5f62ba2d439e7ff5e35935a",
"assets/assets/meusPictogrames/judit.jpg": "ad765ee34fa0ca275f2b01588e95f0b2",
"assets/assets/meusPictogrames/lilEinstein.png": "41b947e752bdaf40d6e058b0e2e5f930",
"assets/assets/meusPictogrames/mac.png": "04289e689c33cb00d9ef0ca9d49fcaaa",
"assets/assets/meusPictogrames/malDit.png": "47ef12fb34665e1cd71f9a2bd4d2eb79",
"assets/assets/meusPictogrames/malFerPipi.png": "65f97588da25dd6ec64c70981c704c84",
"assets/assets/meusPictogrames/malOrella.png": "4637a57b530ee3ae86295cb79ec70045",
"assets/assets/meusPictogrames/malPanxa.png": "d36185b7ebbabf7236d59867447fcd5f",
"assets/assets/meusPictogrames/marcos.png": "9e8b2843af44aeca04d45ba6671f0dd4",
"assets/assets/meusPictogrames/mato.png": "f2ac9c09970eee4be2b1a821c9f60360",
"assets/assets/meusPictogrames/metge.png": "30a878276abb29ffc133973474a64690",
"assets/assets/meusPictogrames/natalia.jpg": "ddf24f1cb106c4c7c97ba7e00d9ad81e",
"assets/assets/meusPictogrames/no.png": "00f860507c410de3e973364d8ab3d93b",
"assets/assets/meusPictogrames/nocilla.png": "cd04b3ce6c227763cea5923ce049eb78",
"assets/assets/meusPictogrames/noEntenem.png": "11cad5c004f6b635c3063773b0553334",
"assets/assets/meusPictogrames/noFunciona.png": "6ac5acf08c25db2de0a0aad02ae70e63",
"assets/assets/meusPictogrames/ouBalla.png": "c58b5cfe69f7be82be607dd1f523216b",
"assets/assets/meusPictogrames/paola.png": "e6b3a040048ff8ac51d4a9117df029eb",
"assets/assets/meusPictogrames/paRatllat.png": "8a8bdaed09550349c06d3a4c03a3eb0b",
"assets/assets/meusPictogrames/parcSama.png": "da9edcfd0300fa848e1040d3b60b26cf",
"assets/assets/meusPictogrames/parking.png": "2637f90bed9d4f65abf0504b99e372c2",
"assets/assets/meusPictogrames/pastForm.png": "c13303b05cdd596d94807500604f568b",
"assets/assets/meusPictogrames/persCol.png": "e36d358ab37d625849add6b1762b2a25",
"assets/assets/meusPictogrames/pilar.png": "74f40581cb0a1c1d06596da78728e872",
"assets/assets/meusPictogrames/pintar.png": "e649687d4ab2de29095d08aef6895816",
"assets/assets/meusPictogrames/play.png": "de4ad95083462db61198559007166d61",
"assets/assets/meusPictogrames/pluja.png": "ce311862ae29a43fc5235be4698057ec",
"assets/assets/meusPictogrames/pop.png": "01caf907bde7c59a5c3bafee25d1dc12",
"assets/assets/meusPictogrames/por.png": "489130cfe88c3bbf5701942817b94937",
"assets/assets/meusPictogrames/portAventura.png": "61b67a67560d99b25dcaec85285c448e",
"assets/assets/meusPictogrames/postre.png": "e4f776f0a41e8101b3e38af5b9ef02f7",
"assets/assets/meusPictogrames/puzzle.png": "ada421f1eaa7d4d5247f5d281d52cc61",
"assets/assets/meusPictogrames/recte.png": "a473a1258b8dbe0c6521106375b6bc67",
"assets/assets/meusPictogrames/restaurant.png": "b9c195ec15d851e1595b593254fe3b4e",
"assets/assets/meusPictogrames/retama.png": "c6d37a5e90d76d10e0dc3c0b2d73cd73",
"assets/assets/meusPictogrames/rollito.png": "c1fe1dda33f8728008ad16ebe0a3a9e7",
"assets/assets/meusPictogrames/rosa.png": "10b7d2cb99ef14fbd51cbe02564be470",
"assets/assets/meusPictogrames/salou.png": "b20aeeeab83d9286958a5350ab547a6c",
"assets/assets/meusPictogrames/santi.png": "bc94cb29e87ecd8aff3f0d3a1e7c0876",
"assets/assets/meusPictogrames/santiago.png": "d111ec8b4b803529c194b9c0e7826b6c",
"assets/assets/meusPictogrames/si.png": "8c08076d649cf8dd67f77390b1a03cd5",
"assets/assets/meusPictogrames/siUsPlau.png": "5f1d942ee54c5d1e25bd74957b796e55",
"assets/assets/meusPictogrames/stjordi.png": "6284deec10dd1f1358c9d5b3c75173fe",
"assets/assets/meusPictogrames/tabule.png": "e9f3f09fced3fd29929f40d443aa9a99",
"assets/assets/meusPictogrames/temps.png": "45359599ce1cd5cf8c2fa0a12aa696ac",
"assets/assets/meusPictogrames/thomas.png": "b73ec57e648e76f935ad9d5f92629067",
"assets/assets/meusPictogrames/toni.png": "8f06af2d66ac33c826c213211e7dcbfd",
"assets/assets/meusPictogrames/tortosa.png": "aae5450b0f4e54b547e859ebfde1de28",
"assets/assets/meusPictogrames/trineo.png": "55811162038fa73e93207f066eeb7dc3",
"assets/assets/meusPictogrames/undo.png": "aca1f20e734b40197b89f9d1fc7dcb12",
"assets/assets/meusPictogrames/ventosa.png": "1d34eea81fb589cf34ab747964c9c3a3",
"assets/assets/meusPictogrames/viena.png": "4eb9506e8ce1a50107b223fe6de8def9",
"assets/assets/meusPictogrames/voler.png": "c33d8f587bf0d8736ae4a86f261199ae",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "064e3d8bbd6345d611d2442235bd429f",
"assets/NOTICES": "b239e7c8265215689c71368b4d485d74",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "a4655c464f42d1a9d66a15e8eed85fcd",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "31a9473ef271a90c1c15e70a1b975430",
"/": "31a9473ef271a90c1c15e70a1b975430",
"main.dart.js": "2b14265b286db0f369af4f896c4a9094",
"manifest.json": "e99455810fadf79eef76633b17e3bc95",
"version.json": "e3ad3f3be7a27039c239228139d20e8e"};
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
