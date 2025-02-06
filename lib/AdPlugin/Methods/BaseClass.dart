import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_messaging_platform/user_messaging_platform.dart';

import '../MainJson/MainJson.dart';
import 'GoogleInit.dart';

class BaseClass {
  Future<void> initAdNetworks(
      {required BuildContext context,
      required Function() onInitComplete}) async {
    MainJson mainJson = context.read<MainJson>();
    await GoogleInit().onInit();
    Future.delayed(const Duration(milliseconds: 400), () {
      onInitComplete();
    });
  }

  Future<void> showUserMessage() async {
    var info = await UserMessagingPlatform.instance.requestConsentInfoUpdate();
    if (info.consentStatus == ConsentStatus.required) {
      await UserMessagingPlatform.instance.showConsentForm();
      await AppTrackingTransparency.requestTrackingAuthorization();
    } else {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }
}
