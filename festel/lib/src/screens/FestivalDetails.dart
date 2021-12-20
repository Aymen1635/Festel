

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festel/Animation/FadeAnimation.dart';

import 'package:festel/src/screens/payment.dart';
import 'package:flutter/material.dart';
import 'dart:math';


import 'DetailsPage.dart';

class FestivalDetailsPage extends StatelessWidget {
  String Name ="";
  String str2 = "";
  FestivalDetailsPage({Key key,this.Name,this.img, this.str2}): super(key: key);
  String img ="";





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: BoxDecoration(
                  color: Colors.black26
              ),
              height: 400,
              child: Image.network(img
                  , fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0,bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16.0),
                  child: Text(
                    Name,
                    style: TextStyle(color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'
                    ),

                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(5.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[


                      const SizedBox(height: 30.0),
                      Text("Description".toUpperCase(), style: TextStyle(
                        fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0
                      ),),
                      const SizedBox(height: 10.0),
                      Text(
                        "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi ", textAlign: TextAlign.justify, style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                        fontFamily: 'Montserrat'


                      ),),
                      const SizedBox(height: 30.0),
                      Text("Hotels Nearby".toUpperCase(), style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0
                      ),),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Hotels").snapshots(),
                        builder: (context, snapshot) {

                          return SizedBox(

                            child:DefaultTabController(
                              length: 1,
                              child: Expanded(
                              child: Column(
                                  children: [

                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              height: 280.0,
                              child: TabBarView(
                                children: [
                              //Now let's create our first tab page
                              Container(

                              child:StreamBuilder(
                                stream: FirebaseFirestore.instance.collection(str2).snapshots(),
                                builder: (context, snapshot) {
                                  return ListView.builder(

                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index){
                                      DocumentSnapshot Hotels = snapshot.data.docs[index];


                                      return FadeAnimation(1,Padding(
                                          padding: EdgeInsets.only(left: 20.0, right: 10.0, top: 35.0),
                                          child: InkWell(
                                              onTap: () {


                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                      child: Row(
                                                          children: [
                                                            travelCard(
                                                                Hotels['img'], Hotels['Name'],Hotels['Distance'], Hotels['Stars'],Hotels['Description'],Hotels['Price'],context,str2),



                                                          ]
                                                      )
                                                  ),

                                                ],
                                              )
                                          )));
                                    },
                                  );
                                }
                              ),
                            ),
                              ]),
                          ),
                          ],
                              ),
                          )));
                        }
                      )
                    ],
                  ),
                ),
              ],
            ),


          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text("DETAIL",style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal
              ),),
            ),
          ),
        ],
      ),
    );
  }
}

Widget travelCard(
    String imgUrl, String hotelName, String location, int rating,String Description,var Price,BuildContext context,String str2)  {
  return Card(
    margin: EdgeInsets.only(right: 22.0),
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    elevation: 0.0,
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Payment(img: imgUrl,Name: hotelName,Location: location,Stars: rating,Description: Description,Price: Price)
        ));

      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover,
              scale: 2.0,
            )),
        width: 200.0,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //this loop will allow us to add as many star as the rating
                  for (var i = 0; i < rating; i++)
                    Icon(
                      Icons.star,
                      color: Color(0xFFFE8C68),
                    ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotelName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      location,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}








