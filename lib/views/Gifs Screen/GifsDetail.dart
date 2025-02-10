import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reawrdapp/AdPlugin/Ads/Banner/BannerWrapper.dart';
import '../../AdPlugin/Ads/FullScreen/Ads.dart';
import 'GifsDetailController.dart';

class GifsDetailScreen extends StatelessWidget {
  static const String routeName = '/GifsDetailScreen';

  GifsDetailScreen({super.key});

  final controller = Get.put(GifsDetailController());

  @override
  Widget build(BuildContext context) {
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
            'Sticker Download',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27.r,
              fontFamily: 'acme',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.r),
                      child: CachedNetworkImage(
                        placeholder: (context, url) {
                          return LoadingAnimationWidget.threeArchedCircle(
                            color: Colors.black45,
                            size: 40.sp,
                          );
                        },
                        imageUrl: controller.stricker,
                        height: 300.r,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.r),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28.r),
                      border: Border.all(width: 3.r, color: Colors.black),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(6.r, 6.r),
                          blurRadius: 15.r,
                        ),
                      ],
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 5.r, horizontal: 5.r),
                    child: GestureDetector(
                      onTap: () => AdsRN().showFullScreen(
                          context: context,
                          onComplete: () {
                            controller.saveGif();
                          }),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(width: 3.r, color: Colors.black),
                        ),
                        margin: EdgeInsets.all(4.r),
                        padding: EdgeInsets.only(bottom: 5.r),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.download,
                                  size: 30.r,
                                  color: Colors.blue,
                                ),
                                10.horizontalSpace,
                                Text(
                                  'Download',
                                  style: TextStyle(
                                    fontSize: 25.r,
                                    fontFamily: 'acme',
                                    color: Colors.blue,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
