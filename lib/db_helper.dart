import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pretty_json/pretty_json.dart';
import 'getx_controller.dart';
import 'package:get/get.dart';


class DBHelper {
  var _db;

  Future<Database> get database async {
    if ( _db != null ) return _db;
    print('get database');

    _db = openDatabase(
        join(await getDatabasesPath(), 'mhalgeri.db'),
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE halgeri_main
          (id INTEGER PRIMARY KEY AUTOINCREMENT, dan TEXT, gubun TEXT, content TEXT, createTime TEXT, editTime TEXT)''');

          await db.execute('''
          CREATE TABLE halgeri_sub
          (id INTEGER PRIMARY KEY AUTOINCREMENT, main_id INTEGER, gubun TEXT, content TEXT, createTime TEXT, editTime TEXT)''');
        },
        onUpgrade: (db, oldVersion, newVersion){}
    );

    print(await getDatabasesPath());

    return _db;
  }

  Future<int> selectListMain(String pSqlText, List pSqlJo, String Title) async {
    final db = await database;
    GC _gx = Get.put(GC());

    var rows = await db.rawQuery(pSqlText, pSqlJo);

    _gx.mainItems.clear();
    print(rows);

    for (var i=0; i<rows.length; i++){
      _gx.mainItems.add([rows[i]['gubun'], rows[i]['content'], rows[i]['id'].toString()]);
    }

    _gx.appbarTitle('${Title} : ${rows.length.toString()}');
    return rows.length;
  }

  Future<int> insert(String pSqlText, List pSqlJo) async {
    final db = await database;

    var res = await db.rawInsert(pSqlText, pSqlJo);
    return res;
  }


}

