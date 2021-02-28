import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_controller.dart';
import 'input_dialog_sub.dart';
import 'update_dialog_sub.dart';
import 'db_helper.dart';

class DetailDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GC _gx = Get.put(GC());
    final textContent = TextEditingController();

    var data = Get.arguments;
    print(_gx.mainItems[data]);

    _gx.mainCreateTime(_gx.mainItems[data][2]);
    textContent.text = _gx.mainItems[data][1];
    _gx.mainGubun(_gx.mainItems[data][0]);
    _gx.subItems.clear();

    DBHelper db = DBHelper();
    db.selectListSub(
        '''select * from halgeri_sub where main_createTime = ? order by createTime desc''',
        [_gx.mainCreateTime.toString()]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('detail halgeri'),
      ),
      body: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _gx.mainGubun('private');
                        },
                        child: Obx(
                          () => Container(
                            height: 56,
                            width: 56,
                            color: _gx.mainGubun.toString() == 'private'
                                ? Colors.blue[300]
                                : Colors.transparent,
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          _gx.mainGubun('public');
                        },
                        child: Obx(
                          () => Container(
                            height: 56,
                            width: 56,
                            color: _gx.mainGubun.toString() == 'public'
                                ? Colors.blue[300]
                                : Colors.transparent,
                            child: Icon(Icons.work),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          _gx.mainGubun('fun');
                        },
                        child: Obx(
                          () => Container(
                            height: 56,
                            width: 56,
                            color: _gx.mainGubun.toString() == 'fun'
                                ? Colors.blue[300]
                                : Colors.transparent,
                            child: Icon(Icons.code),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          _gx.mainGubun('memo');
                        },
                        child: Obx(
                          () => Container(
                            height: 56,
                            width: 56,
                            color: _gx.mainGubun.toString() == 'memo'
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
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                    ),
                    controller: textContent,
                    maxLines: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(Icons.download_done_outlined),
                          onPressed: () {
                            db.insert('''update halgeri_main
                                          set dan = 'end'
                                          where createTime = ?
                                          ''', [_gx.mainCreateTime.toString()]);

                            db.selectListMainBack('end');

                            Navigator.of(context).pop();
                          }),
                      SizedBox(width: 20),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('delete?'),
                                  content: Text(_gx.mainItems[data][1].length >
                                          100
                                      ? _gx.mainItems[data][1].substring(1, 80)
                                      : _gx.mainItems[data][1]),
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
                                          db.delete('''delete from halgeri_main
                                                        where createTime = ?
                                                        ''',
                                              [_gx.mainCreateTime.toString()]);

                                          db.delete('''delete from halgeri_sub
                                                        where main_createTime = ?
                                                        ''',
                                              [_gx.mainCreateTime.toString()]);

                                          db.selectListMainBack(
                                              _gx.mainItems[data][0]);
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
                            db.insert('''update halgeri_main
                                          set gubun = ?,
                                              content = ?,
                                              editTime = datetime('now')
                                          where createTime =?
                                        ''', [
                              _gx.mainGubun.toString(),
                              textContent.text,
                              _gx.mainCreateTime.toString(),
                            ]);

                            db.selectListMainBack(_gx.mainItems[data][0]);
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  Obx(() => Expanded(
                      child: ListView.builder(
                          itemCount: _gx.subItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: _gx.subItems[index][1].length > 110
                                  ? Text(
                                      _gx.subItems[index][1].substring(1, 100))
                                  : Text(_gx.subItems[index][1]),
                              subtitle: Text(_gx.subItems[index][2]),
                              onLongPress: () {
                                _gx.subContent(_gx.subItems[index][1]);
                                _gx.subCreateTime(_gx.subItems[index][2]);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return UpdateDialogSub();
                                    });
                              },
                            );
                          }))),
                ],
              )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return InputDialogSub();
                });
          }),
    );
  }
}
