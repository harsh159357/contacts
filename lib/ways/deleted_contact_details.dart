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
import 'package:contacts/models/deleted_contact.dart';
import 'package:contacts/ways/deleted_contact_avatar.dart';
import 'package:contacts/utils/constants.dart';

class DeletedContactDetails extends StatefulWidget {
  final DeletedContact deletedContact;

  DeletedContactDetails(this.deletedContact);

  @override
  createState() => new DeletedContactDetailsPageState(deletedContact);
}

class DeletedContactDetailsPageState extends State<DeletedContactDetails> {
  final globalKey = new GlobalKey<ScaffoldState>();

  RectTween _createRectTween(Rect begin, Rect end) {
    return new MaterialRectCenterArcTween(begin: begin, end: end);
  }

  final DeletedContact deletedContact;

  DeletedContactDetailsPageState(this.deletedContact);

  @override
  Widget build(BuildContext context) {
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
        title: new Text(
          deletedContact.name,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: _deletedContactDetails(),
    );
  }

  Widget _deletedContactDetails() {
    return new Center(
      child: new SizedBox(
        child: new Hero(
          createRectTween: _createRectTween,
          tag: deletedContact.id,
          child: new DeletedContactAvatar(
            deletedContact: deletedContact,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        width: 150.0,
        height: 150.0,
      ),
    );
  }
}
