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
 */

import 'package:flutter/material.dart';

class NoContentFound extends StatelessWidget {
  final String noContentText;
  final IconData noContentIconData;

  NoContentFound(this.noContentText, this.noContentIconData);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Icon(
            noContentIconData,
            color: Colors.blue[400],
            size: 150.0,
          ),
          new Container(
            child: new Text(
              noContentText,
              style: new TextStyle(fontSize: 26.0, color: Colors.blueGrey[400]),
            ),
            margin: EdgeInsets.only(top: 5.0),
          )
        ],
      ),
    );
  }
}
