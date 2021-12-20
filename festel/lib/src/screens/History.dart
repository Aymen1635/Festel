import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festel/Animation/FadeAnimation.dart';
import 'package:festel/src/screens/Account.dart';
import 'package:festel/src/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DetailsPage.dart';
import 'home.dart';






class MyHistory extends StatelessWidget {




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
            MaterialPageRoute(builder: (context) => MyHistory()));
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
                  Text('History',
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
                  stream: FirebaseFirestore.instance.collection("History")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot history = snapshot.data.docs[index];

                        return FadeAnimation(1, Padding(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 10.0, top: 35.0),
                            child: InkWell(
                                onTap: () {

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        child: Row(
                                            children: [
                                              Hero(
                                                  tag: history['img'],
                                                  child: Image.network(
                                                    history['img'],
                                                    fit: BoxFit.cover,
                                                    height: 80.0,
                                                    width: 140.0,
                                                  )
                                              ),
                                              SizedBox(width: 10.0),
                                              Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                        history['Name'],
                                                        style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontSize: 18.0,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                                .bold
                                                        )
                                                    ),

                                                    Text(
                                                        history['Date'],
                                                        style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontSize: 18.0,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                                .bold
                                                        )
                                                    ),
                                                    Text('Number of nights: '+
                                                        history['Number'].toString(),
                                                        style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontSize: 15.0,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                            .bold
                                                        )
                                                    ),
                                                    Text('Price: '+
                                                        history['Price'].toString()+'Dt',
                                                        style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontSize: 15.0,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                                .bold
                                                        )
                                                    ),

                                                  ]
                                              )
                                            ]
                                        )
                                    ),

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
          BottomNavigationBarItem(
              icon: Icon(Icons.local_activity), title: Text('History')),
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
