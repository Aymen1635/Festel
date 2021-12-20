import 'package:festel/src/screens/Reset.dart';
import 'package:festel/src/screens/SignUp.dart';
import 'package:festel/src/screens/Verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../Animation/FadeAnimation.dart';
import 'home.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email,_password;

  final auth = FirebaseAuth.instance;
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
                                      image: AssetImage('assets/images/light-1.png')
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
                                      image: AssetImage('assets/images/light-2.png')
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
                                      image: AssetImage('assets/images/clock.png'),

                                  )
                              ),
                            )),
                          ),
                          Positioned(
                            child: FadeAnimation(1.6, Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                                      border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                  ),
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.black,
                                    onChanged: (value) {
                                      setState(() {
                                        _email = value.trim();
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email or Phone number",
                                        hintStyle: TextStyle(color: Colors.white)

                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    obscureText: true,

                                    cursorColor: Colors.black,
                                    onChanged: (value) {
                                      setState(() {
                                        _password = value.trim();
                                      });
                                    },
                                    decoration: InputDecoration(


                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.white)
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                          SizedBox(height: 50,),
                          FadeAnimation(2,
                              new GestureDetector(
                                  onTap: () => Signin(_email, _password),


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
                              child: Text("Sign in", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          )),
                          ),
                          SizedBox(height: 50,),
                          FadeAnimation(2,
                            new GestureDetector(
                                onTap: () => Signup(_email, _password),
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
                                    child: Text("Sign up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                )),
                          ),
                          SizedBox(height: 20, ),
                          FadeAnimation(1.5, TextButton(child: Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),),onPressed:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetScreen()))),
                          )],
                      ),
                    )
                  ],
                ),
              )
              ),
          ),


    );





  }
  Signin(String _email,String _password) async {
    try{
      await auth.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyHomePage()));
    } on FirebaseAuthException catch(error){
      Fluttertoast.showToast(
          msg: error.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }
  Signup(String _email,String _password) async {
    try{
     await auth.createUserWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignUp(_email)));
    } on FirebaseAuthException catch(error){
      Fluttertoast.showToast(
          msg: error.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }
}



