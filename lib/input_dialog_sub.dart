import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_controller.dart';
import 'db_helper.dart';

class InputDialogSub extends StatelessWidget {
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
                maxLines: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(Icons.cancel_outlined),
                      onPressed: () {
                        print(_gx.radioGubun.toString());
                        Navigator.of(context).pop();
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      icon: Icon(Icons.library_add),
                      onPressed: () {
                        if (textContent.text.isEmpty) {
                          print('content is empty');
                        } else {
                          db.insert(''' insert into halgeri_sub
                                        (main_createTime, content, createTime, editTime)
                                        values
                                        (?,?, datetime('now'), datetime('now'))
                                        ''', [
                            _gx.mainCreateTime.toString(),
                            textContent.text
                          ]);

                          db.selectListSub(
                              '''select * from halgeri_sub where main_createTime = ? order by createTime desc''',
                              [_gx.mainCreateTime.toString()]);

                          Navigator.of(context).pop();
                        }
                      }),
                ],
              ),
            ],
          ))),
    ); // TODO: implement build
  }
}
