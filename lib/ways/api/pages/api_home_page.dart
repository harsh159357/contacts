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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:contacts/utils/constants.dart';
import 'package:contacts/customviews/progress_dialog.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/ways/api/futures/api_futures.dart';
import 'package:contacts/models/base/event_object.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/ways/api/pages/contacts_page.dart';

class APIHomePage extends StatefulWidget {
  @override
  createState() => new APIHomePageState();
}

class APIHomePageState extends State<APIHomePage> {
  static final globalKey = new GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog(ProgressDialogTitles.LOADING_CONTACTS);
  Widget apiHomeWidget = new Container();
  static const String TAPPED_ON_HEADER = "Tapped On Header";
  String title = DrawerTitles.CONTACTS;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await initContacts();
  }

  Future<void> initContacts() async {
    EventObject eventObject = await getContacts();
    setState(() {
      progressDialog.hideProgress();
      switch (eventObject.id) {
        case EventConstants.READ_CONTACT_SUCCESSFUL:
          apiHomeWidget = new ContactPage(contactList: eventObject.object);
          break;
        case EventConstants.READ_CONTACT_UN_SUCCESSFUL:
          apiHomeWidget = new ContactPage();
          break;
        case EventConstants.NO_CONTACT_FOUND:
          apiHomeWidget = new ContactPage();
          break;
        case EventConstants.NO_INTERNET_CONNECTION:
          showSnackBar(SnackBarText.NO_INTERNET_CONNECTION);
          break;
      }
    });
  }

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
        title: new Text(title),
      ),
      body: _apiHomePage(),
      drawer: _navigationDrawer(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _apiHomePage() {
    return new Stack(
      children: <Widget>[apiHomeWidget, progressDialog],
    );
  }

  FloatingActionButton _floatingActionButton() {
    return new FloatingActionButton(
      onPressed: null,
      child: new Icon(
        Icons.add,
      ),
    );
  }

  List<NavigationItem> navigationData;

  Widget _navigationDrawer() {
    return new Drawer(child: _navigationData());
  }

  Widget _navigationData() {
    navigationData = <NavigationItem>[
      new HeaderItem(_drawerHeader()),
      new SimpleItem(
          leadingIconData: Icons.account_circle, title: DrawerTitles.CONTACTS),
      new SimpleItem(
          leadingIconData: Icons.delete, title: DrawerTitles.DELETED_CONTACTS),
      new SimpleItem(leadingIconData: Icons.list, title: DrawerTitles.LOGS),
    ];
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final item = navigationData[index];
          if (item is HeaderItem) {
            return item.gestureDetector;
          } else if (item is SimpleItem) {
            return _simpleItem(item);
          }
        },
        itemCount: navigationData.length);
  }

  Widget _drawerHeader() {
    return new GestureDetector(
      onTap: () {
        handleNavigationDrawerClicks(TAPPED_ON_HEADER);
      },
      child: new DrawerHeader(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Icon(
                  Icons.description,
                  size: 75.0,
                  color: Colors.white,
                ),
                new Container(
                  child: new Text(
                    Texts.API,
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 26.0),
                  ),
                  margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                ),
              ],
            )
          ],
        ),
        /*new Text('Drawer Header')*/
        decoration: new BoxDecoration(color: Colors.blue[400]),
      ),
    );
  }

  Widget _simpleItem(SimpleItem simpleItem) {
    return new ListTile(
        onTap: () {
          handleNavigationDrawerClicks(simpleItem.title);
        },
        leading: new Icon(
          simpleItem.leadingIconData,
          size: 25.0,
          color: Colors.blueGrey[400],
        ),
        title: new Text(
          simpleItem.title,
          style: new TextStyle(
              color: Colors.blueGrey[400],
              fontWeight: FontWeight.normal,
              fontSize: 18.0),
        ));
  }

  void handleNavigationDrawerClicks(String whatToDo) {
    setState(() {
      Navigator.pop(context);
      if (whatToDo != TAPPED_ON_HEADER) {
        title = whatToDo;
        switch (title) {
          case DrawerTitles.CONTACTS:
            progressDialog
                .showProgressWithText(ProgressDialogTitles.LOADING_CONTACTS);
            loadContacts();
            break;
          case DrawerTitles.DELETED_CONTACTS:
            break;
          case DrawerTitles.LOGS:
            break;
        }
      } else {
        showSnackBar(SnackBarText.TAPPED_ON_API_HEADER);
      }
    });
  }

  void loadContacts() async {
    EventObject eventObject = await getContacts();
    if (this.mounted) {
      setState(() {
        progressDialog.hideProgress();
        switch (eventObject.id) {
          case EventConstants.READ_CONTACT_SUCCESSFUL:
            apiHomeWidget = new ContactPage(contactList: eventObject.object);
            break;
          case EventConstants.READ_CONTACT_UN_SUCCESSFUL:
            apiHomeWidget = new ContactPage();
            break;
          case EventConstants.NO_CONTACT_FOUND:
            apiHomeWidget = new ContactPage();
            break;
          case EventConstants.NO_INTERNET_CONNECTION:
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

abstract class NavigationItem {}

class HeaderItem implements NavigationItem {
  GestureDetector gestureDetector;

  HeaderItem(this.gestureDetector);
}

class SimpleItem implements NavigationItem {
  SimpleItem({this.title, this.leadingIconData, this.trailingIconData});

  final String title;
  final IconData leadingIconData, trailingIconData;
}
