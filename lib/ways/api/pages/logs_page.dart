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
import 'package:contacts/models/log.dart';
import 'package:contacts/utils/constants.dart';
import 'package:contacts/customviews/no_content_found.dart';

class LogsPage extends StatefulWidget {
  final List<Log> logs;

  LogsPage({this.logs});

  @override
  createState() => new LogsPageState(logs: logs);
}

class LogsPageState extends State<LogsPage> {
  List<Log> logs;

  LogsPageState({this.logs});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: loadList(logs),
      backgroundColor: Colors.grey[150],
    );
  }

  Widget loadList(List<Log> list) {
    if (list != null) {
      return _buildLogsList(list);
    } else {
      return NoContentFound(Texts.NO_LOGS, Icons.list);
    }
  }

  Widget _buildLogsList(List<Log> logs) {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return _buildLogRow(logs[i]);
      },
      itemCount: logs.length,
    );
  }

  Widget _buildLogRow(Log log) {
    return new Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[logDetails(log)],
            ),
          ],
        ),
        margin: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget logDetails(Log log) {
    return new Flexible(
        child: new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          textContainer(log.column_timestamp, Colors.blue[400]),
          textContainer(log.column_date, Colors.blueGrey[400]),
          textContainer(log.column_transaction, Colors.black),
        ],
      ),
    ));
  }

  Widget textContainer(String string, Color color) {
    return new Container(
      child: new Text(
        string,
        style: TextStyle(
            color: color, fontWeight: FontWeight.normal, fontSize: 16.0),
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }
}
