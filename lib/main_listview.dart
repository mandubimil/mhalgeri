import 'package:flutter/material.dart';
import 'getx_controller.dart';
import 'package:get/get.dart';

class MainListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GC _gx = Get.put(GC());

    return Column(
      children: [
        Obx(() => Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: _gx.mainItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      tileColor: Colors.grey[30],
                      leading: Icon(_gx.mainItems[index][0].toString() == 'public'
                          ? Icons.person
                          : _gx.mainItems[index][0].toString() == 'private'
                              ? Icons.work
                              : _gx.mainItems[index][0].toString() == 'fun'
                                  ? Icons.code
                                  : _gx.mainItems[index][0].toString() == 'memo'
                                      ? Icons.article_outlined
                                      : Icons.auto_awesome_motion),
                      title: Transform.translate(
                        offset: Offset(-20, 0),
                        child: Text(_gx.mainItems[index][1]),
                      ),
                      onLongPress: () {
                        Get.toNamed('/r/detail_halgeri', arguments: index);
                      },
                    ),
                  );
                }))),
      ],
    );
  }
}