import 'package:get/get.dart';

class GC extends GetxController {
  RxList<List<String>> mainItems = [
    ['gubun', 'content', '0']
  ].obs;
  RxList<List<String>> subItems = [
    ['gubun', 'content', '0']
  ].obs;

  RxString appbarTitle = 'title'.obs;
  RxString radioGubun = 'fun'.obs;
  RxString mainCreateTime = 'time'.obs;
  RxString mainGubun = 'gubun'.obs;
  RxString subContent = 'content'.obs;
  RxString subCreateTime = 'time'.obs;

  GC() {
    mainItems.clear();
    subItems.clear();
  }
}
