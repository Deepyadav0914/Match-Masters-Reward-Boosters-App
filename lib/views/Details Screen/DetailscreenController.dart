import 'dart:developer';
import 'package:get/get.dart';
import '../../model/gamemodel.dart';

class DetailscreenController extends GetxController {
  GameItemData? item;
  String Acme = 'acme';

  @override
  void onInit() {
    super.onInit();
    item = Get.arguments['data'];
    log('_item.value');
  }
}
