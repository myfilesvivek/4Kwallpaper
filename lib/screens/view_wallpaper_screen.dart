import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/controllers/wallpaper_controller.dart';

import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/providers/ad_provider.dart';

import 'package:wallpaper_app/widgets/view_wallpaper_back_button.dart';
import 'package:wallpaper_app/widgets/view_wallpaper_main_button.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class ViewWallpaperScreen extends StatefulWidget {
  final WallpaperData wallpaperModel;
  final Image image;

  ViewWallpaperScreen({required this.wallpaperModel, required this.image});

  @override
  _ViewWallpaperScreenState createState() => _ViewWallpaperScreenState();
}

class _ViewWallpaperScreenState extends State<ViewWallpaperScreen>
    with SingleTickerProviderStateMixin {
  List<Color> colorList = [
    Color(0xff338ee3),
    Color(0xFF0055D5),
    // Color(0xFF00DF82),
    Color(0xff45e8a4),
  ];
  List<Alignment> alignmentList = [
    Alignment.topCenter,
    Alignment.bottomCenter,
  ];
  int index = 0;
  Color bottomColor = Color(0xff338ee3);
  Color topColor = Color(0xff45e8a4);
  Color defaultColor = Color(0xff68516d);
  Alignment begin = Alignment.topCenter;
  Alignment end = Alignment.bottomCenter;

  // bool isLiked = false;
  bool isDownloading = false;

  bool isApplying = false;

  late AnimationController _controller;

  late double _scale;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        lowerBound: 0.0,
        upperBound: 0.5)
      ..addListener(() {
        setState(() {});
      });

    super.initState();

    interstitialVideoAdLoad();
  }

  bool hideScreenWidget = true;

  InterstitialAd? _interstitialAd;

  int _numInterstitialLoadAttempts = 0;

  InterstitialAd? _interstitialAdCount;

  void interstitialVideoAdLoad() async {
    await InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/8691691433",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            this._interstitialAd = ad;
            //this._interstitialAd!.show();
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;

            if (_numInterstitialLoadAttempts <= 3) {
              interstitialVideoAdLoad();
            }
          },
        ));

    // HomeScreen.counter++;

    // print(HomeScreen.counter);
    // if (HomeScreen.counter == 3) {
    //   print("##############");
    //   HomeScreen.counter = 0;

    //   showInterstitialAd();
    // }
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');

        ad.dispose();
        interstitialVideoAdLoad();
        //  _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();

        //   _createInterstitialAd();
        interstitialVideoAdLoad();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;

    // interstitialAdLoad();
  }

  @override
  void dispose() {
    if (_interstitialAd != null) {
      _interstitialAd!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  interstitialAdLoadLike();
    var adProvider = Get.put(AdProvider());
    var wallProvider = Get.put(WallPaperController());
    
    adProvider.interstitialAdLoadLike();
    adProvider.interstitialAdLoadApplyWallpaper();

    final _database = FirebaseDatabase.instance.reference();

    var likeController = Get.put(WallPaperController());

    _scale = 1 - _controller.value;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          GestureDetector(
              onLongPress: () {
                setState(() {
                  hideScreenWidget = !hideScreenWidget;
                });
              },
              onLongPressEnd: (d) {
                setState(() {
                  hideScreenWidget = !hideScreenWidget;
                });
              },
              child: Hero(
                tag: "wall${widget.wallpaperModel.id}",
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: widget.image),
              )

              // ProgressiveImage(
              //   fit: BoxFit.cover,
              //   placeholder: AssetImage('assets/gif/shimmereffect.gif'),
              //   // size: 1.87KB
              //   thumbnail: NetworkImage(widget.wallpaperModel.imageURLLow!),
              //   // size: 1.29MB
              //   image: NetworkImage(widget.wallpaperModel.getImgUrl),
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              // ),
              ),
          isApplying
              ? Center(
                  child: Image.asset(
                  'assets/gif/loadingsetwallpaper.gif',
                  width: 80,
                  height: 80,
                ))
              : Container(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    child: hideScreenWidget
                        ? ViewWallpaerBackButton()
                        : Container()),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: hideScreenWidget
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  requestPermission();

                                  if (adProvider.isLikePageAdLoaded) {
                                    adProvider.fullPageLikeAd.show();
                                  }

                                  if (widget.wallpaperModel.isFavorite.value ==
                                      false) {
                                    bool isadd = likeController
                                        .addItem(widget.wallpaperModel.id);
                                    //if (isadd) showInterstitialAdLike();
                                  } else {
                                    bool isrev = likeController
                                        .removeItem(widget.wallpaperModel.id);

                                    //if (isrev) showInterstitialAdLike();
                                  }
                                },
                                child: Transform.scale(
                                  scale: _scale,
                                  child: ViewWallpaerMainButton(
                                    icon: widget.wallpaperModel.isFavorite
                                                .value ==
                                            false
                                        ? 'assets/images/heart.png'
                                        : 'assets/images/heart_filled.png',
                                    text: "Like",
                                    //  color: Color(0xff68516d),
                                    color: Colors.white,
                                    // iconColor: Color(0xffb9a3bd)
                                    hight: 55,
                                    width: 55,
                                    padding: 0,
                                  ),
                                ),
                                onTapUp: _onTapUp,
                                onTapDown: _onTapDown,
                              ),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      playGradiantAnim();
                                      await _downloadwallpaper(context).then((value) {

                                        wallProvider.updateWallpaperDownload(widget.wallpaperModel.id);
                                      });

                                      // _database
                                      //     .child("images")
                                      //     .child(widget
                                      //         .wallpaperModel.wallpaperKey!)
                                      //     .update({
                                      //   "downloads": ServerValue.increment(1)
                                      // });

                                      // if (_interstitialAd == null) {
                                      //   interstitialAdLoad();
                                      // } else {
                                      //   print('Interstital present');
                                      // }

                                      showInterstitialAd();
                                    },
                                    child: AnimatedContainer(
                                      height: 55,
                                      width: 55,
                                      padding: EdgeInsets.all(15),
                                      duration: Duration(milliseconds: 500),
                                      child: Image.asset(
                                        'assets/images/download-arrow.png',
                                        height: 35,
                                        width: 35,
                                        color: isDownloading
                                            ? Colors.white
                                            : Color(0xffb9a3bd),
                                      ),
                                      onEnd: playOnEndAnim,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: begin,
                                              end: end,
                                              colors: isDownloading
                                                  ? [topColor, bottomColor]
                                                  : [
                                                      defaultColor,
                                                      defaultColor
                                                    ])),
                                    )),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  isDownloading ? "Downloading..." : "Download",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'MuseoSans',
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),

                            // isDownloading
                            //     ? AnimatedGradient(() {})
                            //     : InkWell(
                            //         onTap: () async {
                            //           await _downloadwallpaper(context);
                            //         },
                            //         child: ViewWallpaerMainButton(
                            //           icon: 'assets/images/download-arrow.png',
                            //           text: "Download",
                            //           color: Color(0xff68516d),
                            //           iconColor: Color(0xffb9a3bd),
                            //           width: 25,
                            //           hight: 25,
                            //           padding: 15,
                            //         ),
                            //       ),
                            GestureDetector(
                              onTap: () async {
                                await setWallpaper(
                                    context, widget.wallpaperModel.url);

                                //  showInterstitialAdLike();
                                if (adProvider.isApplyWallpaperPageAdLoaded) {
                                  adProvider.fullPageApplyWallpaperAd.show();
                                }
                              },
                              child: ViewWallpaerMainButton(
                                icon: 'assets/images/paintroller.png',
                                text: "Apply",
                                showGrad: true,
                                color: Colors.white,
                                iconColor: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  Future<void> setWallpaper(BuildContext context, String url) async {
    var actionSheet = CupertinoActionSheet(
      title: Text('Set as'),
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                isApplying = true;
              });
              Navigator.of(context).pop(SetWallpaerAs.Home);
            },
            child: Text('Home')),
        CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                isApplying = true;
              });
              Navigator.of(context).pop(SetWallpaerAs.Lock);
            },
            child: Text('Lock')),
        CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                isApplying = true;
              });
              Navigator.of(context).pop(SetWallpaerAs.Both);
            },
            child: Text('Both')),
      ],
    );

    SetWallpaerAs option = await showCupertinoModalPopup(
        context: context, builder: (context) => actionSheet);

    var cachedImage = await DefaultCacheManager().getSingleFile(url);

    if (option != null) {
      WallpaperManagerFlutter()
          .setwallpaperfromFile(cachedImage, _setAs[option] ?? 1)
          .then((value) {
        Get.snackbar("Wallpaper set succefully", "",
            backgroundColor: lgGreen,
            colorText: darkGreen,
            borderWidth: 1,
            borderColor: darkGreen);

        setState(() {
          isApplying = false;
        });
      });
    }
    try {
      // print('Wallpaper Updated.... $result');
    } on PlatformException catch (e) {
      print("Failed to Set Wallpaper: '${e.message}'.");
      setState(() {
        isApplying = false;
      });
    }
  }

  Future<void> _downloadwallpaper(BuildContext context) async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      try {
        setState(() {
          isDownloading = !isDownloading;
        });

        var imageId = await ImageDownloader.downloadImage(
                widget.wallpaperModel.url,
                destination: AndroidDestinationType.directoryPictures)
            .then((value) {
          setState(() {
            isDownloading = false;
          });

          

          Get.snackbar("Download completed.", "",
          
              backgroundColor: Colors.white,
              mainButton: TextButton(
                  onPressed: () async {
                    var path = await ImageDownloader.findPath(value!);
                    await ImageDownloader.open(path!);
                  },
                  child: Text("Open")));
        }).catchError((error) {
          setState(() {
            isDownloading = false;
          });
          print(error);
        });
      } on PlatformException catch (error) {
        print(error);
        setState(() {
          isDownloading = false;
        });
      }
    } else {
      _showOpenSettingAlert(context);
    }
  }

  Future<dynamic> _showOpenSettingAlert(BuildContext context) {
    return Get.defaultDialog(
        title: "Need access to storage. ",
        middleText: "",
        actions: [
          TextButton(
              onPressed: () {
                openAppSettings();
              },
              child: Text('Open settings')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'))
        ]);
  }

  void playOnEndAnim() {
    setState(() {
      index = index + 1;
      // animate the color
      bottomColor = colorList[index % colorList.length];
      topColor = colorList[(index + 1) % colorList.length];

      //// animate the alignment
      // begin = alignmentList[index % alignmentList.length];
      // end = alignmentList[(index + 2) % alignmentList.length];
    });
  }

  void playGradiantAnim() {
    return setState(() {
      bottomColor = Colors.blue;
    });
  }
}

enum SetWallpaerAs { Home, Lock, Both }

var _setAs = {
  SetWallpaerAs.Home: WallpaperManagerFlutter.HOME_SCREEN,
  SetWallpaerAs.Lock: WallpaperManagerFlutter.LOCK_SCREEN,
  SetWallpaerAs.Both: WallpaperManagerFlutter.BOTH_SCREENS,
};

void requestPermission() async {
  var status = await Permission.storage.status;

  if (!status.isGranted) {
    await Permission.storage.request();
  }

  // var status1 = await Permission.manageExternalStorage.status;

  //  if(!status.isGranted){

  //   await Permission.manageExternalStorage.request();

  // }
}
