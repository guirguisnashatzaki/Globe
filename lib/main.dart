import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled1/specificationchoose.dart';
import 'package:untitled1/studentmodel.dart';

const String boxname="StudentBox";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final document=await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  //Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<bool>('cer');
  /*var box = Hive.box('cer');
  box.put('valid', true);
  var name = box.get('valid');*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    User? user= FirebaseAuth.instance.currentUser;
    //FirebaseAuth.instance.signOut();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:user==null?const Home():Pagedd(mail: user.email)
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late DateTime _dateTime;
  TextEditingController DOBcontroller=TextEditingController(text: "");
  TextEditingController Namecontroller=TextEditingController(text: "");
  TextEditingController Mailcontroller=TextEditingController(text: "");
  TextEditingController Phonecontroller=TextEditingController(text: "");
  TextEditingController unicontroller=TextEditingController(text: "");
  TextEditingController anscontroller=TextEditingController(text: "");
  late double width,height;
  final _formKey = GlobalKey<FormState>();
  String value1="Faculty";
  String value2="Academic year";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    DOBcontroller.dispose();
    Namecontroller.dispose();
    Mailcontroller.dispose();
    Phonecontroller.dispose();
    unicontroller.dispose();
    anscontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.white,
            ],
          )
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 70, 30, 70),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(3, 3), // changes position of shadow
              ),
            ]
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: height/50,),
                  CircleAvatar(
                    child: Image.asset("assets/logofinal.png"),
                    radius: width/6,
                    backgroundColor: Colors.white,
                  ),
                  Material(
                    //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child: Container(
                      //margin: EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft, 
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: const Text("Important Note :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),)
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: RichText(
                                text: const TextSpan(
                                  text: "This registration can be done ",
                                  children: [
                                    TextSpan(text: "Once",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 15))
                                  ],
                                  style: TextStyle(color: Colors.black)
                                ),

                              )
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: RichText(
                                text: const TextSpan(
                                    text: "So take care while applying your information because ",
                                    children: [
                                      TextSpan(text: "you will not be able edit it",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 15))
                                    ],
                                    style: TextStyle(color: Colors.black)
                                ),

                              )
                          ),
                        ],
                      )
                    ),
                  ),
                  Material(
                    //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child: Container(
                      //margin: EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                      child: TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return "                Required *";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          //hintText: "Name",
                          labelText: "Name",
                          prefixIcon: Icon(Icons.account_circle),
                          //helperText: "Name here",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textInputAction: TextInputAction.next,
                        controller: Namecontroller,
                      ),
                    ),
                  ),
                  //SizedBox(height: height/20,),
                  Material(
                    //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child: Container(
                      //margin: EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                      child: TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return "                Required *";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          //hintText: "Name",
                          labelText: "Email",
                          prefixIcon: Icon(Icons.mail),
                          //helperText: "Name here",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textInputAction: TextInputAction.next,
                        controller: Mailcontroller,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  //SizedBox(height: height/20,),
                  Material(
                    //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child: Container(
                      //margin: EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                      child: TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return "                Required *";
                          }

                          if(value.length!=11){
                            return "                it should be 11 characters *";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          //hintText: "Name",
                          labelText: "Mobile number",
                          prefixIcon: Icon(Icons.phone_android),
                          //helperText: "Name here",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textInputAction: TextInputAction.next,
                        controller: Phonecontroller,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                  //SizedBox(height: height/20,),
                  Material(
                    //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child: Container(
                      //margin: EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                      child: TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return "                Required *";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Click me!!",
                          labelText: "Birthday",
                          prefixIcon: Icon(Icons.calendar_today_sharp),
                          //helperText: "Click me!!",
                          border: InputBorder.none,
                        ),
                        //enabled: false,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textInputAction: TextInputAction.next,
                        onTap: (){
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1990),
                              lastDate: DateTime(2025)
                          ).then((value){
                            setState(() {
                              _dateTime=value!;
                              String s=_dateTime.day.toString()+"/"+_dateTime.month.toString()+"/"+_dateTime.year.toString();
                              DOBcontroller.text=s;
                            });
                          });
                        },
                        controller: DOBcontroller,
                      ),
                    ),
                  ),
                  //SizedBox(height: height/20,),
                  Container(
                    padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                    child: Row(
                      children: [
                        Icon(Icons.account_balance_wallet,color: Colors.grey[600],),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          color: Colors.white,
                          alignment: Alignment.centerLeft,
                          child: DropdownButton(
                              value: value1,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold,fontSize: 18),
                              underline: Container(
                                height: 1,
                                color: Colors.grey.shade600,
                              ),
                              items: <String>["Faculty","Pharmacy","Science","Veterinary"]
                                  .map<DropdownMenuItem<String>>((value){
                                return DropdownMenuItem(
                                    value: value,
                                    child: Text(value)
                                );
                              }).toList(),
                              onChanged: (String? value){
                                setState(() {
                                  value1=value!;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(height: height/20,),
                  Material(
                    //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child: Container(
                      //margin: EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                      child: TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return "                Required *";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          //hintText: "Name",
                          labelText: "University",
                          prefixIcon: Icon(Icons.account_balance),
                          //helperText: "Name here",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textInputAction: TextInputAction.next,
                        controller: unicontroller,
                        //keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                    child: Row(
                      children: [
                        Icon(Icons.album_sharp,color: Colors.grey[600],),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          color: Colors.white,
                          alignment: Alignment.centerLeft,
                          child: DropdownButton(
                              value: value2,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold,fontSize: 18),
                              underline: Container(
                                height: 1,
                                color: Colors.grey.shade600,
                              ),
                              items: <String>["Academic year","First","Second","Third","Fourth","Fifth"]
                                  .map<DropdownMenuItem<String>>((value){
                                return DropdownMenuItem(
                                    value: value,
                                    child: Text(value)
                                );
                              }).toList(),
                              onChanged: (String? value){
                                setState(() {
                                  value2=value!;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height/50,),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: Text(
                      "Did you need to get on hand expert field?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600
                      ),
                    ),
                  ),
                  Material(
                    //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child: Container(
                      //margin: EdgeInsets.all(10),
                      padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                      color: Colors.white,
                      child: TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return "Required *";
                          }

                          if(value.compareTo("yes")==0&&value.compareTo("no")==0){
                            return "(Yes or No only)";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          //hintText: "Name",
                          labelText: "Answer (Yes or No only)",
                          //prefixIcon: Icon(Icons.account_balance),
                          //helperText: "Name here",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textInputAction: TextInputAction.next,
                        controller: anscontroller,
                        //keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if(value1=="Faculty"||value2=="Academic year"){

                            if(value1=="Faculty"){
                              const snackBar = SnackBar(
                                content: Text('Choose your faculty'),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }

                            if(value2=="Academic year"){
                              const snackBar = SnackBar(
                                content: Text('Choose your Academic year'),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }else{
                            String temp=anscontroller.text;
                            temp=temp.toLowerCase();
                            Student student=Student(Namecontroller.text, Mailcontroller.text, Phonecontroller.text, DOBcontroller.text,value2,value1,temp,unicontroller.text);
                            try {
                              /*final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: student.email,
                                password: student.phone,
                              );
                              student.id=credential.user!.uid;*/
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=> Specichoose(student: student,context: context,)));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                SnackBar snackBar = SnackBar(
                                  content: Text(e.code),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } else if (e.code == 'email-already-in-use') {
                                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=> Specichoose(student: student,)));

                                SnackBar snackBar = SnackBar(
                                  content: Text(e.code),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else{
                                SnackBar snackBar = SnackBar(
                                  content: Text(e.code),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            } catch (e) {
                              SnackBar snackBar = SnackBar(
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }
                        }
                      },
                      child: const Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),

                  ),
                  SizedBox(height: height/50,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

