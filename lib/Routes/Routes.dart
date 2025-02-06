import 'package:flutter/material.dart';
import '../views/Data Screen/Data.dart';
import '../views/Details Screen/Details.dart';
import '../views/Gifs Screen/Gifs.dart';
import '../views/Gifs Screen/GifsDetail.dart';
import '../views/MMReward Screen/Mmreward.dart';
import '../views/MMReward Screen/RewardDetail.dart';
import '../views/MainMenu Screen/MainMenu.dart';
import '../views/Setting Screen/Setting.dart';
import '../views/Statistics Screen/Statistics.dart';
import '../views/splash Screen/SplashScreen.dart';

class Router {
  static MaterialPageRoute onRouteGenerator(settings) {
    switch (settings.name) {
      case MenuScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MenuScreen(),
        );

      case SplashScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SplashScreen(),
        );

      case MmrewardScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MmrewardScreen(),
        );

      case RewardDetailScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RewardDetailScreen(),
        );

      case GifsScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => GifsScreen(),
        );

      case GifsDetailScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => GifsDetailScreen(),
        );

      case StatisticsScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => StatisticsScreen(),
        );

      case Detailscreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Detailscreen(),
        );

      case DataScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DataScreen(),
        );

      case SettingScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SettingScreen(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Material(
            child: Center(
              child: Text("404 page not founded"),
            ),
          ),
        );
    }
  }
}
