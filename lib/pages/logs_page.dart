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

import 'package:contacts/common_widgets/no_content_found.dart';
import 'package:contacts/common_widgets/progress_dialog.dart';
import 'package:contacts/futures/common.dart';
import 'package:contacts/models/base/event_object.dart';
import 'package:contacts/models/log.dart';
import 'package:contacts/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LogsPage extends StatefulWidget {
  List<Log> logs;
  LogsPageState _logsPageState;

  LogsPage({this.logs});

  @override
  createState() => _logsPageState = new LogsPageState(logs: logs);

  void reloadLogs() {
    _logsPageState.reloadLogs();
  }
}

class LogsPageState extends State<LogsPage> {
  static final globalKey = new GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(
      ProgressDialogTitles.LOADING_LOGS, false);

  List<Log> logs;

  LogsPageState({this.logs});

  Widget logsPageWidget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return new Scaffold(
      key: globalKey,
      body: loadList(),
      backgroundColor: Colors.grey[150],
    );
  }

  Widget loadList() {
    if (logs != null && logs.isNotEmpty) {
      logsPageWidget = _buildLogsList();
    } else {
      logsPageWidget = NoContentFound(Texts.NO_LOGS, Icons.list);
    }
    return new Stack(
      children: <Widget>[logsPageWidget, progressDialog],
    );
  }

  Widget _buildLogsList() {
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

  void reloadLogs() {
    setState(() {
      progressDialog.show();
      loadLogs();
    });
  }

  void loadLogs() async {
    EventObject eventObject = await getLogs();
    if (this.mounted) {
      setState(() {
        progressDialog.hide();
        switch (eventObject.id) {
          case Events.READ_LOGS_SUCCESSFUL:
            logs = eventObject.object;
            showSnackBar(SnackBarText.LOGS_LOADED_SUCCESSFULLY);
            break;
          case Events.NO_LOGS_FOUND:
            logs = eventObject.object;
            showSnackBar(SnackBarText.NO_LOGS_FOUND);
            break;

          case Events.NO_INTERNET_CONNECTION:
            logsPageWidget = NoContentFound(
                SnackBarText.NO_INTERNET_CONNECTION, Icons.signal_wifi_off);
            showSnackBar(SnackBarText.NO_INTERNET_CONNECTION);
            break;
        }
      });
    }
  }

  void showSnackBar(String textToBeShown) {
    globalKey.currentState.showSnackBar(new SnackBar(
      content: new Text(textToBeShown),
    ));
  }
}
