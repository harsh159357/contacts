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

class APIHomePage extends StatefulWidget {
  @override
  createState() => new APIHomePageState();
}

class APIHomePageState extends State<APIHomePage> {
  final globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
        title: new Text(Texts.API),
      ),
      body: _apiHomePage(),
    );
  }

  Widget _apiHomePage() {
    return Center(
        child: new Text(
      Texts.API,
      style: new TextStyle(fontSize: 26.0, color: Colors.blueGrey[400]),
    ));
  }
}
