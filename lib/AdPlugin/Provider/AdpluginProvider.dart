import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AdLoader/AdLoaderProvider.dart';
import '../MainJson/MainJson.dart';

class AdpluginProvider extends StatelessWidget {
  final Widget child;

  const AdpluginProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdLoaderProvider>(
          create: (context) {
            return AdLoaderProvider();
          },
        ),
        ChangeNotifierProvider<MainJson>(
          create: (context) {
            return MainJson();
          },
        )
      ],
      child: child,
    );
  }
}
