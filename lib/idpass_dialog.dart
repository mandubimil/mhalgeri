import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_controller.dart';
import 'db_helper.dart';

class IdpassDialog extends StatelessWidget {
  final textId = TextEditingController();
  final textPass = TextEditingController();

  IdpassDialog(String id, String pass){
    textId.text = id;
    textPass.text = pass;
  }

  @override
  Widget build(BuildContext context){
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
                    controller: textId,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter id',
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: textPass,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter passwd',
                    ),
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
                            if (textId.text.isEmpty || textPass.text.isEmpty) {
                              print('content is empty');
                            } else {
                              db.doDeleteInsert(
                                  'delete from halgeri_config',
                                  [],
                                  ''' insert into halgeri_config
                                        (uid, pass)
                                        values
                                        (?,?)
                                        ''',
                                  [textId.text.trim(), textPass.text.trim()]);

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
