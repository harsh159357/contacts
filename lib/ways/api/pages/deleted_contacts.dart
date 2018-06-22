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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:contacts/models/deleted_contact.dart';
import 'package:contacts/utils/constants.dart';

class DeletedContactsPage extends StatefulWidget {
  final List<DeletedContact> deletedContacts;

  DeletedContactsPage({this.deletedContacts});

  @override
  createState() =>
      new DeletedContactsPageState(deletedContacts: deletedContacts);
}

class DeletedContactsPageState extends State<DeletedContactsPage> {
  List<DeletedContact> deletedContacts;

  DeletedContactsPageState({this.deletedContacts});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: loadList(deletedContacts),
      backgroundColor: Colors.grey[150],
    );
  }

  Widget loadList(List<DeletedContact> list) {
    if (list != null) {
      return _buildContactList(list);
    } else {
      return new Container(
        height: double.infinity,
        width: double.infinity,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.account_circle,
              color: Colors.blue[400],
              size: 150.0,
            ),
            new Container(
              child: new Text(
                Texts.NO_CONTACTS,
                style:
                    new TextStyle(fontSize: 26.0, color: Colors.blueGrey[400]),
              ),
              margin: EdgeInsets.only(top: 5.0),
            )
          ],
        ),
      );
    }
  }

  Widget _buildContactList(List<DeletedContact> deletedContacts) {
    return new ListView.builder(
//      padding: const EdgeInsets.only(
//          top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return _buildContactRow(deletedContacts[i]);
      },
      itemCount: deletedContacts.length,
    );
  }

  Widget _buildContactRow(DeletedContact deletedContact) {
    return new Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                contactImage(deletedContact),
                contactDetails(deletedContact)
              ],
            ),
          ],
        ),
        margin: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget contactImage(DeletedContact deletedContact) {
    return new Image.memory(
      base64.decode(deletedContact.contactImage),
      height: 100.0,
      width: 100.0,
      fit: BoxFit.fill,
    );
  }

  Widget contactDetails(DeletedContact deletedContact) {
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
}
