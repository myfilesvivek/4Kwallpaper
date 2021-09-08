

// class AdMobService {
//  // static String get interstitalAd => "ca-app-pub-3940256099942544/8691691433";

//   InterstitialAd? _interstitialAd;
//   int _numInterstitialLoadAttempts = 0;


//     void interstitialAdLoad() async{
//    await InterstitialAd.load(
//         adUnitId: "ca-app-pub-3940256099942544/8691691433",
//         request: AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             print('$ad loaded');
//             this._interstitialAd = ad;
//             _numInterstitialLoadAttempts = 0;
//            // _interstitialAd!.setImmersiveMode(true);
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('InterstitialAd failed to load: $error.');
//             _numInterstitialLoadAttempts +1;
//             _interstitialAd = null;
//             if (_numInterstitialLoadAttempts <= 2) {
//               interstitialAdLoad(); 
//             }
//           },
//         ));
//   }

//     void showInterstitialAd() {
  

//     if (_interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
       
//         ad.dispose();
//       //  _createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
    
//      //   _createInterstitialAd();
//      interstitialAdLoad();
//       },
//     );
//     _interstitialAd!.show();
//     _interstitialAd = null;

//     interstitialAdLoad();
//   }


//   // static initialize() {
//   //   if (MobileAds.instance == null) {
//   //     MobileAds.instance.initialize();
//   //   }
//   // }


 
// }
