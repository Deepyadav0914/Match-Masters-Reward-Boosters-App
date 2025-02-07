import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reawrdapp/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:reawrdapp/AdPlugin/AdsGridView/ads_gridview.dart';
import '../../AdPlugin/Ads/FullScreen/Ads.dart';
import '../../AdPlugin/Ads/Native/NativeRN.dart';
import '../../generated/assets.dart';
import '../../main.dart';
import '../../model/gifmodel.dart';
import 'GifsController.dart';
import 'GifsDetail.dart';

class GifsScreen extends StatefulWidget {
  static const String routeName = '/GifsScreen';

  const GifsScreen({super.key});

  @override
  State<GifsScreen> createState() => _GifsScreenState();
}

class _GifsScreenState extends State<GifsScreen> {
  final controller = Get.put(GifsController());

  @override
  Widget build(BuildContext context) {
    final unlockGifs = box.read<Map<String, dynamic>>('unlockGifs') ?? {};
    print("unlockGifs == ${unlockGifs.length}");

    return GetBuilder<GifsController>(
      builder: (controller) {
        return BannerWrapper(
          parentContext: context,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              backgroundColor: Colors.blue,
              title: Text(
                'Top GIFs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27.r,
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        offset: Offset(1.r, 1.r),
                        blurRadius: 3.r)
                  ],
                  fontFamily: 'acme',
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10.r),
                  child: Container(
                    height: 36.r,
                    width: 100.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 3, color: Colors.white),
                      color: Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.imagesReward,
                          height: 25.r,
                        ),
                        5.horizontalSpace,
                        Obx(() => Text(
                              '${controller.totalCoins.value}',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'acme',
                                fontSize: 20.r,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Obx(() {
                return FutureBuilder<GifsModel>(
                  future: controller.gifsData.value,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.hexagonDots(
                          color: Colors.white,
                          size: 40.sp,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Failed to load data. Please try again.',
                              style: TextStyle(
                                fontSize: 16.r,
                                color: Colors.red.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            10.verticalSpace,
                            ElevatedButton(
                              onPressed: () => controller.retry(),
                              child: const Text("Retry"),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final allgifs = snapshot.data!.data;
                      print(allgifs.length);
                      box.write('totalgif', allgifs.length);

                      return SafeArea(
                        child: SizedBox(
                          height: (allgifs.length / 2).ceil() * 200.r,
                          // child: GridView.builder(
                          //
                          //
                          //   shrinkWrap: true,
                          //   physics:
                          //       const NeverScrollableScrollPhysics(),
                          //   gridDelegate:
                          //       SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 2,
                          //   ),
                          //   itemCount: allgifs.length,
                          //   itemBuilder: (context, index) {
                          //     String uniqueKey = "$index";
                          //     print("uniqueKey == $uniqueKey");
                          //
                          //     bool isLocked =
                          //         unlockGifs[uniqueKey] ?? false;
                          child: AdsGridView(
                            crossAxisCount: 2,
                            itemCount: allgifs.length,
                            adsIndex: 1,
                            adsWidget: NativeRN(parentContext: context),

                            itemPadding: EdgeInsets.all(10.r),
                            itemWidget: (BuildContext context, int index) {
                              String uniqueKey = "$index";
                              print("uniqueKey == $uniqueKey");
                              bool isLocked = unlockGifs[uniqueKey] ?? false;

                              return Padding(
                                padding:  EdgeInsets.only(right:6.r,left: 6.r,top: 5.r),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22.r),
                                    border: Border.all(
                                        width: 3.r, color: Colors.black),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(6.r, 6.r),
                                        blurRadius: 10.r,
                                      ),
                                    ],
                                  ),

                                  child: GestureDetector(
                                    onTap: () {
                                      AdsRN().showFullScreen(
                                          context: context,
                                          onComplete: () {
                                            Get.to(() => GifsDetailScreen(),
                                                arguments: {
                                                  'Gifs': allgifs[index]
                                                });
                                          });
                                    },
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18.r),
                                          border: Border.all(
                                              width: 3.r, color: Colors.black),
                                        ),
                                        margin: EdgeInsets.all(4.r),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.r),
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  LoadingAnimationWidget
                                                      .threeArchedCircle(
                                                color: Colors.black45,
                                                size: 20.sp,
                                              ),
                                              imageUrl:
                                                  allgifs[index].toString(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      isLocked
                                          ? SizedBox()
                                          : Positioned(
                                              top: 5.r,
                                              right: 5.r,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (controller
                                                          .totalCoins.value <
                                                      150) {
                                                    Get.snackbar(
                                                      "Not Enough Tokens",
                                                      "You need at least 150 tokens to unlock this GIF.",
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      duration: const Duration(
                                                          seconds: 3),
                                                      icon: Icon(
                                                          Icons.cancel_outlined,
                                                          color: Colors.white),
                                                      padding:
                                                          EdgeInsets.all(10.r),
                                                      margin:
                                                          EdgeInsets.all(10.r),
                                                      forwardAnimationCurve:
                                                          Curves.easeOutBack,
                                                      backgroundColor:
                                                          Colors.red,
                                                      colorText: Colors.white,
                                                    );

                                                    return;
                                                  }

                                                  setState(() {
                                                    unlockGifs[uniqueKey] =
                                                        true;
                                                    box.write("unlockGifs",
                                                        unlockGifs);
                                                  });

                                                  final gifsController =
                                                      Get.put(GifsController());
                                                  gifsController.unlockedGifs(
                                                      controller.rewardCoins);
                                                },
                                                child: Container(
                                                  height: 140.r,
                                                  width: 130.r,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        Assets.imagesLock,
                                                        height: 60.r,
                                                      ),
                                                      8.verticalSpace,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            Assets.imagesReward,
                                                            height: 28.r,
                                                          ),
                                                          4.horizontalSpace,
                                                          Text('150 Token',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'acme',
                                                                  fontSize:
                                                                      23.r,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
