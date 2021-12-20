import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:festel/Animation/FadeAnimation.dart';
import 'package:festel/src/screens/Account.dart';
import 'package:festel/src/screens/Search.dart';
import 'package:festel/src/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DetailsPage.dart';
import 'History.dart';
class MyHomePage extends StatefulWidget{
@override
_MyHomePageState createState() => _MyHomePageState(FirstName,LastName,UserName,Number);
MyHomePage({Key key,this.FirstName,this.LastName,this.UserName,this.Number}): super(key: key);
//img: imgUrl,Name: hotelName,Location: location,Stars: rating,Description: Description,Price: Price

String FirstName = "";
String LastName = "";
String UserName = "";
String Number = "";




}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.firstName, this.lastName, this.userName, this.number);

  String firstName = "";
  String lastName = "";
  String userName = "";
  String number = "";
  String str2="";
  List<DocumentSnapshot> L = [];
  List <DocumentSnapshot>filteredList = [];
  bool isSearching = false;




  void _filterCountries(value) {
    setState(() {
      filteredList = L
          .where((state) =>
          state['Nom'].toLowerCase().contains(value.toLowerCase()))
          .toList();
      print(filteredList[0]['Nom']);

    });
  }
  var auth = FirebaseAuth.instance;





    @override
    Widget build(BuildContext context) {
      Widget LogoutButton = ElevatedButton(
          onPressed: () {
            auth.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text('Logout'));
      Widget cancelButton = ElevatedButton(

        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyHomePage()));
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Notice"),
        content: Text("Are you sure you want to Logout?"),
        actions: [
          LogoutButton,
          cancelButton,


        ],
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
      );

      return Scaffold(
        bottomNavigationBar: bottomNavigationBar(context),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: !isSearching
              ? Text('All States')
              : TextField(
            onChanged: (value) {
              _filterCountries(value);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: "Search State Here",
                hintStyle: TextStyle(color: Colors.white)),
          ),
          actions: <Widget>[
            isSearching
                ? IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                if(filteredList.length>0){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MySearchPage(L: filteredList)));
                }
              },
            )
                : IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  this.isSearching = true;
                });
              },
            )
          ],
        ),


        backgroundColor: Color.fromRGBO(0, 100, 165, 1),
        body:
        Container(


          child: ListView(

            children: <Widget>[
              Padding(

                  padding: EdgeInsets.only(top: 15.0, left: 10.0, bottom: 10.0),
                  child: FadeAnimation(1, Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      IconButton(
                        icon: Icon(Icons.cancel),
                        color: Colors.redAccent,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                      ),

                    ],
                  ),
                  )
              ),

              SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: FadeAnimation(1, Row(
                  children: <Widget>[
                    Text('Festel',
                        style: TextStyle(
                            fontFamily: 'DancingScript',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 45.0)),
                    SizedBox(width: 10.0),
                    Text('',
                        style: TextStyle(
                            fontFamily: 'DancingScript',
                            color: Colors.white,
                            fontSize: 35.0))


                  ],
                ),
                ),
              ),

              SizedBox(height: 40.0),
              Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 300.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/bb.jpg'),
                          fit: BoxFit.fill
                      )
                  ),

                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Festivals")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot festivals = snapshot.data
                              .docs[index];
                          L.add(festivals);



                          return FadeAnimation(1, Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, right: 10.0, top: 35.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsPage(
                                                    str: festivals['Nom'],
                                                    str2: "H" +
                                                        festivals['Nom'])
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          child: Row(
                                              children: [
                                                Hero(
                                                    tag: festivals['img'],
                                                    child: Image.network(
                                                      festivals['img'],
                                                      fit: BoxFit.cover,
                                                      height: 120.0,
                                                      width: 200.0,
                                                    )
                                                ),
                                                SizedBox(width: 10.0),
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                          festivals['Nom'],
                                                          style: TextStyle(
                                                              fontFamily: 'Montserrat',
                                                              fontSize: 18.0,
                                                              color: Colors
                                                                  .white,
                                                              fontWeight: FontWeight
                                                                  .bold
                                                          )
                                                      ),
                                                      Text(
                                                          festivals['location'],
                                                          style: TextStyle(
                                                              fontFamily: 'Montserrat',
                                                              fontSize: 15.0,
                                                              color: Colors.grey
                                                          )
                                                      )
                                                    ]
                                                )
                                              ]
                                          )
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.arrow_forward_ios),
                                          color: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsPage(
                                                            str: festivals['Nom'],
                                                            str2: "H" +
                                                                festivals['Nom'])
                                                ));
                                          }
                                      )
                                    ],
                                  )
                              )
                          )

                          );
                        },

                      );
                    },


                  )


              )


            ],

          ),

        ),


      );
    }


    Widget bottomNavigationBar(context) {
      int _currentindex = 0;
      final List<Widget> _children = [];
      return Container(
        margin: EdgeInsets.only(left: 0, right: 0),
        decoration: BoxDecoration(
          color: Colors.white,

        ),
        child: BottomNavigationBar(

          currentIndex: 0,
          backgroundColor: Colors.transparent,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: new IconButton(
              icon: new Icon(Icons.person),
              highlightColor: Colors.pink,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
            ), title: Text('Profile')),
            BottomNavigationBarItem(icon: new IconButton(
              icon: new Icon(Icons.local_activity),
              highlightColor: Colors.pink,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyHistory()));
              },
            ), title: Text('History')),
            BottomNavigationBarItem(icon: new IconButton(
              icon: new Icon(Icons.home),
              highlightColor: Colors.pink,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ), title: Text('Home')),


          ],
        ),
      );
    }
  }
