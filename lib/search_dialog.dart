import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_controller.dart';
import 'db_helper.dart';

class SearchDialog extends StatelessWidget {
  final textContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GC _gx = Get.put(GC());
    DBHelper db = DBHelper();

    return AlertDialog(
      backgroundColor: Colors.grey[100],
      content: Container(
          width: 500.0,
          child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: textContent,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            if (textContent.text.isEmpty) {
                              print('content is empty');
                            } else {
                              db.selectListMain('''select * from halgeri_main where content like '%${textContent.text}%' order by createTime desc''', [], 'search');
                            }
                          }),
                    ],
                  ),
                ],
              ))),
    ); // TODO: implement build
  }
}
