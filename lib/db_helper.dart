import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pretty_json/pretty_json.dart';
import 'getx_controller.dart';
import 'package:get/get.dart';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    print('get database');

    _db = openDatabase(join(await getDatabasesPath(), 'mhalgeri.db'),
        version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE halgeri_main
          (
          dan TEXT, 
          gubun TEXT, 
          content TEXT, 
          createTime TEXT not null, 
          editTime TEXT not null, 
          bigo TEXT
          )''');

      await db.execute('''
          CREATE TABLE halgeri_sub
          (
          main_createTime TEXT not null, 
          gubun TEXT, 
          content TEXT, 
          createTime TEXT not null, 
          editTime TEXT not null, 
          bigo TEXT
          )''');

      await db.execute('''
          CREATE TABLE halgeri_config
          (
          uid TEXT not null, 
          pass TEXT not null, 
          bigo TEXT
          )''');
    }, onUpgrade: (db, oldVersion, newVersion) {});

    return _db;
  }

  Future<int> selectListMainBack(String backGubun) async {
    final db = await database;
    GC _gx = Get.put(GC());

    dynamic rows;
    String Title;
    if (backGubun == 'init') {
      rows = await db.rawQuery(
          '''select * from halgeri_main where gubun != 'memo' and (dan != 'end' or dan is null) order by createTime desc''',
          []);
      Title = 'all';
    } else if (backGubun == 'public') {
      rows = await db.rawQuery(
          '''select * from halgeri_main where gubun == 'public' and (dan != 'end' or dan is null) order by createTime desc''',
          []);
      Title = 'public';
    } else if (backGubun == 'private') {
      rows = await db.rawQuery(
          '''select * from halgeri_main where gubun == 'private' and (dan != 'end' or dan is null) order by createTime desc''',
          []);
      Title = 'private';
    } else if (backGubun == 'fun') {
      rows = await db.rawQuery(
          '''select * from halgeri_main where gubun == 'fun' and (dan != 'end' or dan is null) order by createTime desc''',
          []);
      Title = 'public';
    } else if (backGubun == 'end') {
      rows = await db.rawQuery(
          '''select * from halgeri_main where dan == 'end' order by createTime desc''',
          []);
      Title = 'end';
    } else if (backGubun == 'memo') {
      rows = await db.rawQuery(
          '''select * from halgeri_main where gubun == 'memo' and (dan != 'end' or dan is null) order by createTime desc''',
          []);
      Title = 'memo';
    }

    _gx.mainItems.clear();

    for (var i = 0; i < rows.length; i++) {
      String strDate = rows[i]['createTime']
          .toString()
          .replaceAll('-', '')
          .replaceAll(':', '')
          .replaceAll(' ', '');
      strDate = strDate.substring(0, 8) + 'T' + strDate.substring(8);
      DateTime dateTime = DateTime.parse(strDate);

      int dateCha = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .difference(DateTime(dateTime.year, dateTime.month, dateTime.day))
          .inDays;

      _gx.mainItems.add([
        rows[i]['gubun'],
        rows[i]['content'],
        rows[i]['createTime'].toString(),
        rows[i]['dan'].toString(),
        dateCha.toString()
      ]);
    }

    _gx.appbarTitle('${Title} : ${rows.length.toString()}');
    return rows.length;
  }

  Future<int> selectListMain(String pSqlText, List pSqlJo, String Title) async {
    final db = await database;
    GC _gx = Get.put(GC());

    var rows = await db.rawQuery(pSqlText, pSqlJo);

    _gx.mainItems.clear();

    for (var i = 0; i < rows.length; i++) {
      String strDate = rows[i]['createTime']
          .toString()
          .replaceAll('-', '')
          .replaceAll(':', '')
          .replaceAll(' ', '');
      strDate = strDate.substring(0, 8) + 'T' + strDate.substring(8);
      DateTime dateTime = DateTime.parse(strDate);

      int dateCha = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .difference(DateTime(dateTime.year, dateTime.month, dateTime.day))
          .inDays;

      _gx.mainItems.add([
        rows[i]['gubun'],
        rows[i]['content'],
        rows[i]['createTime'].toString(),
        rows[i]['dan'].toString(),
        dateCha.toString()
      ]);
    }

    _gx.appbarTitle('${Title} : ${rows.length.toString()}');
    return rows.length;
  }

  Future<int> selectListSub(String pSqlText, List pSqlJo) async {
    final db = await database;
    GC _gx = Get.put(GC());

    var rows = await db.rawQuery(pSqlText, pSqlJo);

    _gx.subItems.clear();
    print(rows);

    for (var i = 0; i < rows.length; i++) {
      _gx.subItems.add([
        rows[i]['gubun'],
        rows[i]['content'],
        rows[i]['createTime'].toString()
      ]);
    }

    return rows.length;
  }

  Future<List<Map<String, dynamic>>> selectRows(
      String pSqlText, List pSqlJo) async {
    final db = await database;
    GC _gx = Get.put(GC());

    List<Map<String, dynamic>> rows = await db.rawQuery(pSqlText, pSqlJo);

    return rows;
  }

  Future<int> insert(String pSqlText, List pSqlJo) async {
    final db = await database;

    var res = await db.rawInsert(pSqlText, pSqlJo);
    return res;
  }

  Future<int> delete(String pSqlText, List pSqlJo) async {
    final db = await database;

    var res = await db.rawDelete(pSqlText, pSqlJo);
    return res;
  }

  Future<int> doDeleteInsert(
      String pSqlText1, List pSqlJo1, String pSqlText2, List pSqlJo2) async {
    final db = await database;

    var res1 = await db.rawDelete(pSqlText1, pSqlJo1);
    var res2 = await db.rawInsert(pSqlText2, pSqlJo2);

    return res1;
  }
}
