import 'package:get/get.dart';

class DrawerControllerX extends GetxController {
  var isOpen = false.obs;

  void toggleDrawer() => isOpen.value = !isOpen.value;
  void closeDrawer() => isOpen.value = false;
}