import 'package:flutter/material.dart';
import 'bottom_navi.dart';
import 'getx_controller.dart';
import 'package:get/get.dart';
import 'main_listview.dart';
import 'halgeri_drawer.dart';
import 'input_dialog.dart';
import 'search_dialog.dart';
import 'detail_halgeri.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/r/detail_halgeri', page: () => DetailDialog()),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  final textContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GC _gx = Get.put(GC());

    return Scaffold(
      drawer: HalgeriDrawer(),
      appBar: AppBar(
        title: Obx(
          () => Text('${_gx.appbarTitle}'),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SearchDialog();
                });
          })
        ]
      ),
      body: Container(color: Colors.grey[100], child: MainListView()),
      bottomNavigationBar: BottomNavi(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _gx.radioGubun('fun');

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return InputDialog();
                });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}
