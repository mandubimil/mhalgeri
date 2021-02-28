import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';
import 'getx_controller.dart';
import 'package:get/get.dart';
import 'db_helper.dart';

class BottomNavi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GC _gx = Get.put(GC());
    DBHelper db = DBHelper();

    return BottomAppBar(
        color: Colors.blue[300],
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.auto_awesome_motion),
                onPressed: () {
                  db.selectListMain(
                      '''select * from halgeri_main where gubun != 'memo' and dan is null order by createTime desc''',
                      [],
                      'all');
                }),
            SizedBox(
              width: 3,
            ),
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  db.selectListMain(
                      '''select * from halgeri_main where gubun = ? and dan is null order by createTime desc''',
                      ['private'],
                      'private');
                }),
            SizedBox(
              width: 3,
            ),
            IconButton(
                icon: Icon(Icons.work),
                onPressed: () {
                  db.selectListMain(
                      '''select * from halgeri_main where gubun = ? and dan is null order by createTime desc''',
                      ['public'],
                      'public');
                }),
            SizedBox(
              width: 3,
            ),
            IconButton(
                icon: Icon(Icons.code),
                onPressed: () {
                  db.selectListMain(
                      '''select * from halgeri_main where gubun = ? and dan is null order by createTime desc''',
                      ['fun'],
                      'fun');
                }),
            SizedBox(
              width: 3,
            ),
            IconButton(
                icon: Icon(Icons.download_done_outlined),
                onPressed: () {
                  db.selectListMain(
                      '''select * from halgeri_main where dan = ? order by createTime desc''',
                      ['end'],
                      'end');
                }),
            SizedBox(
              width: 3,
            ),
            IconButton(
                icon: Icon(Icons.article_outlined),
                onPressed: () {
                  db.selectListMain(
                      '''select * from halgeri_main where gubun = ? and dan is null order by createTime desc''',
                      ['memo'],
                      'memo');
                }),
          ],
        ));
  }
}
