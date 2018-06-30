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

import 'package:contacts/common_widgets/avatar.dart';
import 'package:contacts/common_widgets/no_content_found.dart';
import 'package:contacts/common_widgets/progress_dialog.dart';
import 'package:contacts/futures/common.dart';
import 'package:contacts/models/base/event_object.dart';
import 'package:contacts/models/deleted_contact.dart';
import 'package:contacts/pages/deleted_contact_details.dart';
import 'package:contacts/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class DeletedContactsPage extends StatefulWidget {
  List<DeletedContact> deletedContacts;
  DeletedContactsPageState _deletedContactsPageState;

  DeletedContactsPage({this.deletedContacts});

  @override
  createState() => _deletedContactsPageState =
      new DeletedContactsPageState(deletedContacts: deletedContacts);

  void reloadDeletedContacts() {
    _deletedContactsPageState.reloadDeletedContacts();
  }
}

class DeletedContactsPageState extends State<DeletedContactsPage> {
  static final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(
      ProgressDialogTitles.LOADING_DELETED_CONTACTS, false);

  RectTween _createRectTween(Rect begin, Rect end) {
    return new MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  List<DeletedContact> deletedContacts;

  DeletedContactsPageState({this.deletedContacts});

  Widget deletedContactsWidget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return new Scaffold(
      key: globalKey,
      body: loadList(),
      backgroundColor: Colors.grey[150],
    );
  }

  Widget loadList() {
    if (deletedContacts != null && deletedContacts.isNotEmpty) {
      deletedContactsWidget = _buildDeletedContactsList();
    } else {
      deletedContactsWidget =
          NoContentFound(Texts.NO_DELETED_CONTACTS, Icons.account_circle);
    }
    return new Stack(
      children: <Widget>[deletedContactsWidget, progressDialog],
    );
  }

  Widget _buildDeletedContactsList() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return _buildDeletedContactsRow(deletedContacts[i]);
      },
      itemCount: deletedContacts.length,
    );
  }

  Widget _buildDeletedContactsRow(DeletedContact deletedContact) {
    return new GestureDetector(
      onTap: () {
        _heroAnimation(deletedContact);
      },
      child: new Card(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  deletedContactAvatar(deletedContact),
                  deletedContactDetails(deletedContact)
                ],
              ),
            ],
          ),
          margin: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  Widget deletedContactAvatar(DeletedContact deletedContact) {
    return new Hero(
      tag: deletedContact.id,
      child: new Avatar(
        contactImage: deletedContact.contactImage,
      ),
      createRectTween: _createRectTween,
    );
  }

  Widget deletedContactDetails(DeletedContact deletedContact) {
    return new Flexible(
        child: new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          textContainer(deletedContact.name, Colors.blue[400]),
          textContainer(deletedContact.phone, Colors.blueGrey[400]),
          textContainer(deletedContact.email, Colors.black),
        ],
      ),
      margin: EdgeInsets.only(left: 20.0),
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

  void _heroAnimation(DeletedContact deletedContact) {
    Navigator.of(context).push(
      new PageRouteBuilder<Null>(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return new AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child) {
                return new Opacity(
                  opacity: opacityCurve.transform(animation.value),
                  child: DeletedContactDetails(deletedContact),
                );
              });
        },
      ),
    );
  }

  void reloadDeletedContacts() {
    setState(() {
      progressDialog.show();
      loadDeletedContacts();
    });
  }

  void loadDeletedContacts() async {
    EventObject eventObject = await getDeletedContacts();
    if (this.mounted) {
      setState(() {
        progressDialog.hide();
        switch (eventObject.id) {
          case Events.READ_DELETED_CONTACTS_SUCCESSFUL:
            deletedContacts = eventObject.object;
            showSnackBar(SnackBarText.DELETED_CONTACTS_LOADED_SUCCESSFULLY);
            break;

          case Events.NO_DELETED_CONTACTS_FOUND:
            deletedContacts = eventObject.object;
            showSnackBar(SnackBarText.NO_DELETED_CONTACTS_FOUND);
            break;

          case Events.NO_INTERNET_CONNECTION:
            deletedContactsWidget = NoContentFound(
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
