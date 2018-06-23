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
import 'package:contacts/customviews/no_content_found.dart';

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
      return _buildDeletedContactsList(list);
    } else {
      return NoContentFound(Texts.NO_DELETED_CONTACTS,Icons.account_circle);
    }
  }

  Widget _buildDeletedContactsList(List<DeletedContact> deletedContacts) {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return _buildDeletedContactsRow(deletedContacts[i]);
      },
      itemCount: deletedContacts.length,
    );
  }

  Widget _buildDeletedContactsRow(DeletedContact deletedContact) {
    return new Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                deletedContactImage(deletedContact),
                deletedContactDetails(deletedContact)
              ],
            ),
          ],
        ),
        margin: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget deletedContactImage(DeletedContact deletedContact) {
    return new Image.memory(
      base64.decode(deletedContact.contactImage),
      height: 100.0,
      width: 100.0,
      fit: BoxFit.fill,
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
}
