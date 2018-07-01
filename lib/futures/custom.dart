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

import 'package:contacts/models/base/event_object.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/models/deleted_contact.dart';
import 'package:contacts/models/log.dart';
import 'package:contacts/utils/constants.dart';
import 'package:contacts/utils/functions.dart';

List<Contact> _contacts = new List();
List<DeletedContact> _deletedContacts = new List();
List<Log> _logs = new List();

Future<void> clear() async {
  _contacts.clear();
  _deletedContacts.clear();
  _logs.clear();
}

Future<EventObject> getContactsUsingCustom() async {
  saveLogsUsingCustom(LogCustomTransactions.READING_CONTACTS);
  if (_contacts.isNotEmpty) {
    return new EventObject(
        id: Events.READ_CONTACTS_SUCCESSFUL, object: _contacts);
  } else {
    return new EventObject(id: Events.NO_CONTACTS_FOUND);
  }
}

Future<EventObject> getLogsUsingCustom() async {
  if (_logs.isNotEmpty) {
    return new EventObject(id: Events.READ_LOGS_SUCCESSFUL, object: _logs);
  } else {
    return new EventObject(id: Events.NO_LOGS_FOUND);
  }
}

Future<EventObject> getDeletedContactsUsingCustom() async {
  saveLogsUsingCustom(LogCustomTransactions.READING_DELETED_CONTACTS);
  if (_deletedContacts.isNotEmpty) {
    return new EventObject(
        id: Events.READ_DELETED_CONTACTS_SUCCESSFUL, object: _deletedContacts);
  } else {
    return new EventObject(id: Events.NO_DELETED_CONTACTS_FOUND);
  }
}

Future<EventObject> saveContactUsingCustom(Contact contact) async {
  saveLogsUsingCustom(LogCustomTransactions.CREATING_CONTACT);
  int autoIncrement = _contacts.length + 1;
  contact.id = autoIncrement.toString();
  _contacts.add(contact);

  return new EventObject(id: Events.CONTACT_WAS_CREATED_SUCCESSFULLY);
}

Future<EventObject> removeContactUsingCustom(Contact contact) async {
  saveLogsUsingCustom(LogCustomTransactions.DELETING_CONTACT);
  DeletedContact deletedContact = new DeletedContact(
      id: contact.id,
      name: contact.name,
      phone: contact.phone,
      email: contact.email,
      address: contact.address,
      latitude: contact.latitude,
      longitude: contact.longitude,
      contactImage: contact.contactImage);
  await saveDeletedContactUsingCustom(deletedContact);

  List<Contact> finalContactsList = _contacts;

  for (var deleteMe = 0; deleteMe < _contacts.length; deleteMe++) {
    if (_contacts[deleteMe].id == contact.id) {
      finalContactsList.removeAt(deleteMe);
    }
  }
  _contacts = finalContactsList;
  return new EventObject(id: Events.CONTACT_WAS_DELETED_SUCCESSFULLY);
}

Future<EventObject> updateContactUsingCustom(Contact contact) async {
  saveLogsUsingCustom(LogCustomTransactions.UPDATING_CONTACT);
/*
  List<Contact> finalContactsList = _contacts;
  for (var updateMe = 0; updateMe < _contacts.length; updateMe++) {
    if (_contacts[updateMe].id == contact.id) {
      finalContactsList[updateMe] = contact;
    }
  }
  _contacts = finalContactsList;
*/
  _contacts.add(contact);
  return new EventObject(id: Events.CONTACT_WAS_UPDATED_SUCCESSFULLY);
}

Future<EventObject> searchContactUsingCustom(String searchQuery) async {
  saveLogsUsingCustom(LogCustomTransactions.SEARCHING_CONTACT);
  List<Contact> searchedContacts = new List();
  for (Contact contact in _contacts) {
    if (contact.name.contains(searchQuery) ||
        contact.phone.contains(searchQuery) ||
        contact.email.contains(searchQuery) ||
        contact.address.contains(searchQuery)) {
      searchedContacts.add(contact);
    }
  }
  if (searchedContacts.isNotEmpty) {
    return EventObject(
        id: Events.SEARCH_CONTACTS_SUCCESSFUL, object: searchedContacts);
  } else {
    return EventObject(id: Events.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY);
  }
}

Future<void> saveDeletedContactUsingCustom(
    DeletedContact deletedContact) async {
  _deletedContacts.add(deletedContact);
}

Future<void> saveLogsUsingCustom(String logTransaction) async {
  _logs.add(getLog(logTransaction));
}
