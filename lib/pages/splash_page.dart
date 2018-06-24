/*
 * Copyright 2018 Harsh Sharma
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

import 'dart:async';

import 'package:contacts/pages/ways_page.dart';
import 'package:contacts/utils/constants.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  Animation<double> logoAnimation, appNameAnimation;
  AnimationController logoAnimationController, appNameAnimationController;

  static final tweenLogo = new Tween(begin: 0.0, end: 200.0);
  static final tweenAppName = new Tween(begin: 0.0, end: 50.0);

  @override
  initState() {
    super.initState();
    logoAnimationController = new AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    appNameAnimationController = logoAnimationController;
    logoAnimation = tweenLogo.animate(logoAnimationController)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    appNameAnimation = tweenAppName.animate(logoAnimationController)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    logoAnimationController.forward();
    appNameAnimationController.forward();
  }

  final globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 3), _handleTapEvent);
    return new Scaffold(
      key: globalKey,
      body: _splashContainer(),
    );
  }

  Widget _splashContainer() {
    return GestureDetector(
        onTap: _handleTapEvent,
        child: Container(
            height: double.infinity,
            width: double.infinity,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Container(
                    child: new Icon(
                  Icons.contacts,
                  size: logoAnimation.value,
                  color: Colors.blue[400],
                )),
                new Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: new Text(
                    Texts.APP_NAME,
                    style: new TextStyle(
                        color: Colors.blueGrey[400],
                        fontSize: appNameAnimation.value),
                  ),
                ),
              ],
            )));
  }

  void _handleTapEvent() async {
    if (this.mounted) {
      setState(() {
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new WaysPage()),
        );
      });
    }
  }

  @override
  dispose() {
    logoAnimationController.dispose();
    super.dispose();
  }
}
