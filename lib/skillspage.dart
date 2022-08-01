import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:Expert/studentmodel.dart';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Skills extends StatefulWidget {
  Student student;
  bool grad=false;
  Skills({Key? key,required this.student}) : super(key: key);


  Future<bool> getstudent() async{
    CollectionReference users =FirebaseFirestore.instance.collection('Students');
    var user=await users.where("mail",isEqualTo: student.email).get().then((user){
      grad=user.docs[0].get('grad');
      return grad;
    });
    return grad;
  }

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {

  Box<bool> box=Hive.box("cer");

  bool check=false,check1=false,check2=false,check3=false,check4=false;
  late bool cer;
  bool certake=true;
  late double width,height;

  void certtakemethod(){
    bool? cer=box.get("key",defaultValue: true);
    if(cer==true){
      box.put("key", true);
      certake=true;
    }else{
      certake= cer!;
    }
  }

  bool cert(bool grad){
    if(grad&&check&&check1&&check2&&check3&&check4){
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    widget.getstudent();
    cer=widget.grad;
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    certtakemethod();
    return FutureBuilder(
      future: widget.getstudent(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                decoration:BoxDecoration(
                    image:cert(snapshot.data)? const DecorationImage(
                        image: AssetImage("assets/party.gif")
                    ):const DecorationImage(
                        image: AssetImage("")
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height/30,),
                    CircleAvatar(
                      child: Image.asset("assets/logofinal.png"),
                      radius: width/6,
                      backgroundColor: Colors.white,
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        child: const Text("Globe Expertise Program",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(5,5,5,0),
                        child: const Text("Please check every session done",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                    ),
                    SizedBox(height: height/30,),
                    Container(
                      margin: EdgeInsets.fromLTRB(width/15, 0, width/15, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //SizedBox(width: width/20,),
                          SizedBox(
                            child: const Text("Session 1 (Medical knowledge)",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                            width: width/3,
                          ),
                          //SizedBox(width: width/6,),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(Colors.red),
                            value: check,
                            onChanged: (bool? value) {
                              setState(() {
                                check = value!;
                              });
                            },
                          ),
                          Container(
                            width: width/2.5,
                            height: height/25,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(4),
                            child: Text(snapshot.data?"Valid to take":"Waiting for validation",style: const TextStyle(color: Colors.white),),
                            decoration: BoxDecoration(
                                color:snapshot.data? Colors.green:Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    //   child: TextButton(
                    //       onPressed: () async{
                    //         final Uri _url = Uri.parse('https://flutter.dev');
                    //         if (!await launchUrl(_url)) throw 'Could not launch $_url';
                    //       },
                    //       child: const Text("Session 1")
                    //   ),
                    // ),
                    SizedBox(height: height/30,),
                    Container(
                      margin: EdgeInsets.fromLTRB(width/15, 0, width/15, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //SizedBox(width: width/20,),
                          SizedBox(
                            child: const Text("Session 2 (Medical Knowledge)",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                            width: width/3,
                          ),
                          //SizedBox(width: width/6,),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(Colors.red),
                            value: check1,
                            onChanged: (bool? value) {
                              setState(() {
                                check1 = value!;
                              });
                            },
                          ),
                          Container(
                            width: width/2.5,
                            height: height/25,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(4),
                            child: Text(snapshot.data?"Valid to take":"Waiting for validation",style: const TextStyle(color: Colors.white),),
                            decoration: BoxDecoration(
                                color:snapshot.data? Colors.green:Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    //   child: TextButton(
                    //       onPressed: ()async{
                    //         final Uri _url = Uri.parse('https://flutter.dev');
                    //         if (!await launchUrl(_url)) throw 'Could not launch $_url';
                    //       },
                    //       child: const Text("Session 2")
                    //   ),
                    // ),
                    SizedBox(height: height/30,),
                    Container(
                      margin: EdgeInsets.fromLTRB(width/15, 0, width/15, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //SizedBox(width: width/20,),
                          SizedBox(
                            child: const Text("Session 3 (Presentation skills)",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                            width: width/3,
                          ),
                          //SizedBox(width: width/6,),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(Colors.red),
                            value: check2,
                            onChanged: (bool? value) {
                              setState(() {
                                check2 = value!;
                              });
                            },
                          ),
                          Container(
                            width: width/2.5,
                            height: height/25,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(4),
                            child: Text(snapshot.data?"Valid to take":"Waiting for validation",style: const TextStyle(color: Colors.white),),
                            decoration: BoxDecoration(
                                color:snapshot.data? Colors.green:Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    //   child: TextButton(
                    //       onPressed: ()async{
                    //         final Uri _url = Uri.parse('https://flutter.dev');
                    //         if (!await launchUrl(_url)) throw 'Could not launch $_url';
                    //       },
                    //       child: const Text("Session 3")
                    //   ),
                    // ),
                    SizedBox(height: height/30,),
                    Container(
                      margin: EdgeInsets.fromLTRB(width/15, 0, width/15, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //SizedBox(width: width/20,),
                          SizedBox(
                            child: const Text("Session 4 (Presentation skills)",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                            width: width/3,
                          ),
                          //SizedBox(width: width/6,),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(Colors.red),
                            value: check3,
                            onChanged: (bool? value) {
                              setState(() {
                                check3 = value!;
                              });
                            },
                          ),
                          Container(
                            width: width/2.5,
                            height: height/25,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(4),
                            child: Text(snapshot.data?"Valid to take":"Waiting for validation",style: const TextStyle(color: Colors.white),),
                            decoration: BoxDecoration(
                                color:snapshot.data? Colors.green:Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    //   child: TextButton(
                    //       onPressed: ()async{
                    //         final Uri _url = Uri.parse('https://flutter.dev');
                    //         if (!await launchUrl(_url)) throw 'Could not launch $_url';
                    //       },
                    //       child: const Text("Session 4")
                    //   ),
                    // ),
                    SizedBox(height: height/30,),
                    Container(
                      margin: EdgeInsets.fromLTRB(width/15, 0, width/15, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //SizedBox(width: width/20,),
                          SizedBox(
                            child: const Text("Session 5 (Fundamental marketing)",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                            width: width/3,
                          ),
                          //SizedBox(width: width/6,),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(Colors.red),
                            value: check4,
                            onChanged: (bool? value) {
                              setState(() {
                                check4 = value!;
                              });
                            },
                          ),
                          Container(
                            width: width/2.5,
                            height: height/25,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(4),
                            child: Text(snapshot.data?"Valid to take":"Waiting for validation",style: const TextStyle(color: Colors.white),),
                            decoration: BoxDecoration(
                                color:snapshot.data? Colors.green:Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    //   child: TextButton(
                    //       onPressed: ()async{
                    //         final Uri _url = Uri.parse('https://flutter.dev');
                    //         if (!await launchUrl(_url)) throw 'Could not launch $_url';
                    //       },
                    //       child: const Text("Session 5")
                    //   ),
                    // ),
                    SizedBox(height: height/30,),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(width/4, 0, width/4, 0),
                        padding: const EdgeInsets.all(6),
                        alignment: Alignment.center,
                        child: const Text('Get Certificate',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      onTap: () async {

                        if(certake){
                          if(cert(snapshot.data)){
                            final url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
                            final respone=await http.post(url,body:jsonEncode({
                              "service_id":"service_qequfbd",
                              "template_id":"template_r1w6snj",
                              "user_id":"user_250n8DCL4ixgIFNmAGkNi",
                              "template_params":{
                                "subject":"Certificate Request",
                                "to_mail":"globe.expertise@globe-international.com",
                                "fromname":widget.student.name,
                                "to_name":"Globe I am "+widget.student.name,
                                "message":"I have completed the intern",
                                "reply_to":widget.student.email,
                              }
                            }) ,
                                headers: {
                                  'origin':'http://localhost',
                                  'Content-Type':'application/json'
                                });

                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.INFO,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Congratulations',
                              desc: 'You have passed the intern we gonna mail you with your certificate within three days',
                              btnOkOnPress: () {},
                            ).show();

                            setState(() {
                              box.put("key", false);
                            });
                          }else{
                            const snackBar = SnackBar(
                              content: Text('You cannot have your certificate yet'),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        }else{
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'You have got your certificate before',
                            desc: '',
                            btnOkOnPress: () {},
                          ).show();
                        }


                      },
                    ),
                    SizedBox(height: height/80,),
                    InkWell(
                      onTap: () async {
                        bool temp=await widget.getstudent();
                        setState(() {
                          cer=temp;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(width/2.7, 0, width/2.7, 0),
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: const Text("Reload",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },

    );



  }
}
