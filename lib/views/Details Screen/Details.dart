import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reawrdapp/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'DetailscreenController.dart';

class Detailscreen extends StatelessWidget {
  static const String routeName = '/Detailscreen';

  Detailscreen({super.key});

  final controller = Get.put(DetailscreenController());

  @override
  Widget build(BuildContext context) {
    // Set the title based on the item data
    if (controller.item!.title != null) {
      controller.item!.title = controller.item!.title;
    } else if (controller.item!.name != null) {
      controller.item!.title = '';
    }

    return BannerWrapper(
      parentContext: context,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          title: Text(
            controller.item!.name == null
                ? "Details"
                : controller.item!.name.toString(),
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
              child: Column(
                children: [
                  10.verticalSpace,
                  controller.item!.image == ""
                      ? SizedBox()
                      : Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Center(
                            child: Image.network(
                              controller.item!.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                  controller.item!.name == "" &&
                          controller.item!.name == "" &&
                          controller.item!.title == ""
                      ? SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.r),
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.r, right: 20.r),
                                  child: Text(
                                    controller.item!.title.toString(),
                                    style: TextStyle(
                                        fontSize: 27.r,
                                        fontFamily: 'acme',
                                        color: Colors.black87,
                                        shadows: [
                                          Shadow(
                                              color: Colors.white,
                                              offset: Offset(2.r, 1.r),
                                              blurRadius: 4.r)
                                        ],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              controller.item!.title != ''
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.r,
                                          right: 15.r,
                                          bottom: 15.r),
                                      child: Divider(
                                        color: Colors.black,
                                        thickness: 3.r,
                                      ),
                                    )
                                  : SizedBox(),
                              controller.item!.title == ''
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.r),
                                      child: Text(
                                        controller.item!.description,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25.r,
                                            fontFamily: 'acme',
                                            color: Colors.black87,
                                            shadows: [
                                              Shadow(
                                                  color: Colors.white,
                                                  offset: Offset(2.r, 1.r),
                                                  blurRadius: 4.r)
                                            ],
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  : Text(
                                      controller.item!.description,
                                      style: TextStyle(
                                          fontSize: 25.r,
                                          fontFamily: 'acme',
                                          color: Colors.black87,
                                          shadows: [
                                            Shadow(
                                                color: Colors.white,
                                                offset: Offset(2.r, 1.r),
                                                blurRadius: 4.r)
                                          ],
                                          fontWeight: FontWeight.w700),
                                    ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
