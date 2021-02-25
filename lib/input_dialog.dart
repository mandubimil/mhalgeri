import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_controller.dart';
import 'db_helper.dart';

class InputDialog extends StatelessWidget {
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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('1');
                      _gx.radioGubun('public');
                    },
                    child: Obx(
                      () => Container(
                        height: 56,
                        width: 56,
                        color: _gx.radioGubun.toString() == 'public'
                            ? Colors.blue[300]
                            : Colors.transparent,
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      _gx.radioGubun('private');
                    },
                    child: Obx(
                      () => Container(
                        height: 56,
                        width: 56,
                        color: _gx.radioGubun.toString() == 'private'
                            ? Colors.blue[300]
                            : Colors.transparent,
                        child: Icon(Icons.work),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      _gx.radioGubun('fun');
                    },
                    child: Obx(
                      () => Container(
                        height: 56,
                        width: 56,
                        color: _gx.radioGubun.toString() == 'fun'
                            ? Colors.blue[300]
                            : Colors.transparent,
                        child: Icon(Icons.code),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      _gx.radioGubun('memo');
                    },
                    child: Obx(
                          () => Container(
                        height: 56,
                        width: 56,
                        color: _gx.radioGubun.toString() == 'memo'
                            ? Colors.blue[300]
                            : Colors.transparent,
                        child: Icon(Icons.article_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
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
                          db.insert(''' insert into halgeri_main
                                        (gubun, content, createTime, editTime)
                                        values
                                        (?,?, datetime('now'), datetime('now'))
                                        ''',
                              [_gx.radioGubun.toString(), textContent.text]);

                          db.selectListMain('select * from halgeri_main order by createTime desc', [], 'all');
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
