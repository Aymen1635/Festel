import 'package:festel/src/screens/DetailsPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import'package:cloud_firestore/cloud_firestore.dart';




import '../../Animation/FadeAnimation.dart';
import 'home.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
  String email = "";
  SignUp(this.email, {Key key}) : super(key: key);


}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _FirstName, _LastName, _Number, _Username;
  var database = FirebaseDatabase.instance.reference();
  final AccountController = TextEditingController;

  final auth = FirebaseAuth.instance;
  var id = "a";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(

              image: AssetImage('assets/images/bbb.jpg'),
              fit: BoxFit.fill,


            )
        ),
        child: Form(key: _formKey,


          child: SingleChildScrollView(

              child: Container(

                child: Column(
                  children: <Widget>[
                    Container(
                      height: 240,

                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 30,
                            width: 80,
                            height: 200,
                            child: FadeAnimation(1, Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png')
                                  )
                              ),
                            )),
                          ),
                          Positioned(
                            left: 140,
                            width: 80,
                            height: 120,
                            child: FadeAnimation(1.3, Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png')
                                  )
                              ),
                            )),
                          ),
                          Positioned(
                            right: 40,
                            top: 40,
                            width: 80,
                            height: 150,
                            child: FadeAnimation(1.5, Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/clock.png'),

                                  )
                              ),
                            )),
                          ),
                          Positioned(
                            child: FadeAnimation(1.6, Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text("SignUp", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),),
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(1.8, Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(130, 50, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10)
                                  )
                                ]
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                          color: Colors.grey[100]))
                                  ),
                                  child: TextFormField(

                                    keyboardType: TextInputType.text,
                                    validator: validateName,
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.black,
                                    onChanged: (value) {
                                      setState(() {
                                        _FirstName = value.trim();
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "FirstName",
                                        hintStyle: TextStyle(
                                            color: Colors.white)

                                    ),

                                  ),

                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                          color: Colors.grey[100]))
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: validateName,
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.black,
                                    onChanged: (value) {
                                      setState(() {
                                        _LastName = value.trim();
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "LastName",
                                        hintStyle: TextStyle(
                                            color: Colors.white)

                                    ),
                                  ),

                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                          color: Colors.grey[100]))
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: validateName,
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.black,
                                    onChanged: (value) {
                                      setState(() {
                                        _Username = value.trim();
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                            color: Colors.white)

                                    ),
                                  ),

                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                          color: Colors.grey[100]))
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    validator: validateMobile,
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.black,
                                    onChanged: (value) {
                                      setState(() {
                                        _Number = value.trim();
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Phone number",
                                        hintStyle: TextStyle(
                                            color: Colors.white)

                                    ),
                                  ),

                                ),

                              ],
                            ),
                          )),


                          SizedBox(height: 50,),
                          FadeAnimation(2,
                            new GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    print("Validated");
                                    addUser();

                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyHomePage(FirstName: _FirstName,UserName : _Username,LastName : _LastName,Number : _Number)));
                                  } else {
                                    print("Not Validated");
                                  }
                                },
                                child: new Container(
                                  height: 50,

                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0),
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(143, 148, 251, 1),
                                            Color.fromRGBO(143, 148, 251, .6),
                                          ]
                                      )
                                  ),
                                  child: Center(
                                    child: Text("Sign up", style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                )),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),


    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateMobile(String value) {
   // Indian Mobile number are of 10 digit only
    if (value.length != 8)
      return 'Mobile Number must be of 8 digit';
    else
      return null;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    var myJSONObj = {
      'FirstName': _FirstName,
      'LastName': _LastName,
      'UserName': _Username,
      'Number': _Number,
    };
    users.doc("MyCustomID").set(myJSONObj);
    String email = FirebaseAuth.instance.currentUser.email;

    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'FirstName': _FirstName, // John Doe
      'LastName': _LastName, // Stokes and Sons
      'UserName': _Username, // 42
      'Number': _Number,
      'Email': email
    })

        .then((value) => print("User Added"))


        .catchError((error) => print("Failed to add user: $error"));

  }




}
