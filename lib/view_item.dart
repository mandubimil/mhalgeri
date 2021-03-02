import 'package:flutter/material.dart';
import 'getx_controller.dart';
import 'package:get/get.dart';
import 'db_helper.dart';

class ViewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GC _gx = Get.put(GC());
    var text = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('view item'),
      ),
      body: Container(
          child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(child: Text(text)))),
          ],
        )


      )),
    );
  }
}
