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
import 'package:contacts/models/contact.dart';
import 'package:contacts/pages/contact_details.dart';
import 'package:contacts/pages/edit_contact_page.dart';
import 'package:contacts/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class ContactPage extends StatefulWidget {
  List<Contact> contactList;
  ContactPageState _contactPageState;

  ContactPage({this.contactList});

  @override
  createState() =>
      _contactPageState = new ContactPageState(contactList: contactList);

  void reloadContactList() {
    _contactPageState.reloadContacts();
  }
}

class ContactPageState extends State<ContactPage> {
  static final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(
      ProgressDialogTitles.LOADING_CONTACTS, false);

  RectTween _createRectTween(Rect begin, Rect end) {
    return new MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  List<Contact> contactList;
  List<Dismissible> dismissible;

  ContactPageState({this.contactList});

  Widget contactListWidget;

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
    if (contactList != null && contactList.isNotEmpty) {
      contactListWidget = _buildContactList();
    } else {
      contactListWidget =
          NoContentFound(Texts.NO_CONTACTS, Icons.account_circle);
    }
    return new Stack(
      children: <Widget>[contactListWidget, progressDialog],
    );
  }

  Widget _buildContactList() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return _buildContactRow(contactList[i]);
      },
      itemCount: contactList.length,
    );
  }

  Widget _buildContactRow(Contact contact) {
    return new Dismissible(
      key: Key(contact.id),
      child: new GestureDetector(
        onTap: () {
          _heroAnimation(contact);
        },
        child: new Card(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new Container(
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    contactAvatar(contact),
                    contactDetails(contact)
                  ],
                ),
              ],
            ),
            margin: EdgeInsets.all(10.0),
          ),
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          if (direction == DismissDirection.endToStart) {
            progressDialog
                .showProgressWithText(ProgressDialogTitles.DELETING_CONTACT);
            deleteContact(contact);
            contactList.remove(contact);
          } else {
            _navigateToEditContactPage(context, contact);
            contactList.remove(contact);
          }
        });
      },
      direction: DismissDirection.horizontal,
      background: dismissContainerEdit(),
      secondaryBackground: dismissContainerDelete(),
    );
  }

  void _navigateToEditContactPage(BuildContext context, Contact contact) async {
    int contactUpdateStatus = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new EditContactPage(contact)),
    );
    setState(() {
      switch (contactUpdateStatus) {
        case Events.CONTACT_WAS_UPDATED_SUCCESSFULLY:
          reloadContacts();
          showSnackBar(SnackBarText.CONTACT_WAS_UPDATED_SUCCESSFULLY);
          break;
        case Events.UNABLE_TO_UPDATE_CONTACT:
          contactList.add(contact);
          showSnackBar(SnackBarText.UNABLE_TO_UPDATE_CONTACT);
          break;
        case Events.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE:
          contactList.add(contact);
          showSnackBar(
              SnackBarText.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE);
          break;
        case Events.USER_HAS_NOT_PERFORMED_UPDATE_ACTION:
          contactList.add(contact);
          showSnackBar(SnackBarText.USER_HAS_NOT_PERFORMED_EDIT_ACTION);
          break;
        default:
          contactList.add(contact);
          break;
      }
    });
  }

  Widget dismissContainerEdit() {
    return new Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Container(
        alignment: Alignment.centerLeft,
        color: Colors.green[400],
        child: new Container(
          padding: EdgeInsets.only(left: 20.0),
          child: new Icon(
            Icons.edit,
            size: 40.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget dismissContainerDelete() {
    return new Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Container(
        alignment: Alignment.centerRight,
        color: Colors.red[400],
        child: new Container(
          padding: EdgeInsets.only(right: 20.0),
          child: new Icon(
            Icons.delete,
            size: 40.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget contactAvatar(Contact contact) {
    return new Hero(
      tag: contact.id,
      child: new Avatar(
        contactImage: contact.contactImage,
      ),
      createRectTween: _createRectTween,
    );
  }

  Widget contactDetails(Contact contact) {
    return new Flexible(
        child: new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          textContainer(contact.name, Colors.blue[400]),
          textContainer(contact.phone, Colors.blueGrey[400]),
          textContainer(contact.email, Colors.black),
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

  void _heroAnimation(Contact contact) {
    Navigator.of(context).push(
      new PageRouteBuilder<Null>(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return new AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child) {
                return new Opacity(
                  opacity: opacityCurve.transform(animation.value),
                  child: ContactDetails(contact),
                );
              });
        },
      ),
    );
  }

  void reloadContacts() {
    setState(() {
      progressDialog
          .showProgressWithText(ProgressDialogTitles.LOADING_CONTACTS);
      loadContacts();
    });
  }

  void loadContacts() async {
    EventObject eventObject = await getContacts();
    if (this.mounted) {
      setState(() {
        progressDialog.hide();
        switch (eventObject.id) {
          case Events.READ_CONTACTS_SUCCESSFUL:
            contactList = eventObject.object;
            showSnackBar(SnackBarText.CONTACTS_LOADED_SUCCESSFULLY);
            break;

          case Events.NO_CONTACTS_FOUND:
            contactList = eventObject.object;
            showSnackBar(SnackBarText.NO_CONTACTS_FOUND);
            break;

          case Events.NO_INTERNET_CONNECTION:
            contactListWidget = NoContentFound(
                SnackBarText.NO_INTERNET_CONNECTION, Icons.signal_wifi_off);
            showSnackBar(SnackBarText.NO_INTERNET_CONNECTION);
            break;
        }
      });
    }
  }

  void deleteContact(Contact contact) async {
    EventObject eventObject = await removeContact(contact);
    if (this.mounted) {
      setState(() {
        progressDialog.hide();
        switch (eventObject.id) {
          case Events.CONTACT_WAS_DELETED_SUCCESSFULLY:
            showSnackBar(SnackBarText.CONTACT_WAS_DELETED_SUCCESSFULLY);
            break;

          case Events.PLEASE_PROVIDE_THE_ID_OF_THE_CONTACT_TO_BE_DELETED:
            contactList.add(contact);
            showSnackBar(SnackBarText
                .PLEASE_PROVIDE_THE_ID_OF_THE_CONTACT_TO_BE_DELETED);
            break;

          case Events.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE:
            contactList.add(contact);
            showSnackBar(
                SnackBarText.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE);
            break;

          case Events.NO_INTERNET_CONNECTION:
            contactList.add(contact);
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
