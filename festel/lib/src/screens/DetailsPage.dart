import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festel/src/screens/FestivalDetails.dart';
import 'package:festel/src/screens/FestivalSearch.dart';
import 'package:fluttertoast/fluttertoast.dart';
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


class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState(str, str2);
  String str = "";
  String str2 = "";


  DetailsPage({Key key, this.str, this.str2}) : super(key: key);
}

  var auth = FirebaseAuth.instance;

class _DetailsPageState extends State<DetailsPage>{
_DetailsPageState(this.str, this.str2);
String str = "";
String str2 = "";

DateTime _dateTime ;
DateTime _dateTime2;


List<DocumentSnapshot> L;

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
getData() async{
  var collectionReferece = await FirebaseFirestore.instance.collection(str);
  collectionReferece.get().then((collectionSnapshot){
    L = collectionSnapshot.docs.toList();

  });

}

 _filterFestivals(DateTime dateTime,DateTime dateTime2) {

  getData();


   L.forEach((element) {
     String formatted = element['Date'].toString().substring(6, 10) +
         element['Date'].toString().substring(3, 5) +
         element['Date'].toString().substring(0, 2);

     DateTime d = DateTime.parse(formatted);


     int a = dateTime.microsecondsSinceEpoch;
     int b = dateTime2.microsecondsSinceEpoch;
     int c = d.microsecondsSinceEpoch;
     print(c);
     if (a < c && c < b) {
       filteredList.add(element);
       print(element['Date']);
     }
   });
 }
DocumentSnapshot d;
_CleanFestivals() {

  L.forEach((element) {
    if(element['Date'].toString().length<10){
      d=element;
      print(d['Date']);
    }


  });
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


                    Container(
                        width:
                        300.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0)),
                                color: Color.fromRGBO(143, 148, 251, 1),
                                textColor: Colors.white,
                                child: Text(
                                  "1st Date",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18.0,
                                  horizontal: 4.0,
                                ),
                                onPressed: () {
                                  showDatePicker(context: context,
                                      initialDate: _dateTime == null
                                          ? DateTime.now()
                                          : _dateTime,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2022)).then((
                                      date) {
                                    setState(() {
                                        _dateTime = date;


                                    });
                                  });
                                }),
                            RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0)),
                                color: Color.fromRGBO(143, 148, 251, 1),
                                textColor: Colors.white,
                                child: Text(
                                  "2nd Date",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18.0,
                                  horizontal: 4.0,
                                ),
                                onPressed: () {
                                  showDatePicker(context: context,
                                      initialDate: _dateTime2 == null
                                          ? DateTime.now()
                                          : _dateTime2,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2022)).then((
                                      date2) {
                                    setState(() {
                                    _dateTime2 = date2;


                                    });
                                  });
                                }),
                            RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0)),
                                color: Color.fromRGBO(143, 148, 251, 1),
                                textColor: Colors.white,
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18.0,
                                  horizontal: 4.0,
                                ),
                                onPressed: () {
                                  _filterFestivals(_dateTime,_dateTime2);
                                  FirebaseFirestore.instance.collection(str);
                                  if(filteredList.length>0) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) =>
                                            FestivalSearch(str: str,str2: str2,filteredList:filteredList,)));
                                  }
                                  else{
                                    Fluttertoast.showToast(
                                        msg: "List is empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    print(str);
                                  }

                                  })
                          ],
                        ))
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
                      .height - 230,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      image: DecorationImage(
                          image: AssetImage('assets/images/background2.jpg'),
                          fit: BoxFit.fill
                      )
                  ),


                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection(str)
                          .snapshots(),

                      builder: (context, snapshot) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:  snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot festivals =snapshot.data.docs[index];

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


                        );
                      })

              ),
            )
          ],
        ),


      );
    }

CollectionReference history = FirebaseFirestore.instance.collection(
    'Tunis');



Future<void> addUser() {

  for (var i = 1; i < 101; i++) {
    var dateTime = RandomDate.withRange(2021, 2021).random();
    var formattedDate = dateTime.toString();
    String date = formattedDate.substring(9,10)+"/"+formattedDate.substring(6,7)+"/"+formattedDate.substring(0,4);
      print(formattedDate);
     history
        .add({
      'Date': date, // John Doe
      'Lieu': "Tunis", // Stokes and Sons
      'Nom': "Nom"+i.toString(), // 42
      'Type': "Type"+i.toString(),
      'img': "https://picsum.photos/600/600",

    })

    .then((value) => print("User Added"))

         .catchError((error) => print("Failed to add user: $error"));
  }
}

}


