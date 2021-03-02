import 'package:flutter/material.dart';
import 'getx_controller.dart';
import 'package:get/get.dart';
import 'db_helper.dart';

class MainListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GC _gx = Get.put(GC());
    DBHelper db = DBHelper();
    db.selectListMainBack('init');

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
                      dense: true,
                      tileColor: Colors.grey[30],
                      leading: Icon(_gx.mainItems[index][0].toString() ==
                              'private'
                          ? Icons.person
                          : _gx.mainItems[index][0].toString() == 'public'
                              ? Icons.work
                              : _gx.mainItems[index][0].toString() == 'fun'
                                  ? Icons.code
                                  : _gx.mainItems[index][0].toString() == 'memo'
                                      ? Icons.article_outlined
                                      : Icons.auto_awesome_motion),
                        trailing: Text( _gx.mainItems[index][4].toString(),
                        style: TextStyle(fontSize: 10),),
                      title: Transform.translate(
                        offset: Offset(-20, 0),
                        child: _gx.mainItems[index][1].length > 40
                            ? Text(_gx.mainItems[index][1].substring(0, 38))
                            : Text(_gx.mainItems[index][1]),
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
