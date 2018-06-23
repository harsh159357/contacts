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

import 'package:flutter/material.dart';
import 'package:contacts/utils/constants.dart';
import 'package:contacts/ways/api/pages/api_home_page.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:contacts/ways/custom/pages/custom_home_page.dart';
import 'package:contacts/ways/preferences/pages/preferences_home_page.dart';
import 'package:contacts/ways/sqflite/pages/sqflite_home_page.dart';

class WaysPage extends StatefulWidget {
  @override
  createState() => new WaysPageState();
}

class WaysPageState extends State<WaysPage> {
  final globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return new Scaffold(
      key: globalKey,
      appBar: new AppBar(
        centerTitle: true,
        textTheme: new TextTheme(
            title: new TextStyle(
          color: Colors.white,
          fontSize: 26.0,
        )),
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(Texts.WAYS),
      ),
      body: _waysPage(),
    );
  }

  Widget _waysPage() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new Row(
                children: <Widget>[
                  _flexContainer(Icons.description, Texts.API),
                  _flexContainer(Icons.center_focus_weak, Texts.CUSTOM),
                ],
              ),
              margin: EdgeInsets.only(bottom: 40.0),
            ),
            new Container(
                child: new Row(
              children: <Widget>[
                _flexContainer(Icons.tune, Texts.PREFERENCES),
                _flexContainer(Icons.save, Texts.SQFLITE),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _flexContainer(IconData icon, String title) {
    return new Flexible(
        fit: FlexFit.tight,
        flex: 2,
        child: new GestureDetector(
          child: new Column(
            children: <Widget>[
              new Icon(
                icon,
                size: 125.0,
                color: Colors.blue[400],
              ),
              new Container(
                child: new Text(
                  title,
                  style: new TextStyle(
                      color: Colors.blueGrey[400],
                      fontWeight: FontWeight.normal,
                      fontSize: 26.0),
                ),
                margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
              ),
            ],
          ),
          onTap: () {
            navigateTo(title);
          },
        ));
  }

  void navigateTo(String title) {
    switch (title) {
      case Texts.API:
        navigateToPage(new APIHomePage());
        break;
      case Texts.CUSTOM:
        navigateToPage(new CustomHomePage());
        break;
      case Texts.PREFERENCES:
        navigateToPage(new PreferencesHomePage());
        break;
      case Texts.SQFLITE:
        navigateToPage(new SqfliteHomePage());
        break;
    }
  }

  void navigateToPage(StatefulWidget statefulWidget) {
    if (this.mounted) {
      setState(() {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => statefulWidget),
        );
      });
    }
  }
}
