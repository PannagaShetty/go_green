import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogreen/components/LoginPage.dart';
import 'package:gogreen/components/variables.dart';
import 'package:gogreen/constants.dart';
import 'package:gogreen/components/custom_button.dart';
import 'package:gogreen/screens/input_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        setState(() {
          userName = loggedInUser.email;
        });

        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          drawer: ClipPath(
            clipper: _DrawerClipper(),
            child: Drawer(
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 30.0, 0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logged in as:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      '$userName',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 18),
                child: GestureDetector(
                  onTap: () {
                    _auth.signOut();
                    Navigator.pushReplacementNamed(context, LoginPage.id);
                  },
                  child: Text(
                    'LogOut',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            title: Hero(
              tag: 'text',
              child: Text(
                "Go Green",
                style: TextStyle(
                  fontSize: 28.0,
                  color: kInputTextColor,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
            backgroundColor: kBackgroundColor,
            elevation: 0,
          ),
          backgroundColor: kBackgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: [
                        Hero(
                          tag: 'logo',
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: kBackgroundColor,
                            backgroundImage: AssetImage('images/Asset.png'),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Application designed by SDM Education Society enables to track, calculate and predict the carbon emissions in our daily routine.It tracks our daily routine usages and essential things like the type of food, travel source, Household amenities.',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Q. What is Carbon Footprint ?',
                        style: TextStyle(
                            fontSize: 20,
                            color: kInputTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        'A carbon footprint is the amount of greenhouse gases—primarily carbon dioxide—released into the atmosphere by a particular human activity. A carbon footprint can be a broad meaasure or be applied to the actions of an individual, a family, an event, an organization, or even an entire nation. It is usually measured as tons of CO2 emitted per year, a number that can be supplemented by tons of CO2-equivalent gases, including methane, nitrous oxide, and other greenhouse gases.',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Q. Effects of Carbon Footprint ?',
                        style: TextStyle(
                            fontSize: 20,
                            color: kInputTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        '•	Large carbon footprints deplete resources on large and small scales, from country’s deforestation activities',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        '•	Increased use of air conditioning',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        '•	Climate change is the ultimate effect of large carbon footprints. Greenhouse gases, whether natural or human-produced, contribute to the warming of the planet.',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        '•	Electricity generation and transportation-related activities account for well over half of the 14 percent increase in greenhouse gas emissions',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Q. How can I reduce my carbon footprint ?',
                        style: TextStyle(
                            fontSize: 20,
                            color: kInputTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        '•	Driving more-efficient vehicles',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        '•	Making sure our current vehicles are properly maintained',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        '•	Taking/using public transportation',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        '•	Using energy-efficient appliances',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        '•	Insulating your home to reduce heating and air conditioning cost',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                      child: Text(
                        '•	Consuming food that doesn’t require as much transportation, and eating less meat, which has a higher carbon footprint than fruits and vegetables',
                        style: TextStyle(fontSize: 20, color: kInputTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                  inputText: 'Calculate your Carbon Footprint',
                  onPress: () {
                    setState(() {
                      Reset.reset();
                    });
                    Navigator.pushNamed(context, InputScreen.id);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();

    path.moveTo(size.width, 0);
    path.quadraticBezierTo(size.width, size.height / 4, 0, size.height / 4);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
