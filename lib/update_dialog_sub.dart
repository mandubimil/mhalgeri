import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_controller.dart';
import 'db_helper.dart';

class UpdateDialogSub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GC _gx = Get.put(GC());
    DBHelper db = DBHelper();
    final textContent = TextEditingController(text: _gx.subContent.toString());

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
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('delete?'),
                              content: Text(textContent.text.length > 100
                                  ? textContent.text.substring(1, 80)
                                  : textContent.text),
                              actions: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.cancel_outlined),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      db.delete('''delete from halgeri_sub
                                                    where main_createTime = ?
                                                      and createTime =?
                                        ''', [
                                        _gx.mainCreateTime.toString(),
                                        _gx.subCreateTime.toString()
                                      ]);

                                      db.selectListSub(
                                          '''select * from halgeri_sub where main_createTime = ? order by createTime desc''',
                                          [_gx.mainCreateTime.toString()]);

                                      Navigator.of(context).pop();
                                    }),
                              ],
                            );
                          },
                        );
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
                          db.insert('''update halgeri_sub
                                        set content = ?,
                                            editTime = datetime('now')
                                        where main_createTime = ?
                                          and createTime =?
                                        ''', [
                            textContent.text,
                            _gx.mainCreateTime.toString(),
                            _gx.subCreateTime.toString()
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
