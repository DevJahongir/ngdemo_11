import 'package:flutter/material.dart';
import 'package:ngdemo_11/pages/details_page.dart';
import '../model/member_model.dart';
import '../service/hive_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Member> members = [];
  String name = "No name";

  loadMember() async {
    var member = HiveService.loadMember();
    setState(() {
      name = member.id.toString();
    });
  }

  loadMembers() async {
    List<Member> memberList = HiveService.getAllMembers();
    setState(() {
      members = memberList;
    });

    members = HiveService.getAllMembers();
    print(members.length);
    for (Member member in members) {
      print(member.username);
    }
  }

  removeMember(int id) async {
   await HiveService.removeMember(id);
    loadMembers();
  }

  @override
  void initState() {
    super.initState();
    Member member1 = Member(1002, "Jahongir");
    Member member2 = Member(1003, "Islom");
    // HiveService.saveMember(member1);
    // HiveService.saveMember(member2);

    // HiveService.deleteMemberByIndex(0);
    loadMembers();
  }

  _callDetailsPage()async{
    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return DetailsPage();
    }));

    if(result){
      loadMembers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("NoSQL"),
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return _itemOfMember(members[index]);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _callDetailsPage();
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.blue,
      ),
    );
  }

  _itemOfMember(Member member) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 5),
      height: 100,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            member.username,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            member.id.toString(),
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              removeMember(member.id);
            },
          ),
        ],
      ),
    );
  }
}
