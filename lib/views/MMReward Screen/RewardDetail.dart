import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reawrdapp/AdPlugin/Ads/Banner/BannerWrapper.dart';
import '../../main.dart';
import '../Gifs Screen/GifsController.dart';
import 'RewardDetailController.dart';

class RewardDetailScreen extends StatefulWidget {
  static const String routeName = '/RewardDetailScreen';

  const RewardDetailScreen({super.key});

  @override
  State<RewardDetailScreen> createState() => _RewardDetailScreenState();
}

class _RewardDetailScreenState extends State<RewardDetailScreen> {
  final RewardDetailController controller = Get.put(RewardDetailController());

  @override
  Widget build(BuildContext context) {
    final claimedRewards =
        box.read<Map<String, dynamic>>('claimedRewards') ?? {};
    print("is claimed == ${claimedRewards.length}");
    print("is claimed == ${claimedRewards}");

    String uniqueKey =
        "${controller.title}_${controller.date}_${controller.index}";
    print("uniqueKey == ${uniqueKey}");

    bool isClaime = claimedRewards[uniqueKey] ?? false;
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
            'MM Reward',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.r,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
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
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 15.r),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/reward.png',
                        height: 150.r,
                        fit: BoxFit.fill,
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      controller.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                        fontSize: 22.r,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.black, thickness: 3),
                    Text(
                      controller.formattedDate,
                      style: TextStyle(
                        fontSize: 22.r,
                        fontFamily: 'OpenSans',
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    20.verticalSpace,
                    Text(
                      controller.description,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 22.r,
                        fontFamily: 'OpenSans',
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          isClaime ? 'Claimed' : 'Claim',
                          isClaime
                              ? null
                              : () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: Text('Confirm Claim'),
                                      content: Text(
                                          'Are you sure you want to claim this reward?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              claimedRewards[uniqueKey] = true;
                                              box.write("claimedRewards",
                                                  claimedRewards);
                                            });

                                            final gifsController =
                                                Get.put(GifsController());
                                            gifsController.collectCoins(
                                                controller.rewardCoins);

                                            Get.back();
                                            Get.snackbar(
                                              "Success!",
                                              "You have collected ${controller.rewardCoins} coins!",
                                              snackPosition: SnackPosition.TOP,
                                              icon: Icon(Icons.done_outline,
                                                  color: Colors.white),
                                              duration:
                                                  const Duration(seconds: 3),
                                              padding: EdgeInsets.all(10.r),
                                              margin: EdgeInsets.all(10.r),
                                              backgroundColor: Colors.green,
                                              forwardAnimationCurve:
                                                  Curves.easeOutBack,
                                              colorText: Colors.white,
                                            );
                                          },
                                          child: Text('Claim'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                        ),
                        15.horizontalSpace,
                        _buildActionButton('Share', () {}),
                      ],
                    ),
                    15.verticalSpace,
                    Text(
                      'Note: After claiming your reward, you will be automatically redirected to the match Masters game. Enjoy your rewards and happy gaming!',
                      style: TextStyle(
                        fontSize: 22.r,
                        fontFamily: 'OpenSans',
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback? onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(width: 3.r, color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(6.r, 6.r),
            blurRadius: 10.r,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 6.r),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(width: 3.r, color: Colors.black),
          ),
          margin: EdgeInsets.all(4.r),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r, horizontal: 30.r),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 24.r,
                  fontFamily: 'OpenSans',
                  color: onPressed == null ? Colors.grey : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
