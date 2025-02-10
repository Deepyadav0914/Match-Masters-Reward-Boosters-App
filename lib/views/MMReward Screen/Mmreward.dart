import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reawrdapp/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:reawrdapp/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:reawrdapp/AdPlugin/Ads/Native/NativeRN.dart';
import '../../generated/assets.dart';
import '../../main.dart';
import 'MmrewardController.dart';
import 'RewardDetail.dart';

class MmrewardScreen extends StatefulWidget {
  static const String routeName = '/MmrewardScreen';

  const MmrewardScreen({super.key});

  @override
  State<MmrewardScreen> createState() => _MmrewardScreenState();
}

class _MmrewardScreenState extends State<MmrewardScreen> {
  final controller = Get.put(MmrewardController());

  @override
  Widget build(BuildContext context) {
    return BannerWrapper(
      parentContext: context,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          title: Text(
            'MM Reward',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27.r,
              fontFamily: 'acme',
              shadows: [
                Shadow(
                    color: Colors.black,
                    offset: Offset(1.r, 1.r),
                    blurRadius: 3.r)
              ],
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: LoadingAnimationWidget.hexagonDots(
                  color: Colors.white,
                  size: 40.sp,
                ),
              );
            } else {
              final groupedData = <String, List>{};
              for (var item in controller.rewardData.value.data) {
                final date = controller.formatDate(int.parse(item.date));
                if (groupedData.containsKey(date)) {
                  groupedData[date]!.add(item);
                } else {
                  groupedData[date] = [item];
                }
              }
              final claimedRewards =
                  box.read<Map<String, dynamic>>('claimedRewards') ?? {};
              print('msg==$claimedRewards');

              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: groupedData.keys.length,
                itemBuilder: (context, index) {
                  final date = groupedData.keys.elementAt(index);
                  final data = groupedData.values.elementAt(index);

                  return Column(
                    children: [
                      date == '07-02-2025'
                          ? NativeRN(parentContext: context)
                          : SizedBox(),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'acme',
                          shadows: [
                            Shadow(
                                color: Colors.white,
                                offset: Offset(1.r, 1.r),
                                blurRadius: 3.r)
                          ],
                          fontSize: 25.r,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: (data.length / 2).ceil() * 200.r,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 14.r, horizontal: 10.r),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final reward = data[index];

                              String rewardKey =
                                  "${reward.title}_${date}_$index";
                              print("rewardKey == $rewardKey");

                              controller.isClaimed.value =
                                  claimedRewards[rewardKey] ?? false;

                              return Container(
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
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.r, horizontal: 5.r),
                                child: GestureDetector(
                                  onTap: () {
                                    AdsRN().showFullScreen(
                                      context: context,
                                      onComplete: () {
                                        Get.to(() => RewardDetailScreen(),
                                            arguments: {
                                              'data': reward,
                                              'date': date,
                                              'index': index
                                            })?.then(
                                          (_) {
                                            setState(() {});
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.r),
                                      border: Border.all(
                                          width: 3.r, color: Colors.black),
                                    ),
                                    margin: EdgeInsets.all(4.r),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 5.r,
                                                offset: Offset(4.r, 3.r),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 5.r),
                                            child: Image.asset(
                                              Assets.imagesReward,
                                              height: 45.r,
                                            ),
                                          ),
                                        ),
                                        7.verticalSpace,
                                        Text(
                                          reward.title,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'acme',
                                            fontSize: 18.r,
                                            shadows: [
                                              Shadow(
                                                  color: Colors.black38,
                                                  offset: Offset(1.r, 1.r),
                                                  blurRadius: 3.r)
                                            ],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 7.r),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              textStyle: TextStyle(
                                                fontSize: 18.r,
                                                fontFamily: 'acme',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: null,
                                            child: Text(
                                              controller.isClaimed.value
                                                  ? 'Claimed'
                                                  : 'Claim',
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
