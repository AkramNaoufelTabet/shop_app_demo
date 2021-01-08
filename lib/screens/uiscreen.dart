//Splash Screen UI Code:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

const TextStyle textStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
);

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  final background = Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/background.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  );
  final greenOpacity = Container(
    color: Color(0xAA72F1CF),
  );

  Widget button(String lable, Function onTap) {
    return new FadeTransition(
      opacity: animation,
      child: new SlideTransition(
        position: Tween<Offset>(begin: Offset(0.0, -0.6), end: Offset.zero)
            .animate(controller),
        child: Material(
          color: Color(0xBB00D699),
          borderRadius: BorderRadius.circular(30.0),
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.white24,
            highlightColor: Colors.white10,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.0),
              child: Center(
                child: Text(
                  lable,
                  style: textStyle.copyWith(fontSize: 18.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    final logo = new ScaleTransition(
      scale: animation,
      child: Image.asset(
        'assets/images/logo.png',
        width: 100.0,
        height: 100.0,
      ),
    );

    final description = new FadeTransition(
      opacity: animation,
      child: new SlideTransition(
        position: Tween<Offset>(begin: Offset(0.0, -0.8), end: Offset.zero)
            .animate(controller),
        child: Text(
          'The interviewee social network.',
          textAlign: TextAlign.center,
          style: textStyle.copyWith(fontSize: 24.0),
        ),
      ),
    );

    final separator = new FadeTransition(
      opacity: animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 20.0,
            height: 2.0,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'OR',
              style: textStyle,
            ),
          ),
          Container(width: 20.0, height: 2.0, color: Colors.white),
        ],
      ),
    );

    final signWith = new FadeTransition(
      opacity: animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sign in with',
            style: textStyle,
          ),
          GestureDetector(
            onTap: () {
              print('google');
            },
            child: Text(
              ' Google',
              style: textStyle.copyWith(
                color: Color(0xFFE65100),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          Text(' or', style: textStyle),
          GestureDetector(
            onTap: () {
              print('Facebook');
            },
            child: Text(
              ' Facebook',
              style: textStyle.copyWith(
                color: Color(0xFF01579B),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );

    final guestContinue = new FadeTransition(
      opacity: animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Wana Skip login?',
              style: textStyle.copyWith(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
          GestureDetector(
            onTap: () {
              print('guest');
            },
            child: Text(
              ' Click here!',
              style: textStyle.copyWith(
                  color: Color(0xBB009388),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        background,
        greenOpacity,
        new SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                logo,
                SizedBox(height: 30.0),
                description,
                SizedBox(height: 60.0),
                button('Create an account', () {
                }),
                SizedBox(height: 8.0),
           
                SizedBox(height: 20.0),
                separator,
                SizedBox(height: 20.0),
                guestContinue,
                SizedBox(height: 20.0),
                separator,
                SizedBox(height: 30.0),
                signWith,
              ],
            ),
          ),
        ),
      ],
    ));
  }
}