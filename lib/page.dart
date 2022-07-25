import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/skillspage.dart';
import 'package:untitled1/studentmodel.dart';
import 'package:hive/hive.dart';

const String boxname="StudentBox";

class Pagedd extends StatefulWidget {
  String? mail;
  Student student=Student("name", "email", "phone", "dob", "academicyear", "faculty", "question", "university");
  int count=0;
  Pagedd({Key? key,required this.mail}) : super(key: key);


   Future<Student> getstudent() async{
    CollectionReference users =FirebaseFirestore.instance.collection('Students');
    var user=await users.where("mail",isEqualTo: mail).get().then((user){
      Student student=Student(user.docs[0].get('name'), user.docs[0].get('mail'), user.docs[0].get('phone'), user.docs[0].get('dob'), user.docs[0].get('academic year'), user.docs[0].get('faculty'), user.docs[0].get('question'), user.docs[0].get('university'));
      student.waiting=user.docs[0].get('waiting');
      student.valid=user.docs[0].get('valid');
      student.graduated=user.docs[0].get('grad');
      student.specification=user.docs[0].get('specification');
      //print("====================================");
      //print(student.email)
      return student;
    });

    /*Student student=Student(user.docs[0].get('name'), user.docs[0].get('mail'), user.docs[0].get('phone'), user.docs[0].get('dob'), user.docs[0].get('academic year'), user.docs[0].get('faculty'), user.docs[0].get('question'), user.docs[0].get('university'));
    student.waiting=user.docs[0].get('waiting');
    student.valid=user.docs[0].get('valid');
    student.graduated=user.docs[0].get('grad');
    student.specification=user.docs[0].get('specification');
    print("====================================");
    print(student);*/
    return user;
  }
  Future<int> getcount() async{
    CollectionReference number =FirebaseFirestore.instance.collection('Count');
    var num=await number.get().then((user){
      count=user.docs[0].get('count');
      return count;
    });
    return num;
  }

  @override
  State<Pagedd> createState() => _PageddState();
}

class _PageddState extends State<Pagedd> {

  Box<bool> box=Hive.box("cer");

  bool check=false,check1=false,check2=false;
  bool cer=false;
  bool certake=true;


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
    if(grad&&check&&check1&&check2){
      return true;
    }
    return false;
  }

  late double width,height;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    certtakemethod();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 233, 233,1),
      body: FutureBuilder(
        future: widget.getstudent(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            return snapshot.data.waiting? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      width: width/2,
                      child: Image.asset("assets/check.png")
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(20),
                      child: const Text("Thank you for submitting",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(20),
                      child: const Text("You will be mailed for being accepted or rejected so please be patient",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),textAlign: TextAlign.center,)
                  ),
                  snapshot.data.valid?const SizedBox():Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(20),
                      child: const Text("You have been rejected",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.red),textAlign: TextAlign.center,)
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {

                      });
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(width/3, 0, width/3, 0),
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
            )
                :
            Scaffold(
              appBar: AppBar(
                title: const Text("Congratulations",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/party.gif")
                      ),
                      color: Colors.white
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: const Text("Welcome in Globe expertise program",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(10,10,10,0),
                      ),
                      Container(
                            child: const Text("Now, You are a member",style:TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(10),
                      ),
                      FutureBuilder(
                        future: widget.getcount(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: const Text("Number ",style:TextStyle(fontSize: 35,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(10),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue
                                ),
                                child: Text(snapshot2.data.toString(),style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(10),
                              )
                            ],
                          );
                        },
                      ),
                      Container(
                        child: const Text("in our program",style:TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                      ),

                      Container(
                        child: Text("To be expert in "+snapshot.data.specification,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(10,20,10,30),
                      ),
                      Container(
                        child: const Text("you must attend with us",style:TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue
                            ),
                            child: const Text("5",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(10),
                          ),
                          Container(
                            child: const Text("Sessions",style:TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(10),
                          )
                        ],
                      ),
                      Container(
                        child: const Text("2 sessions (Medical Knowledge)",style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.start,),
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.all(10) ,
                      ),
                      Container(
                        child: const Text("2 sessions (Presentation skills)",style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.start,),
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.all(10) ,
                      ),
                      Container(
                        child: const Text("1 session (Fundamental marketing)",style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.start,),
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.all(10) ,
                      ),
                      const SizedBox(height: 50,),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=> Skills(student: snapshot.data,)));
                          },
                          child: const Text("Next")
                      )
                    ],
                  ),
                ),
              ),
            )
            /*Container(
              alignment: Alignment.center,
              decoration:BoxDecoration(
                image:cert(snapshot.data.graduated)? const DecorationImage(
                  image: AssetImage("assets/party.gif")
                ):const DecorationImage(
                    image: AssetImage("")
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Welcome in ******",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10,10,10,0),
                      child: const Text("To be expert in ********",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text("You must",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                  ),
                  SizedBox(height: height/20,),
                  Container(
                    margin: EdgeInsets.fromLTRB(width/15, 0, width/15, 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: width/20,),
                        const Text("Skill 1",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(width: width/6,),
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
                          width: width/3,
                          height: height/25,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(4),
                          child: Text(snapshot.data.graduated?"Valid to take":"Not valid to take",style: const TextStyle(color: Colors.white),),
                          decoration: BoxDecoration(
                            color:snapshot.data.graduated? Colors.green:Colors.red,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height/30,),
                  Container(
                    margin: EdgeInsets.fromLTRB(width/15, 0, width/15, 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: width/20,),
                        const Text("Skill 2",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(width: width/6,),
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
                          width: width/3,
                          height: height/25,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(4),
                          child: Text(snapshot.data.graduated?"Valid to take":"Not valid to take",style: const TextStyle(color: Colors.white),),
                          decoration: BoxDecoration(
                              color:snapshot.data.graduated? Colors.green:Colors.red,
                              borderRadius: BorderRadius.circular(10)
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height/30,),
                  Container(
                    margin: EdgeInsets.fromLTRB(width/15, 0, width/15, 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: width/20,),
                        const Text("Skill 3",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(width: width/6,),
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
                          width: width/3,
                          height: height/25,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(4),
                          child: Text(snapshot.data.graduated?"Valid to take":"Not valid to take",style: const TextStyle(color: Colors.white),),
                          decoration: BoxDecoration(
                              color:snapshot.data.graduated? Colors.green:Colors.red,
                              borderRadius: BorderRadius.circular(10)
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height/20,),
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
                        if(cert(snapshot.data.graduated)){
                          final url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
                          final respone=await http.post(url,body:jsonEncode({
                            "service_id":"service_qequfbd",
                            "template_id":"template_cqa8g0v",
                            "user_id":"user_250n8DCL4ixgIFNmAGkNi",
                            "template_params":{
                              "name":snapshot.data.name,
                              "to_name":"Company name",
                              "message":"I have completed the intern",
                              "reply_to":snapshot.data.email,
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
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      setState(() {

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
            )*/
            ;
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },

      )
    );
  }
}
