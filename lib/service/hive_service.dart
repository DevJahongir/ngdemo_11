import 'package:hive/hive.dart';
import '../model/member_model.dart';

class HiveService {
  static Box<Member> getMemberBox() {
    return Hive.box<Member>('members');
  }

  static Box getGeneralBox() {
    return Hive.box('my_nosql');
  }

  // Save object using key and value
  static Future<void> storeMember(Member member) async {
    var box = getGeneralBox();
    await box.put('member', member);
  }

  static Member loadMember() {
    var box = getGeneralBox();
    return box.get('member');
  }

  static Future<void> removeMember(int id) async {
    var box = getMemberBox();
    await box.delete(id);
  }

  // Example of getAllMembers method
  static List<Member> getAllMember() {
    var box = getMemberBox();
    return box.values.toList();
  }

  // Save object without key
  static Future<void> saveMember(Member member) async {
    var box = getMemberBox();
    await box.add(member);
  }

  static Future<void> updateMember(int index, Member member) async {
    var box = getMemberBox();
    await box.putAt(index, member);
  }

  static List<Member> getAllMembers() {
    var box = getMemberBox();
    List<Member> members = [];
    for (int i = 0; i < box.length; i++) {
      var member = box.getAt(i);
      if (member != null) {
        members.add(member);
      }
    }
    return members;
  }

  static Future<void> deleteMemberByIndex(int index) async {
    var box = getMemberBox();
    await box.deleteAt(index);
  }
}
