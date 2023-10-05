import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../models/task_data.dart';

class EditScreen extends StatelessWidget {
  static String id = 'edit';
  String oldValue;
  int isDone;
  EditScreen({super.key, required this.isDone, required this.oldValue});
  TextEditingController newValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            padding: const EdgeInsets.only(top: 20, left: 20),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 35,
              color: mainc,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Edit',
            style: TextStyle(
                color: mainc, fontSize: 35, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: TextFormField(
                controller: newValue,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        // borderSide: BorderSide(
                        //   color: mainc,
                        // ),
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainc,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    onPressed: () async {
                      dynamic query = await Provider.of<TaskData>(context,
                              listen: false)
                          .sqlDb
                          .readData(
                              'SELECT id FROM notes WHERE task = "$oldValue" AND isDone = $isDone');
                      int everIndex = query[0]['id'];
                      print(everIndex);
                      int response =
                          await Provider.of<TaskData>(context, listen: false)
                              .sqlDb
                              .update('notes', {"task": "${newValue.text}"},
                                  "id = $everIndex");
                      Navigator.pop(
                        context,
                      );
                      Provider.of<TaskData>(context, listen: false)
                          .clearAndRead();
                    },
                    child: Text(
                      'Edit',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
