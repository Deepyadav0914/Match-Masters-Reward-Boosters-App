import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reawrdapp/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:reawrdapp/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:reawrdapp/AdPlugin/AdsGridView/ads_gridview.dart';
import '../../AdPlugin/Ads/Native/NativeRN.dart';
import '../../model/gamemodel.dart';
import '../Details Screen/Details.dart';
import 'DataScreenController.dart';

class DataScreen extends StatelessWidget {
  static const String routeName = '/DataScreen';

  DataScreen({super.key});
  final controller = Get.put(DataScreenController());

  @override
  Widget build(BuildContext context) {
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
            controller.name,
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
            child:
                controller.name == 'Tips & Tricks' || controller.name == 'FAQs'
                    ? _buildListView()
                    : AdsGridView(
                        crossAxisCount: 2,
                        itemCount: controller.alldata.length,
                        adsIndex: 1,
                        adsWidget: NativeRN(parentContext: context),
                        itemMainAspectRatio: 1,
                        padding: EdgeInsets.all(10.r),
                        itemWidget: (context, index) {
                          final item = controller.alldata[index];
                          return _buildGridTile(item, index, context);
                        },
                        itemPadding: EdgeInsets.all(8.r)),
          ),
        ),
      ),
    );
  }

  // ListView for 'Tips & Tricks' or 'FAQs'
  Widget _buildListView() {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.alldata.length,
        padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 15.r),
        itemBuilder: (context, index) {
          final item = controller.alldata[index];

          return Column(
            children: [
              index == 2 ? NativeRN(parentContext: context) : SizedBox(),
              _buildListTile(item, index, context),
            ],
          );
        },
      ),
    );
  }

  // Grid tile widget
  Widget _buildGridTile(GameItemData item, int index, BuildContext context) {
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(width: 3.r, color: Colors.black),
        ),
        margin: EdgeInsets.all(4.r),
        padding: EdgeInsets.only(bottom: 5.r),
        child: ListTile(
          onTap: () {
            AdsRN().showFullScreen(
              context: context,
              onComplete: () {
                Get.to(() => Detailscreen(), arguments: {'data': item});
              },
            );
          },
          title: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 7.r),
              child: Image.network(
                item.image.toString(),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // List tile widget for ListView
  Widget _buildListTile(GameItemData item, int index, BuildContext context) {
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
          onTap: () {
            AdsRN().showFullScreen(
              context: context,
              onComplete: () {
                Get.to(() => Detailscreen(), arguments: {'data': item});
              },
            );
          },
          leading: Text(
            '${index + 1}.',
            style: TextStyle(
              fontFamily: 'acme',
              fontSize: 25.r,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          title: Text(
            item.title.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'acme',
              fontSize: 25.r,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.black,
            size: 20.r,
          ),
        ),
      ),
    );
  }
}
