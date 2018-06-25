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

import 'package:contacts/customviews/no_content_found.dart';
import 'package:contacts/customviews/progress_dialog.dart';
import 'package:contacts/models/base/event_object.dart';
import 'package:contacts/utils/constants.dart';
import 'package:contacts/ways/api/futures/api_futures.dart';
import 'package:contacts/ways/api/pages/contacts_page.dart';
import 'package:contacts/ways/api/pages/create_contact_page.dart';
import 'package:contacts/ways/api/pages/deleted_contacts_page.dart';
import 'package:contacts/ways/api/pages/logs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class APIHomePage extends StatefulWidget {
  @override
  createState() => new APIHomePageState();
}

class APIHomePageState extends State<APIHomePage> {
  static final globalKey = new GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(
      ProgressDialogTitles.LOADING_CONTACTS, true);
  Widget apiHomeWidget = new Container();
  static const String TAPPED_ON_HEADER = "Tapped On Header";
  String title = DrawerTitles.CONTACTS;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await initContacts();
  }

  Future<void> initContacts() async {
    EventObject eventObjectInitContacts = await getContacts();
    eventsCapturing(eventObjectInitContacts);
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
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
      onPressed: () {
        navigateToPage(new CreateContactPage());
      },
      child: new Icon(
        Icons.add,
      ),
    );
  }

//------------------------------------------------------------------------------

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
      new SimpleItem(
          leadingIconData: Icons.search, title: DrawerTitles.SEARCH_CONTACTS),
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
        Type type = apiHomeWidget.runtimeType;
        if (title == whatToDo) {
          if (type == ContactPage) {
            ContactPage contactPage = apiHomeWidget as ContactPage;
            contactPage.reloadContactList();
          } else if (type == DeletedContactsPage) {
            DeletedContactsPage deletedContactsPage =
                apiHomeWidget as DeletedContactsPage;
            deletedContactsPage.reloadDeletedContacts();
          } else if (type == LogsPage) {
            LogsPage logsPage = apiHomeWidget as LogsPage;
            logsPage.reloadLogs();
          }
        } else {
          title = whatToDo;
          switch (title) {
            case DrawerTitles.CONTACTS:
              progressDialog
                  .showProgressWithText(ProgressDialogTitles.LOADING_CONTACTS);
              loadContacts();
              break;
            case DrawerTitles.DELETED_CONTACTS:
              progressDialog.showProgressWithText(
                  ProgressDialogTitles.LOADING_DELETED_CONTACTS);
              loadDeletedContacts();
              break;
            case DrawerTitles.LOGS:
              progressDialog
                  .showProgressWithText(ProgressDialogTitles.LOADING_LOGS);
              loadLogs();
              break;
          }
        }
      } else {
        showSnackBar(SnackBarText.TAPPED_ON_API_HEADER);
      }
    });
  }

//------------------------------------------------------------------------------
  void loadContacts() async {
    EventObject eventObjectContacts = await getContacts();
    eventsCapturing(eventObjectContacts);
  }

  void loadDeletedContacts() async {
    EventObject eventObjectDeleteContacts = await getDeletedContacts();
    eventsCapturing(eventObjectDeleteContacts);
  }

  void loadLogs() async {
    EventObject eventObjectLogs = await getLogs();
    eventsCapturing(eventObjectLogs);
  }

//------------------------------------------------------------------------------

  void eventsCapturing(EventObject eventObject) {
    if (this.mounted) {
      setState(() {
        progressDialog.hideProgress();
        switch (eventObject.id) {
//------------------------------------------------------------------------------
          case EventConstants.READ_CONTACTS_SUCCESSFUL:
            apiHomeWidget = new ContactPage(contactList: eventObject.object);
            showSnackBar(SnackBarText.CONTACTS_LOADED_SUCCESSFULLY);
            break;
          case EventConstants.READ_CONTACTS_UN_SUCCESSFUL:
            apiHomeWidget = new ContactPage();
            showSnackBar(SnackBarText.UNABLE_TO_LOAD_CONTACTS);
            break;
          case EventConstants.NO_CONTACTS_FOUND:
            apiHomeWidget = new ContactPage();
            showSnackBar(SnackBarText.NO_CONTACTS_FOUND);
            break;
//------------------------------------------------------------------------------
          case EventConstants.READ_DELETED_CONTACTS_SUCCESSFUL:
            apiHomeWidget =
                new DeletedContactsPage(deletedContacts: eventObject.object);
            showSnackBar(SnackBarText.DELETED_CONTACTS_LOADED_SUCCESSFULLY);
            break;
          case EventConstants.READ_CONTACTS_UN_SUCCESSFUL:
            apiHomeWidget = new DeletedContactsPage();
            showSnackBar(SnackBarText.UNABLE_TO_LOAD_DELETED_CONTACTS);
            break;
          case EventConstants.NO_DELETED_CONTACTS_FOUND:
            apiHomeWidget = new DeletedContactsPage();
            showSnackBar(SnackBarText.NO_DELETED_CONTACTS_FOUND);
            break;
//------------------------------------------------------------------------------
          case EventConstants.READ_LOGS_SUCCESSFUL:
            apiHomeWidget = new LogsPage(logs: eventObject.object);
            showSnackBar(SnackBarText.LOGS_LOADED_SUCCESSFULLY);
            break;
          case EventConstants.READ_LOGS_SUCCESSFUL:
            apiHomeWidget = new LogsPage();
            showSnackBar(SnackBarText.UNABLE_TO_LOAD_LOGS);
            break;
          case EventConstants.NO_LOGS_FOUND:
            apiHomeWidget = new LogsPage();
            showSnackBar(SnackBarText.NO_LOGS_FOUND);
            break;
//------------------------------------------------------------------------------
          case EventConstants.NO_INTERNET_CONNECTION:
            apiHomeWidget = new NoContentFound(
                SnackBarText.NO_INTERNET_CONNECTION, Icons.signal_wifi_off);
            showSnackBar(SnackBarText.NO_INTERNET_CONNECTION);
        }
      });
    }
  }

  void showSnackBar(String textToBeShown) {
    globalKey.currentState.showSnackBar(new SnackBar(
      content: new Text(textToBeShown),
    ));
  }

  void navigateToPage(StatefulWidget statefulWidget) {
    if (this.mounted) {
      setState(() {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => statefulWidget),
        );
      });
    }
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
