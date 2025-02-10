import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reawrdapp/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:reawrdapp/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:reawrdapp/AdPlugin/Ads/Native/NativeRN.dart';
import 'package:reawrdapp/generated/assets.dart';
import '../../api/menuapi.dart';
import '../Data Screen/Data.dart';
import '../Gifs Screen/Gifs.dart';
import '../Gifs Screen/GifsController.dart';
import '../MMReward Screen/Mmreward.dart';
import '../Setting Screen/Setting.dart';
import '../Statistics Screen/Statistics.dart';
import 'MainMenuController.dart';

class MenuScreen extends StatelessWidget {
  static const String routeName = '/MenuScreen';

  MenuScreen({super.key});

  final controller = Get.put(MainMenuController());

  @override
  Widget build(BuildContext context) {
    return BannerWrapper(
      parentContext: context,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Text(
                  "Main Menu",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'acme',
                    fontSize: 30.r,
                    shadows: [
                      Shadow(
                          color: Colors.white,
                          offset: Offset(2.r, 1.r),
                          blurRadius: 3.r)
                    ],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.verticalSpace,
                FutureBuilder(
                  future: ApiCall().fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: MenuList.menuList.length,
                          padding: EdgeInsets.symmetric(
                              vertical: 15.r, horizontal: 15.r),
                          itemBuilder: (context, index) {
                            var alldata = snapshot.data;
                            var menulist = MenuList.menuList[index];
                            return Column(
                              children: [
                                index == 1
                                    ? NativeRN(parentContext: context)
                                    : SizedBox(),
                                Container(
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
                                  margin: EdgeInsets.symmetric(vertical: 10.r),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.r),
                                      border: Border.all(
                                          width: 3.r, color: Colors.black),
                                    ),
                                    margin: EdgeInsets.all(4.r),
                                    padding: EdgeInsets.all(6.r),
                                    child: ListTile(
                                      onTap: () {
                                        if (index == 8) {
                                          Get.to(() => const SettingScreen());
                                        } else {
                                          AdsRN().showFullScreen(
                                            context: context,
                                            onComplete: () {
                                              if (index == 0) {
                                                Get.to(() => MmrewardScreen());
                                              } else if (index == 1) {
                                                Get.to(() => GifsScreen(),
                                                    binding:
                                                        BindingsBuilder(() {
                                                  Get.put(GifsController());
                                                }));
                                              } else if (index == 2 ||
                                                  index == 3) {
                                                Get.to(() => DataScreen(),
                                                    arguments: {
                                                      'data':
                                                          alldata![index + 1]
                                                              .data,
                                                      'name': alldata[index + 1]
                                                          .name
                                                    });
                                              } else if (index == 4) {
                                                Get.to(() =>
                                                     StatisticsScreen());
                                              } else if (index == 5 ||
                                                  index == 6) {
                                                Get.to(() => DataScreen(),
                                                    arguments: {
                                                      'data':
                                                          alldata![index - 4]
                                                              .data,
                                                      'name': alldata[index - 4]
                                                          .name
                                                    });
                                              } else if (index == 7) {
                                                Get.to(() => DataScreen(),
                                                    arguments: {
                                                      'data':
                                                          alldata![index - 7]
                                                              .data,
                                                      'name': alldata[index - 7]
                                                          .name
                                                    });
                                              }
                                            },
                                          );
                                        }

                                        // print();
                                        // if (index == 8) {
                                        //   Get.toNamed(SettingScreen.routeName);
                                        // } else {
                                        //   // 'downloadBtn'.performScreenAction(context: context, onComplete: () {
                                        //   //
                                        //   // },)
                                        //   AdsRN().showFullScreen(
                                        //     context: context,
                                        //     onComplete: () {
                                        //       if (index == 0) {
                                        //         Get.toNamed(
                                        //             MmrewardScreen.routeName);
                                        //       } else if (index == 1) {
                                        //         Get.toNamed(
                                        //           GifsScreen.routeName,
                                        //         );
                                        //       } else if (index == 2) {
                                        //         print(
                                        //             'tips-tricks == ${alldata![index + 1].name}');
                                        //         Get.toNamed(
                                        //             DataScreen.routeName,
                                        //             arguments: {
                                        //               'data':
                                        //                   alldata![index + 1]
                                        //                       .data,
                                        //               'name': alldata[index + 1]
                                        //                   .name
                                        //             });
                                        //       } else if (index == 3) {
                                        //         print(
                                        //             'FAQ== ${alldata![index + 1].name}');
                                        //         Get.toNamed(
                                        //             "",
                                        //             arguments: {
                                        //               'data':
                                        //                   alldata![index + 1]
                                        //                       .data,
                                        //               'name': alldata[index + 1]
                                        //                   .name
                                        //             });
                                        //       } else if (index == 4) {
                                        //         Get.toNamed(
                                        //             StatisticsScreen.routeName);
                                        //       } else if (index == 5) {
                                        //         print(
                                        //             'modifier== ${alldata![index - 4].name}');
                                        //         Get.toNamed(
                                        //             DataScreen.routeName,
                                        //             arguments: {
                                        //               'data':
                                        //                   alldata![index - 4]
                                        //                       .data,
                                        //               'name': alldata[index - 4]
                                        //                   .name
                                        //             });
                                        //       } else if (index == 6) {
                                        //         print(
                                        //             ' ${alldata![index - 4].name}');
                                        //         Get.toNamed(
                                        //             DataScreen.routeName,
                                        //             arguments: {
                                        //               'data':
                                        //                   alldata![index - 4]
                                        //                       .data,
                                        //               'name': alldata[index - 4]
                                        //                   .name
                                        //             });
                                        //       } else if (index == 7) {
                                        //         print(
                                        //             'mode== ${alldata![index - 7].name}');
                                        //         Get.toNamed(
                                        //             DataScreen.routeName,
                                        //             arguments: {
                                        //               'data':
                                        //                   alldata![index - 7]
                                        //                       .data,
                                        //               'name': alldata[index - 7]
                                        //                   .name
                                        //             });
                                        //       }
                                        //     },
                                        //   );
                                        // }
                                      },
                                      leading: Image(
                                        image: AssetImage(menulist.images),
                                        height: 50.r,
                                      ),
                                      title: Text(
                                        menulist.name.toString(),
                                        style: TextStyle(
                                          fontFamily: 'acme',
                                          fontSize: 30.r,
                                          shadows: [
                                            Shadow(
                                                color: Colors.white,
                                                offset: Offset(2.r, 1.r),
                                                blurRadius: 3.r)
                                          ],
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddListtile {
  final String images;
  final String name;

  AddListtile({required this.images, required this.name});
}

class MenuList {
  static final menuList = [
    AddListtile(images: Assets.imagesReward, name: 'MM Rewards'),
    AddListtile(images: Assets.imagesGif, name: 'Top GIFs'),
    AddListtile(images: Assets.imagesBook, name: 'Tips & Tricks'),
    AddListtile(images: Assets.imagesFaq, name: 'Latest FAQs'),
    AddListtile(images: Assets.imagesStats, name: 'Statistics'),
    AddListtile(images: Assets.imagesModifiers, name: 'Modifiers'),
    AddListtile(images: Assets.imagesStudios, name: 'Studios'),
    AddListtile(images: Assets.imagesModes, name: 'Modes'),
    AddListtile(images: Assets.imagesSetting, name: 'Settings'),
  ];
}
