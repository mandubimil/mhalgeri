import 'package:get/get.dart';

class GC extends GetxController {
  RxString appbarTitle = 'title'.obs;
  RxList<List<String>> mainItems = [['fun','fun','0']].obs;
  RxList<String> subItems = ['fun'].obs;
  RxString radioGubun = 'fun'.obs;

  GC() {
    mainItems.clear();
    subItems.clear();
  }
}
