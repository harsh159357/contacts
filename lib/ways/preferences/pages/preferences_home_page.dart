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
import 'package:flutter/scheduler.dart' show timeDilation;

class PreferencesHomePage extends StatefulWidget {
  @override
  createState() => new PreferencesHomePageState();
}

class PreferencesHomePageState extends State<PreferencesHomePage> {
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
          fontSize: 22.0,
        )),
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(Texts.PREFERENCES),
      ),
      body: _preferencesHomePage(),
    );
  }

  Widget _preferencesHomePage() {
    return Center(
        child: new Text(
      Texts.PREFERENCES,
      style: new TextStyle(fontSize: 26.0, color: Colors.blueGrey[400]),
    ));
  }
}
