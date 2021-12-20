import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


class Payment extends StatefulWidget{
  @override
  _PaymentState createState() => _PaymentState(Name,img,Location,Stars,Price,Description);
  Payment({Key key,this.img,this.Name,this.Location,this.Stars,this.Description,this.Price}): super(key: key);
//img: imgUrl,Name: hotelName,Location: location,Stars: rating,Description: Description,Price: Price

  String Name = "";
  String img = "";
  String Location = "";
  int Stars = 0;
  var Price = 0;
  String Description = "";



}
class _PaymentState extends State<Payment> {
  final razorpay = Razorpay();
  DateTime _dateTime;
  String formattedDate;

  TextEditingController controller = TextEditingController();
  static final String path = "lib/src/pages/hotel/details.dart";
  final String image = "assets/hotel/room3.jpg";
  var auth = FirebaseAuth.instance;

  String Name = "";
  String img = "";
  String Location = "";
  int Stars = 0;
  int Price = 0;
  String Description = "";

  _PaymentState(this.Name, this.img, this.Location, this.Stars, this.Price,
      this.Description);


  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paySuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, payError);
    super.initState();
  }

  void paySuccess(PaymentSuccessResponse response) {
    print(response.paymentId.toString());
  }

  void payError(PaymentFailureResponse response) {
    print(response.message + response.code.toString());
  }

  void externalWallet(ExternalWalletResponse response) {
    print(response.walletName);
  }

  getPayment(int price, int n) {
    var option = {
      'key': 'rzp_test_LbNfCwfHTvfXiW',
      'amount': Price * 100 * n,
      'name': this.Name,
      'prefill': {'contact': '20288925', 'email': auth.currentUser.email}
    };
    try {
      razorpay.open(option);
    } catch (e) {
      print('error is $e');
    }
  }


  int _n = 1;

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0)
        _n--;
    });
  }

  @override
  Widget build(BuildContext context) {
    String stringValue = Price.toString();
    var auth = FirebaseAuth.instance;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(

                foregroundDecoration: BoxDecoration(color: Colors.black26),
                height: 400,
                child: Image.network(img
                    , fit: BoxFit.cover)),
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 250),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      Name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 16.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          "8.4/85 reviews",
                          style: TextStyle(color: Colors.white, fontSize: 13.0),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(32.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      //this loop will allow us to add as many star as the rating
                                      for (var i = 0; i < Stars; i++)
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFFFE8C68),
                                        ),
                                    ],
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(
                                            Icons.location_on,
                                            size: 16.0,
                                            color: Colors.grey,
                                          )),
                                      TextSpan(
                                        text: Location,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ]),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.0),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  stringValue,
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                Text(
                                  "/per night",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 30.0),

                        SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                color: Colors.purple,
                                textColor: Colors.white,
                                child: Text(
                                  "Book Now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18.0,
                                  horizontal: 32.0,
                                ),
                                onPressed: () {
                                  getPayment(Price, _n);
                                  addUser();
                                }
                            )),
                        const SizedBox(height: 30.0),
                        Row(

                            children: <Widget>[
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(formattedDate == null
                                      ? 'No Date Picked'
                                      : formattedDate,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),


                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30.0)),
                                      color: Colors.purple,
                                      textColor: Colors.white,
                                      child: Text(
                                        "Pick a date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 18.0,
                                        horizontal: 15.0,
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
                                            formattedDate =
                                                DateFormat('dd-MM-yyyy').format(
                                                    _dateTime);
                                          });
                                        });
                                      }),
                                ),
                              )


                            ]

                        ),

                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,


                              children: <Widget>[
                                Text(

                                  "How many nights?".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(

                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0),
                                ),
                                new FloatingActionButton(
                                  splashColor: Colors.purple,
                                  onPressed: add,
                                  child: new Icon(
                                    Icons.add, color: Colors.black,),
                                  backgroundColor: Colors.white,),

                                new Text('$_n',
                                    style: new TextStyle(fontSize: 25.0)),

                                new FloatingActionButton(

                                  splashColor: Colors.purple,
                                  onPressed: minus,
                                  child: new Icon(
                                      Icons.remove, color: Colors.black),
                                  backgroundColor: Colors.white,),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Text(
                          "Description".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25.0),
                        ),


                        Text(
                          Description,

                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 20.0),
                        ),


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
                title: Text(
                  "DETAIL",
                  style: TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        )

    );
  }

  CollectionReference history = FirebaseFirestore.instance.collection(
      'History');

  Future<void> addUser() {

      return history
          .add({
        'Date': formattedDate, // John Doe
        'Name': Name, // Stokes and Sons
        'Number': _n, // 42
        'Price': Price * _n,
        'img': img,

      })

          .then((value) => print("User Added"))


          .catchError((error) => print("Failed to add user: $error"));
    }
  }
