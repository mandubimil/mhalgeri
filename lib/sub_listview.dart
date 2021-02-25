import 'package:flutter/material.dart';
import 'getx_controller.dart';
import 'package:get/get.dart';

class SubListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GC _gx = Get.put(GC());

    return Column(
      children: [
        Obx(() => Expanded(
            child: ListView.builder(
                itemCount: _gx.subItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      tileColor: Colors.grey[30],
                      title: Text(_gx.subItems[index]),
                      onTap: () {},
                    ),
                  );
                }))),
      ],
    );
  }
}
