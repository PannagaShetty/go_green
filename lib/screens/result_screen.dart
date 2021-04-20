import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gogreen/components/LoginPage.dart';
import 'package:gogreen/components/calculator_brain.dart';

import 'package:gogreen/components/input_container_heading.dart';
import 'package:gogreen/components/launcher.dart';
import 'package:gogreen/constants.dart';
import 'package:gogreen/components/variables.dart';
import 'package:gogreen/components/circular_progress_bar.dart';
import 'package:gogreen/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/variables.dart';

class ResultScreen extends StatefulWidget {
  static String id = 'result_screen';
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void addResultToCloud() {
    Firestore.instance.collection('footprint').add({
      'isNew': true,
      'user': '$userName',
      'latitude': userLatitude,
      'longitude': userLongitude,
      'totalFootprint': totalFootprint,
      'housingFootprint': housingFootprint,
      'travelFootprint': travelFootprint,
      'foodFootprint': foodFootprint,
      'habitsFootprint': productFootprint,
      'timeStamp': DateTime.now()
    });
  }

  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  var src = new GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    CalculatorBrain.calculateFootprint();
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
    print(userLongitude);
    print(userLatitude);
    addResultToCloud();
  }

  takeScreenshot() async {
    RenderRepaintBoundary boundary = src.currentContext.findRenderObject();
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);

    var pngBytes = byteData.buffer.asUint8List();

    await Share.file('esys image', 'esys.png', pngBytes, 'image/png',
        text: 'I have calculated my Carbon footprint ');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      endDrawer: ClipPath(
        clipper: _DrawerClipper(),
        child: Drawer(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Spacer(),
                Container(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            launchUrl('http://www.sdmesociety.in/contact/');
                          });
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Contact Us  ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.contact_phone)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            launchUrl('http://www.sdmesociety.in/contact/');
                          });
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Privacy Policy  ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.info)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          _auth.signOut();
                          Navigator.pushReplacementNamed(context, LoginPage.id);
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'LogOut  ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.close)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                Opacity(
                  opacity: 0.7,
                  child: Container(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Column(
                      children: [
                        Text(
                          'Copyright 2020 - SDM Educational Society Ujire.',
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Designed by SDMIT',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0.0,
        title: Text(
          "Go Green",
          style: TextStyle(
            fontSize: 28,
            color: kInputTextColor,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
//      floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.home),
//          backgroundColor: Colors.green,
//          hoverColor: Colors.lightGreen,
//          hoverElevation: 5.0,
//          elevation: 10.0,
//          onPressed: () {
////            Navigator.pushNamed(context, HomeScreen.id);
//            takeScreenshot();
//          }),
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  'Result',
                  style: TextStyle(
                      color: kInputTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RepaintBoundary(
                  key: src,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 20.0),
                    decoration: kInputContainerDecoration.copyWith(
                        color: kBackgroundColor),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Your Average Carbon Footprint is: ',
                          style: TextStyle(color: kInputTextColor),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '$totalFootprint %',
                          style: TextStyle(
                              color: Colors.red[900],
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          totalFootprint <= 100 && totalFootprint > 80
                              ? 'Very High'
                              : totalFootprint <= 80 && totalFootprint > 60
                                  ? 'High'
                                  : totalFootprint <= 60 && totalFootprint > 40
                                      ? 'Moderate'
                                      : totalFootprint <= 40 &&
                                              totalFootprint > 20
                                          ? 'Less'
                                          : 'Very Less',
                          style: TextStyle(color: Colors.red[900]),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RadialProgress(
                                    goalCompleted: housingPercentage,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    '\nHousing',
                                    style: TextStyle(
                                        color: kInputTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    housingFootprint <= 100 &&
                                            housingFootprint > 80
                                        ? 'Very High'
                                        : housingFootprint <= 80 &&
                                                housingFootprint > 60
                                            ? 'High'
                                            : housingFootprint <= 60 &&
                                                    housingFootprint > 40
                                                ? 'Moderate'
                                                : housingFootprint <= 40 &&
                                                        housingFootprint > 20
                                                    ? 'Less'
                                                    : 'Very Less',
                                    style: TextStyle(
                                        color: kInputTextColor, fontSize: 10),
                                  ),
                                  // Text(
                                  //   'Co2/year',
                                  //   style: TextStyle(
                                  //       color: kInputTextColor, fontSize: 10),
                                  // )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RadialProgress(
                                    goalCompleted: travelPercentage,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    '\nTravel',
                                    style: TextStyle(
                                        color: kInputTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    travelFootprint <= 100 &&
                                            travelFootprint > 80
                                        ? 'Very High'
                                        : travelFootprint <= 80 &&
                                                travelFootprint > 60
                                            ? 'High'
                                            : travelFootprint <= 60 &&
                                                    travelFootprint > 40
                                                ? 'Moderate'
                                                : travelFootprint <= 40 &&
                                                        travelFootprint > 20
                                                    ? 'Less'
                                                    : 'Very Less',
                                    style: TextStyle(
                                        color: kInputTextColor, fontSize: 10),
                                  ),
                                  // Text(
                                  //   'Co2/year',
                                  //   style: TextStyle(
                                  //       color: kInputTextColor, fontSize: 10),
                                  // )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RadialProgress(
                                    goalCompleted: foodPercentage,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    '\nFood',
                                    style: TextStyle(
                                        color: kInputTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    foodFootprint <= 100 && foodFootprint > 80
                                        ? 'Very High'
                                        : foodFootprint <= 80 &&
                                                foodFootprint > 60
                                            ? 'High'
                                            : foodFootprint <= 60 &&
                                                    foodFootprint > 40
                                                ? 'Moderate'
                                                : foodFootprint <= 40 &&
                                                        foodFootprint > 20
                                                    ? 'Less'
                                                    : 'Very Less',
                                    style: TextStyle(
                                        color: kInputTextColor, fontSize: 10),
                                  ),
                                  // Text(
                                  //   'Co2/year',
                                  //   style: TextStyle(
                                  //       color: kInputTextColor, fontSize: 10),
                                  // )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RadialProgress(
                                    goalCompleted: productPercentage,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    'Habits and\n Practices',
                                    style: TextStyle(
                                        color: kInputTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    productFootprint <= 100 &&
                                            productFootprint > 80
                                        ? 'Very High'
                                        : productFootprint <= 80 &&
                                                productFootprint > 60
                                            ? 'High'
                                            : productFootprint <= 60 &&
                                                    productFootprint > 40
                                                ? 'Moderate'
                                                : productFootprint <= 40 &&
                                                        productFootprint > 20
                                                    ? 'Less'
                                                    : 'Very Less',
                                    style: TextStyle(
                                        color: kInputTextColor, fontSize: 10),
                                  ),
                                  // Text(
                                  //   'Co2/year',
                                  //   style: TextStyle(
                                  //       color: kInputTextColor, fontSize: 10),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 0),
                          child: Text(
                            'Note: The above Result is not accurate it may vary with other products',
                            style: kDiscalimerTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: kInputContainerDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              InputHeadingContainer(
                                text: 'Tips to Reduce Carbon Footprint',
                                image: AssetImage('images/traffic.jpg'),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 15.0),
                                      child: Text(
                                          'Learn the 5 R’s: refuse, reduce, reuse, rot, recycle'),
                                    ),
                                    Divider(
                                      thickness: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 15.0),
                                      child: Text(
                                          'Use more public transport rather then using personal vehicle'),
                                    ),
                                    Divider(
                                      thickness: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 15.0),
                                      child: Text(
                                          'Reduce use of Electricity also try to use Solar at home'),
                                    ),
                                    Divider(
                                      thickness: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 15.0),
                                      child: Text(
                                          'Eat seasonally, locally,reduce the consumption of meat and eat more plants'),
                                    ),
                                    Divider(
                                      thickness: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 15.0),
                                      child: Text(
                                          'Switch to sustainable and clean Energy'),
                                    ),
                                    Divider(
                                      thickness: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 15.0),
                                      child: Text(
                                          'Reduce the consumption of water and also usage of non degradable substance '),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                          child: Text(
                              'All the above calculation is done based on the data given in the link below',
                              textAlign: TextAlign.center,
                              style: kDiscalimerTextStyle),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(
                                'https://drive.google.com/drive/folders/1aQgh6YUSIJlAoY0UPdfsY7h6NFRvHsFo');
                          },
                          child: Text('click Here', style: kLinkTextStyle),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
              right: 30,
              bottom: 30,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  IgnorePointer(
                    child: Container(
                      color: Colors.black.withOpacity(
                          0.0), // comment or change to transparent color
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(270),
                        degOneTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degOneTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Colors.lightGreen,
                        width: 50,
                        height: 50,
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        onClick: () {
                          print('First Button');
                          Navigator.pushNamed(context, HomeScreen.id);
                        },
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(225),
                        degTwoTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degTwoTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Colors.lightGreen,
                        width: 50,
                        height: 50,
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        onClick: () {
                          takeScreenshot();
                        },
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(180),
                        degThreeTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degThreeTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Colors.lightGreen,
                        width: 50,
                        height: 50,
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                        onClick: () {
                          _scaffoldKey.currentState.openEndDrawer();
                        },
                      ),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value)),
                    alignment: Alignment.center,
                    child: CircularButton(
                      color: Colors.green,
                      width: 60,
                      height: 60,
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onClick: () {
                        if (animationController.isCompleted) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                      },
                    ),
                  )
                ],
              )),
        ],
      ),
    ));
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}

class _DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();

    path.moveTo(size.width, size.height * 2.75 / 4);
    path.quadraticBezierTo(0, size.height * 3 / 4, 0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
