import 'package:get/get.dart';

class AddPatientController extends GetxController {
  var step = 0.obs;
  var selectedGender = "Male".obs;

  void changeStep(int index) => step.value = index;
  void selectGender(String gender) => selectedGender.value = gender;
}