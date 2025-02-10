import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reawrdapp/AdPlugin/Ads/Banner/BannerWrapper.dart';
import '../../generated/assets.dart';
import '../../main.dart';
import '../Gifs Screen/GifsController.dart';
import 'package:reawrdapp/AdPlugin/Ads/Native/NativeRN.dart';
import 'StatisticsController.dart';

class StatisticsScreen extends StatefulWidget {
  static const String routeName = '/StatisticsScreen';

  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final gifsController = Get.put(GifsController());
  final controller = Get.put((Statisticscontroller));

  @override
  Widget build(BuildContext context) {
    // Total Time Reward Collected
    final claimedRewards =
        box.read<Map<String, dynamic>>('claimedRewards') ?? {};
    print("is claimed == ${claimedRewards.length}");

    // Total Time Unlocked GIFs
    final unlockGifs = box.read<Map<String, dynamic>>('unlockGifs') ?? {};
    print("unlockGifs == ${unlockGifs.length}");

    // Total GIFs
    final totalgif = box.read("totalgif");
    print("count == ${totalgif}");

    return BannerWrapper(
      parentContext: context,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          title: Text(
            'Statistics',
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
          child: SafeArea(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount:
                  MenuList.menuList.length + 1, // Extra count for NativeRN
              padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 15.r),
              itemBuilder: (context, index) {
                if (index == 2) {
                  // Show NativeRN ad between items
                  return NativeRN(parentContext: context);
                }

                // Adjust index to skip the NativeRN spot
                final adjustedIndex = index > 2 ? index - 1 : index;
                var menulist = MenuList.menuList[adjustedIndex];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(width: 3.r, color: Colors.black),
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
                      border: Border.all(width: 3.r, color: Colors.black),
                    ),
                    margin: EdgeInsets.all(4.r),
                    child: ListTile(
                      title: Column(
                        children: [
                          Center(
                            child: Text(
                              menulist.name.toString(),
                              style: TextStyle(
                                fontFamily: 'acme',
                                fontSize: 25.r,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 3.r,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              menulist.name == 'Unlocked GIFs'
                                  ? Image.asset(
                                      Assets.imagesGif,
                                      height: 28.r,
                                    )
                                  : Image.asset(
                                      Assets.imagesReward,
                                      height: 28.r,
                                    ),
                              10.horizontalSpace,
                              menulist.name == 'Unlocked GIFs'
                                  ? Text(
                                      '${unlockGifs.length} / $totalgif',
                                      style: TextStyle(
                                        fontFamily: 'acme',
                                        fontSize: 25.r,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    )
                                  : menulist.name == 'Token Available'
                                      ? Text(
                                          '${gifsController.totalCoins.value}',
                                          style: TextStyle(
                                            fontFamily: 'acme',
                                            fontSize: 25.r,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        )
                                      : menulist.name ==
                                              'Total Time Reward Collected'
                                          ? Text(
                                              '${claimedRewards.length}',
                                              style: TextStyle(
                                                fontFamily: 'acme',
                                                fontSize: 25.r,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            )
                                          : const SizedBox(),
                            ],
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
      ),
    );
  }
}

class StatisticsList {
  final String name;

  StatisticsList({required this.name});
}

class MenuList {
  static final menuList = [
    StatisticsList(name: 'Unlocked GIFs'),
    StatisticsList(name: 'Token Available'),
    StatisticsList(name: 'Total Time Reward Collected'),
  ];
}
