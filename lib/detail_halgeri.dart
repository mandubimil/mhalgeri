import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_controller.dart';

class DetailDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GC _gx = Get.put(GC());
    var data = Get.arguments;
    print(_gx.mainItems[data]);


    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Obx(
            () => Text('${_gx.appbarTitle}'),
          ),
        ),
        body: Container(
            width: 500.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('1');
                        _gx.radioGubun('person');
                      },
                      child: Obx(
                        () => Container(
                          height: 56,
                          width: 56,
                          color: _gx.radioGubun.toString() == 'person'
                              ? Colors.grey
                              : Colors.transparent,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        _gx.radioGubun('work');
                      },
                      child: Obx(
                        () => Container(
                          height: 56,
                          width: 56,
                          color: _gx.radioGubun.toString() == 'work'
                              ? Colors.grey
                              : Colors.transparent,
                          child: Icon(Icons.work),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        _gx.radioGubun('code');
                      },
                      child: Obx(
                        () => Container(
                          height: 56,
                          width: 56,
                          color: _gx.radioGubun.toString() == 'code'
                              ? Colors.grey
                              : Colors.transparent,
                          child: Icon(Icons.code),
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(title: Text('fd'));
                              });
                        }),
                    SizedBox(width: 20),
                    IconButton(icon: Icon(Icons.library_add), onPressed: () {}),
                  ],
                ),
                Obx(() => Expanded(
                    child: ListView.builder(
                        itemCount: _gx.subItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              tileColor: Colors.grey[30],
                              leading: Icon(Icons.photo_album),
                              title: Text(_gx.subItems[index]),
                              onTap: () {},
                              trailing: Icon(Icons.more_vert),
                          );
                        }))),
                RaisedButton(
                    child: Text('1'),
                    onPressed: () {
                      _gx.subItems.add(DateTime.now().toIso8601String());
                      _gx.appbarTitle('person' + _gx.subItems.length.toString());
                    }),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(icon: Icon(Icons.library_add), onPressed: () {}),
                  ],
                ),
                SizedBox(height: 30,)
              ],
            ))));
  }
}
