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
import 'package:contacts/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class SearchContactsPage extends StatefulWidget {
  SearchContactsPageState _searchContactPageState;

  SearchContactsPage();

  @override
  createState() => _searchContactPageState = new SearchContactsPageState();

  void resetSearchContactsPage() {
    _searchContactPageState.resetSearchContacts();
  }
}

class SearchContactsPageState extends State<SearchContactsPage> {
  static final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(
      ProgressDialogTitles.SEARCHING_CONTACTS, false);

  RectTween _createRectTween(Rect begin, Rect end) {
    return new MaterialRectCenterArcTween(begin: begin, end: end);
  }

  TextEditingController searchController = new TextEditingController(text: "");

  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  List<Contact> contactList = new List();

  SearchContactsPageState();

  Widget contactListWidget;
  Widget searchBar;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        textTheme: new TextTheme(
            title: new TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        )),
        iconTheme: new IconThemeData(color: Colors.white),
        title: new TextFormField(
          controller: searchController,
          style: new TextStyle(color: Colors.white, fontSize: 20.0),
          onFieldSubmitted: (text) {
            searchThis(text);
          },
        ),
        actions: <Widget>[
          new GestureDetector(
            child: new Container(
              child: new Icon(
                Icons.search,
                color: Colors.white,
              ),
              margin: EdgeInsets.only(right: 10.0),
            ),
            onTap: () {
              searchThis(searchController.text);
            },
          )
        ],
      ),
      key: globalKey,
      body: loadSearchPage(),
      backgroundColor: Colors.grey[150],
    );
  }

  void searchThis(String search) {
    if (searchController.text != "") {
      FocusScope.of(context).requestFocus(new FocusNode());
      progressDialog.show();
      searchContacts(searchController.text);
    } else {
      showSnackBar(SnackBarText.PLEASE_FILL_SOMETHING_IN_SEARCH_FIElD);
    }
  }

  Widget loadSearchPage() {
    if (contactList != null) {
      if (contactList.isNotEmpty) {
        contactListWidget = new Container(
            margin: const EdgeInsets.all(16.0), child: _buildContactList());
      } else {
        contactListWidget = new Container(
            margin: const EdgeInsets.all(16.0),
            child: NoContentFound(Texts.NO_CONTACTS, Icons.account_circle));
      }
    }
    return new Stack(
      children: <Widget>[contactListWidget, progressDialog],
    );
  }

  Widget _buildContactList() {
    return new ListView.builder(
      itemBuilder: (context, i) {
        return _buildContactRow(contactList[i]);
      },
      itemCount: contactList.length,
    );
  }

  Widget _buildContactRow(Contact contact) {
    return new GestureDetector(
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

  void resetSearchContacts() {
    setState(() {
      searchController.text = "";
      contactList = new List();
    });
  }

  void searchContacts(String searchQuery) async {
    EventObject eventObject = await searchContactsAvailable(searchQuery);
    if (this.mounted) {
      setState(() {
        progressDialog.hide();
        switch (eventObject.id) {
          case Events.SEARCH_CONTACTS_SUCCESSFUL:
            contactList = eventObject.object;
            showSnackBar(SnackBarText.CONTACTS_SEARCHED_SUCCESSFULLY);
            break;
          case Events.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY:
            contactList = new List();
            showSnackBar(SnackBarText.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY +
                searchQuery);
            break;

          case Events.NO_INTERNET_CONNECTION:
            contactList = new List();
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
