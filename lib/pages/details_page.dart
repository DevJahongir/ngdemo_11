import 'package:flutter/material.dart';
import 'package:ngdemo_11/model/member_model.dart';
import 'package:ngdemo_11/service/hive_service.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerName = TextEditingController();

  _addMemberToDB(){
    String idString = controllerId.text.trim().toString();
    String username = controllerName.text.trim().toString();
    int id = int.parse(idString);
    Member member = Member(id, username);

    HiveService.saveMember(member);

    _backTofinish();
  }

  _backTofinish(){
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Add Member'),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controllerId,
              decoration: InputDecoration(
                hintText: 'Input member Id'
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controllerName,
              decoration: InputDecoration(
                  hintText: 'Input member name'
              ),
            ),
            SizedBox(
              height: 10,
            ),

            MaterialButton(
              color: Colors.blue,
              onPressed: (){
                _addMemberToDB();
              },
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white, fontSize: 16
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
