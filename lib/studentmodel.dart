
//import 'package:hive/hive.dart';



//@HiveType(typeId: 0)
class Student{
  //@HiveField(0)
  String name;

  late String id;
  //@HiveField(1)
  String email;
  //@HiveField(2)
  String phone;
  //@HiveField(3)
  String dob,faculty,university,question,academicyear;
  //@HiveField(4)
  String specification="";
  //@HiveField(5)
  bool graduated = false;
  //@HiveField(6)
  bool valid=true,waiting=true;

  Student(this.name,this.email,this.phone,this.dob,this.academicyear,this.faculty,this.question,this.university);
}