import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:reawrdapp/Routes/Routes.dart' as r;
import 'package:reawrdapp/AdPlugin/Utils/Extensions.dart';
import 'package:reawrdapp/views/MainMenu%20Screen/MainMenu.dart';
import 'package:reawrdapp/views/splash%20Screen/SplashScreen.dart';
import 'AdPlugin/AdLoader/AdLoader.dart';
import 'AdPlugin/Provider/AdpluginProvider.dart';
import 'AdPlugin/Screen/SplashScreen.dart';
import 'AdPlugin/Utils/NavigationService.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize storage
  runApp(const MyApp());
}

GetStorage box = GetStorage();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DartPingIOS.register();
    return AdpluginProvider(
      child: AdLoader(
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return GetMaterialApp(
              home: AdSplashScreen(
                  onComplete: (context, mainJson) async {
                    "SplashScreen".performAction(
                      context: context,
                      onComplete: () {
                        Navigator.pushReplacementNamed(
                            context, MenuScreen.routeName);
                      },
                    );
                  },
                  servers: const [
                    "miracocopepsi.com",
                    // "coinspinmaster.com",
                    // "trailerspot4k.com",
                  ],
                  jsonUrl: const [
                    "https://miracocopepsi.com/admin/mayur/coc/pradip/ios/mm_rewards/main.json",
                    "https://coinspinmaster.com/",
                    "https://trailerspot4k.com/"
                  ],
                  version: '1.0.0',
                  child: const SplashScreen()),
              theme: ThemeData(),
              navigatorKey: NavigationService.navigatorKey,
              onGenerateRoute: r.Router.onRouteGenerator,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
