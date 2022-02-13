import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaper_app/services/AdHepler.dart';

class AdProvider extends GetxController {
  bool isLikePageAdLoaded = false;
  late InterstitialAd fullPageLikeAd;

   bool isApplyWallpaperPageAdLoaded = false;
  late InterstitialAd fullPageApplyWallpaperAd;

  void interstitialAdLoadLike() async {
    await InterstitialAd.load(
        adUnitId: AdHelper.likeButtonBanner(),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            fullPageLikeAd = ad;
            isLikePageAdLoaded = true;

            //this._interstitialAd!.show();
            // _numInterstitialLoadAttempts = 0;
            // _interstitialAdLike!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            isLikePageAdLoaded = false;

            // _numInterstitialLoadAttempts += 1;
            // _interstitialAdLike = null;
            // if (_numInterstitialLoadAttempts <= 3) {
            //   interstitialAdLoadLike();
            // }
          },
        ),);
        update();
  }


 void interstitialAdLoadApplyWallpaper() async {
    await InterstitialAd.load(
        adUnitId: AdHelper.applyButtonBanner(),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            fullPageApplyWallpaperAd = ad;
            isApplyWallpaperPageAdLoaded = true;

            //this._interstitialAd!.show();
            // _numInterstitialLoadAttempts = 0;
            // _interstitialAdLike!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            isApplyWallpaperPageAdLoaded = false;

            // _numInterstitialLoadAttempts += 1;
            // _interstitialAdLike = null;
            // if (_numInterstitialLoadAttempts <= 3) {
            //   interstitialAdLoadLike();
            // }
          },
        ),);
        update();
  }


}
