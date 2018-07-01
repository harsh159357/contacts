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

import 'dart:async';

import 'package:contacts/futures/api.dart';
import 'package:contacts/futures/custom.dart';
import 'package:contacts/futures/database.dart';
import 'package:contacts/futures/preferences.dart';
import 'package:contacts/models/base/event_object.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/pages/ways_page.dart';
import 'package:contacts/utils/constants.dart';

Future<EventObject> getContacts() async {
  EventObject eventObject;
  switch (selectedWay) {
    case Ways.API:
      eventObject = await getContactsUsingRestAPI();
      break;
    case Ways.CUSTOM:
      eventObject = await getContactsUsingCustom();
      break;
    case Ways.PREFERENCES:
      eventObject = await getContactsUsingPrefs();
      break;
    case Ways.SQFLITE:
      eventObject = await getContactsUsingDB();
      break;
  }
  return eventObject;
}

Future<EventObject> getLogs() async {
  EventObject eventObject;
  switch (selectedWay) {
    case Ways.API:
      eventObject = await getLogsUsingRestAPI();
      break;
    case Ways.CUSTOM:
      eventObject = await getLogsUsingCustom();
      break;
    case Ways.PREFERENCES:
      eventObject = await getLogsUsingPrefs();
      break;
    case Ways.SQFLITE:
      eventObject = await getLogsUsingDB();
      break;
  }
  return eventObject;
}

Future<EventObject> getDeletedContacts() async {
  EventObject eventObject;
  switch (selectedWay) {
    case Ways.API:
      eventObject = await getDeletedContactsUsingRestAPI();
      break;
    case Ways.CUSTOM:
      eventObject = await getDeletedContactsUsingCustom();
      break;
    case Ways.PREFERENCES:
      eventObject = await getDeletedContactsUsingPrefs();
      break;
    case Ways.SQFLITE:
      eventObject = await getDeletedContactsUsingDB();
      break;
  }
  return eventObject;
}

Future<EventObject> saveContact(Contact contact) async {
  EventObject eventObject;
  switch (selectedWay) {
    case Ways.API:
      eventObject = await saveContactUsingRestAPI(contact);
      break;
    case Ways.CUSTOM:
      eventObject = await saveContactUsingCustom(contact);
      break;
    case Ways.PREFERENCES:
      eventObject = await saveContactUsingPrefs(contact);
      break;
    case Ways.SQFLITE:
      eventObject = await saveContactUsingDB(contact);
      break;
  }
  return eventObject;
}

Future<EventObject> removeContact(Contact contact) async {
  EventObject eventObject;
  switch (selectedWay) {
    case Ways.API:
      eventObject = await removeContactUsingRestAPI(contact);
      break;
    case Ways.CUSTOM:
      eventObject = await removeContactUsingCustom(contact);
      break;
    case Ways.PREFERENCES:
      eventObject = await removeContactUsingPrefs(contact);
      break;
    case Ways.SQFLITE:
      eventObject = await removeContactUsingDB(contact);
      break;
  }
  return eventObject;
}

Future<EventObject> updateContact(Contact contact) async {
  EventObject eventObject;
  switch (selectedWay) {
    case Ways.API:
      eventObject = await updateContactUsingRestAPI(contact);
      break;
    case Ways.CUSTOM:
      eventObject = await updateContactUsingCustom(contact);
      break;
    case Ways.PREFERENCES:
      eventObject = await updateContactUsingPrefs(contact);
      break;
    case Ways.SQFLITE:
      eventObject = await updateContactUsingDB(contact);
      break;
  }
  return eventObject;
}

Future<EventObject> searchContactsAvailable(String searchQuery) async {
  EventObject eventObject;
  switch (selectedWay) {
    case Ways.API:
      eventObject = await searchContactsUsingRestAPI(searchQuery);
      break;
    case Ways.CUSTOM:
      eventObject = await searchContactUsingCustom(searchQuery);
      break;
    case Ways.PREFERENCES:
      eventObject = await searchContactUsingPrefs(searchQuery);
      break;
    case Ways.SQFLITE:
      eventObject = await searchContactsUsingDB(searchQuery);
      break;
  }
  return eventObject;
}
