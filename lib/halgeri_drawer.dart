import 'package:flutter/material.dart';
import 'idpass_dialog.dart';
import 'db_helper.dart';

class HalgeriDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DBHelper db = DBHelper();

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('halgeri',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                height: 80,
              ),
              Text('backup time :'),
            ]),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('backup',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            onTap: () {

            },
          ),
          ListTile(
            title: Text('restore',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            onTap: () {
              print('1');
            },
          ),
          ListTile(
            title: Text('set idpass',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            onTap: () async {
              List<Map<String, dynamic>> rows =
                  await db.selectRows('select * from halgeri_config', []);

              String id = '';
              String passwd = '';
              if (rows.length > 1) {
                await db.delete('delete from halgeri_config', []);
              } else if (rows.length == 1) {
                id = rows[0]['uid'];
                passwd = rows[0]['pass'];
              }

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return IdpassDialog(id, passwd);
                  });
            },
          ),
        ],
      ),
    );
  }
}
