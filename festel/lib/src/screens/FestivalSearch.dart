import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festel/src/screens/FestivalDetails.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:festel/Animation/FadeAnimation.dart';
import 'package:festel/src/screens/DetailsPage.dart';
import 'package:random_date/random_date.dart';

import 'Search.dart';
import 'home.dart';
import 'login.dart';


class FestivalSearch extends StatefulWidget {
  @override
  _FestivalSearchState createState() => _FestivalSearchState(str, str2,filteredList);
  String str = "";
  String str2 = "";
  List<DocumentSnapshot>filteredList;


  FestivalSearch({Key key, this.str, this.str2,this.filteredList}) : super(key: key);

}

var auth = FirebaseAuth.instance;

class _FestivalSearchState extends State<FestivalSearch>{
  _FestivalSearchState(this.str, this.str2,this.filteredList);
  List<DocumentSnapshot> filteredList;
  String str = "";
  String str2 = "";
  DateTime _dateTime ;
  DateTime _dateTime2 ;



  bool isSearching = false;

  void _affichelist(){
    for(var i=0;i<filteredList.length;i++){
      print(filteredList[i]['Nom']);
    }
  }

  var auth = FirebaseAuth.instance;
  Random random = new Random();


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
      backgroundColor: Color.fromRGBO(0, 100, 165, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: !isSearching
            ? Text('All Festivals')
            : TextField(
          onChanged: (value) {

          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Search Festival Here",
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

      body:

      ListView(
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
            padding: EdgeInsets.only(left: 40.0),
            child: FadeAnimation(1, Row(
              children: <Widget>[
                Text(str,
                    style: TextStyle(
                        fontFamily: 'DancingScript',
                        color: Colors.white,

                        fontSize: 45.0)),
                SizedBox(width: 10.0),
                Text('',
                    style: TextStyle(
                        fontFamily: 'DancingScript',
                        color: Colors.white,
                        fontSize: 25.0))

              ],
            ),
            ),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 280,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    image: DecorationImage(
                        image: AssetImage('assets/images/background2.jpg'),
                        fit: BoxFit.fill
                    )
                ),



                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: filteredList.length,

                        itemBuilder: (context, index) {

                           DocumentSnapshot festivals = filteredList[index];



                          return FadeAnimation(1, Padding(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 10.0, top: 35.0),
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) =>
                                          FestivalDetailsPage(
                                              Name: festivals['Nom'],
                                              str2: str2,
                                              img: festivals['img'])));
                                  print(str2);
                                  print(str);
                                },
                                child: new Card(

                                  elevation: 6.0,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(
                                        16.0),
                                  ),
                                  child: new Column(
                                    children: <Widget>[

                                      new ClipRRect(
                                        child: new Image.network(
                                            festivals['img'],
                                            width: 350,
                                            height: 200,
                                            fit: BoxFit.fill
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topLeft: new Radius.circular(
                                                (16.0)),
                                            topRight: new Radius.circular(
                                                16.0)
                                        ),
                                      ),
                                      new Padding(
                                          padding: new EdgeInsets.all(16.0),
                                          child: new Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              new Text(
                                                  festivals['Nom'],
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Colors.black,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 25.0
                                                  )),


                                              new SizedBox(height: 16.0,),
                                              new Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    new Text(
                                                        festivals['Lieu']),

                                                    new Text(
                                                        festivals['Type']),
                                                    new Text(
                                                        festivals['Date']),

                                                  ]
                                              )
                                            ],
                                          ))
                                    ]

                                    ,
                                  ),
                                )


                            ),

                          ));
                        },


                      )


            ),
          )
        ],
      ),


    );
  }

  CollectionReference history = FirebaseFirestore.instance.collection(
      'Tunis');





}
