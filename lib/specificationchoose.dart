import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Expert/main.dart';
import 'package:Expert/page.dart';
import 'package:Expert/studentmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Specichoose extends StatefulWidget {
  Student student;
  BuildContext context;
  Specichoose({Key? key,required this.student,required this.context}) : super(key: key);

  @override
  State<Specichoose> createState() => _SpecichooseState();
}
class _SpecichooseState extends State<Specichoose> {
  //Box<Student> box=Hive.box<Student>(boxname);
  late double height,width;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: const Text("Globe Expertise Program",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,)
            ),
            Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: const Text("Select your expert choice",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,)
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gridcont(title: "Antibiotics", image: "assets/antibiotics.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
                gridcont(title: "Respiratory", image: "assets/respiratory.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
                gridcont(title: "Gynecology", image: "assets/gynecology.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gridcont(title: "Orthopedic", image: "assets/orthopedics.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
                gridcont(title: "GIT", image: "assets/GTI.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
                gridcont(title: "Dermatology", image: "assets/dermatology.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gridcont(title: "Ophthalmology", image: "assets/ophthalmology.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
                gridcont(title: "CNS", image: "assets/CNS.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
                gridcont(title: "Cardiology", image: "assets/cardiology.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gridcont(title: "Urology", image: "assets/urology.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
                gridcont(title: "Diabetes", image: "assets/diabetes.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
                gridcont(title: "Oncology", image: "assets/oncology.jpg", student: widget.student, height: height, width: width,anotherone: widget.context),
              ],
            )
          ],
        ),
      )
    );
  }
}

class gridcont extends StatefulWidget {
  String title,image;
  Student student;
  double height,width;
  gridcont({Key? key,required this.title,required this.image,required this.student,required this.height,required this.width,required this.anotherone}) : super(key: key);
  bool clicked=false;
  bool filled=false;
  int count=0;
  BuildContext anotherone;

  Future<bool> getcount() async{
    CollectionReference number =FirebaseFirestore.instance.collection('Count');
    var num=await number.doc(title).get().then((user){
      count=user.get("count");
      return count;
    });
    if(num>=75){
      return true;
    }
    return false;
  }

  @override
  State<gridcont> createState() => _gridcontState();
}

class _gridcontState extends State<gridcont> {
  @override
  Widget build(BuildContext context) {




    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          return InkWell(
            onTap: () async {
              if(!snapshot.data){
                if(!widget.clicked){
                  widget.clicked=true;
                  widget.student.specification=widget.title;
                  try {
                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: widget.student.email,
                      password: widget.student.phone,
                    );
                    widget.student.id=credential.user!.uid;
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    CollectionReference users = FirebaseFirestore.instance.collection('Students');
                    users.doc(widget.student.id).set({
                      "name":widget.student.name,
                      "mail":widget.student.email,
                      "dob":widget.student.dob,
                      "specification":widget.student.specification,
                      "phone":widget.student.phone,
                      "grad":widget.student.graduated,
                      "valid":widget.student.valid,
                      "university":widget.student.university,
                      "faculty":widget.student.faculty,
                      "academic year":widget.student.academicyear,
                      "question":widget.student.question,
                      "waiting":widget.student.waiting,
                      "id":widget.student.id
                    });
                    final url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
                    final String message = "Name : ${widget.student.name}\nPhone : ${widget.student.phone}\nEmail : ${widget.student.email}\nSpecification : ${widget.student.specification}\nDOB : ${widget.student.dob}";
                    final respone=await http.post(url,body:jsonEncode({
                      "service_id":"service_qequfbd",
                      "template_id":"template_r1w6snj",
                      "user_id":"user_250n8DCL4ixgIFNmAGkNi",
                      "template_params":{
                        "subject":widget.student.name + " want to register in the training program",
                        "to_name":"Globe Expertise",
                        "message":message,
                        "reply_to":widget.student.email,
                        "to_mail":"globe.expertise@globe-international.com",
                        "fromname":widget.student.name
                      }
                    }) ,
                        headers: {
                          'origin':'http://localhost',
                          'Content-Type':'application/json'
                        });

                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=> Pagedd(mail: widget.student.email,)));
                    //Navigator.pop(anotherone);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      SnackBar snackBar = SnackBar(
                        content: Text(e.code),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (e.code == 'email-already-in-use') {
                      SnackBar snackBar = SnackBar(
                        content: Text(e.code),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=> const Home()));
                    }
                  } catch (e) {
                    SnackBar snackBar = SnackBar(
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }



                }
              }else{
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'We are sorry',
                  desc: 'This specification is filled you can choose any other one',
                  btnOkOnPress: () {},
                ).show();
              }
            },
            child: Container(
              width: widget.width/3.1,
              height: widget.height/8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Stack(
                children: [

                  Column(
                    children: [

                      Container(
                          width: 200,
                          //padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          alignment: Alignment.center,
                          child: Text(widget.title,style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)
                      ),
                      SizedBox(
                          height: widget.height/15,
                          width: widget.width/4,
                          child: Image.asset(widget.image)
                      ),
                    ],
                  ),
                  snapshot.data ? Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: widget.width/3.1,
                        height: widget.height/8,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                        ),
                        margin: const EdgeInsets.all(5),
                        child: const Center(child: Text("Filled",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)),
                      )
                  ):const SizedBox(),
                ],

              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
      future: widget.getcount(),
    );


  }
}




