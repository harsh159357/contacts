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
import 'dart:convert';

import 'package:contacts/models/base/event_object.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/models/deleted_contact.dart';
import 'package:contacts/models/log.dart';
import 'package:contacts/utils/constants.dart';
import 'package:contacts/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

Future<bool> clear() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.clear();
}

Future<int> getAutoIncrement(SharedPreferences prefs) async {
  if (prefs.getInt(SharedPreferenceKeys.AUTO_INCREMENT) == null) {
    return 1;
  } else {
    return prefs.getInt(SharedPreferenceKeys.AUTO_INCREMENT);
  }
}

Future<void> saveAutoIncrement(
    int autoIncrement, SharedPreferences prefs) async {
  ++autoIncrement;
  bool saveSuccessful =
      await prefs.setInt(SharedPreferenceKeys.AUTO_INCREMENT, autoIncrement);

  if (saveSuccessful) {
// Auto Increment saved Successfully
  } else {
// Unable to Save AutoIncrement
  }
}

Future<EventObject> getContactsUsingPrefs() async {
  var prefs = await _getPrefs();
  saveLogsUsingPrefs(LogPreferenceTransactions.READING_CONTACTS, prefs);
  if (prefs.getString(SharedPreferenceKeys.CONTACTS) == null) {
    return new EventObject(id: Events.NO_CONTACTS_FOUND);
  } else {
    List<Contact> contacts = await Contact.fromContactJson(
        json.decode(prefs.getString(SharedPreferenceKeys.CONTACTS)));
    if (contacts.isNotEmpty) {
      return new EventObject(
          id: Events.READ_CONTACTS_SUCCESSFUL, object: contacts);
    } else {
      return new EventObject(id: Events.NO_CONTACTS_FOUND);
    }
  }
}

Future<EventObject> getLogsUsingPrefs() async {
  var prefs = await _getPrefs();
  if (prefs.getString(SharedPreferenceKeys.LOGS) == null) {
    return new EventObject(id: Events.NO_LOGS_FOUND);
  } else {
    List<Log> logs = await Log
        .fromLogsJson(json.decode(prefs.getString(SharedPreferenceKeys.LOGS)));
    if (logs.isNotEmpty) {
      return new EventObject(id: Events.READ_LOGS_SUCCESSFUL, object: logs);
    } else {
      return new EventObject(id: Events.NO_LOGS_FOUND);
    }
  }
}

Future<EventObject> getDeletedContactsUsingPrefs() async {
  var prefs = await _getPrefs();
  saveLogsUsingPrefs(LogPreferenceTransactions.READING_DELETED_CONTACTS, prefs);
  if (prefs.getString(SharedPreferenceKeys.DELETED_CONTACTS) == null) {
    return new EventObject(id: Events.NO_DELETED_CONTACTS_FOUND);
  } else {
    List<DeletedContact> deletedContacts =
        await DeletedContact.fromDeletedContactJson(json
            .decode(prefs.getString(SharedPreferenceKeys.DELETED_CONTACTS)));
    if (deletedContacts.isNotEmpty) {
      return new EventObject(
          id: Events.READ_DELETED_CONTACTS_SUCCESSFUL, object: deletedContacts);
    } else {
      return new EventObject(id: Events.NO_DELETED_CONTACTS_FOUND);
    }
  }
}

Future<EventObject> saveContactUsingPrefs(Contact contact) async {
  var prefs = await _getPrefs();
  saveLogsUsingPrefs(LogPreferenceTransactions.CREATING_CONTACT, prefs);
  EventObject eventObject = await getContactsUsingPrefs();
  List<Contact> contacts;
  if (eventObject.id == Events.READ_CONTACTS_SUCCESSFUL) {
    contacts = eventObject.object;
  } else {
    contacts = new List();
  }
  int autoIncrement = await getAutoIncrement(prefs);
  contact.id = autoIncrement.toString();
  contacts.add(contact);

  bool saveSuccessful = await prefs.setString(
      SharedPreferenceKeys.CONTACTS, json.encode(contacts));
  if (saveSuccessful != null) {
    saveAutoIncrement(autoIncrement, prefs);
    return new EventObject(id: Events.CONTACT_WAS_CREATED_SUCCESSFULLY);
  } else {
    return new EventObject(id: Events.UNABLE_TO_CREATE_CONTACT);
  }
}

Future<EventObject> removeContactUsingPrefs(Contact contact) async {
  var prefs = await _getPrefs();
  saveLogsUsingPrefs(LogPreferenceTransactions.DELETING_CONTACT, prefs);
  EventObject eventObject = await getContactsUsingPrefs();
  if (eventObject.id == Events.READ_CONTACTS_SUCCESSFUL) {
    List<Contact> contacts = eventObject.object;
    DeletedContact deletedContact = new DeletedContact(
        id: contact.id,
        name: contact.name,
        phone: contact.phone,
        email: contact.email,
        address: contact.address,
        latitude: contact.latitude,
        longitude: contact.longitude,
        contactImage: contact.contactImage);
    await saveDeletedContactUsingPrefs(deletedContact, prefs);

    List<Contact> finalContactsList = eventObject.object;

    for (var deleteMe = 0; deleteMe < contacts.length; deleteMe++) {
      if (contacts[deleteMe].id == contact.id) {
        finalContactsList.removeAt(deleteMe);
      }
    }

    bool removeSuccessful = await prefs.setString(
        SharedPreferenceKeys.CONTACTS, json.encode(finalContactsList));
    if (removeSuccessful != null) {
      return new EventObject(id: Events.CONTACT_WAS_DELETED_SUCCESSFULLY);
    } else {
      return new EventObject(id: Events.UNABLE_TO_DELETE_CONTACT);
    }
  } else {
    return new EventObject(id: Events.UNABLE_TO_DELETE_CONTACT);
  }
}

Future<EventObject> updateContactUsingPrefs(Contact contact) async {
  var prefs = await _getPrefs();
  saveLogsUsingPrefs(LogPreferenceTransactions.UPDATING_CONTACT, prefs);
  EventObject eventObject = await getContactsUsingPrefs();
  if (eventObject.id == Events.READ_CONTACTS_SUCCESSFUL) {
    List<Contact> contacts = eventObject.object;
    List<Contact> finalContactsList = eventObject.object;
    for (var updateMe = 0; updateMe < contacts.length; updateMe++) {
      if (contacts[updateMe].id == contact.id) {
        finalContactsList[updateMe] = contact;
      }
    }

    bool updateSuccessful = await prefs.setString(
        SharedPreferenceKeys.CONTACTS, json.encode(finalContactsList));
    if (updateSuccessful != null) {
      return new EventObject(id: Events.CONTACT_WAS_UPDATED_SUCCESSFULLY);
    } else {
      return new EventObject(id: Events.UNABLE_TO_UPDATE_CONTACT);
    }
  } else {
    return new EventObject(id: Events.UNABLE_TO_UPDATE_CONTACT);
  }
}

Future<EventObject> searchContactUsingPrefs(String searchQuery) async {
  var prefs = await _getPrefs();
  saveLogsUsingPrefs(LogPreferenceTransactions.SEARCHING_CONTACT, prefs);
  EventObject eventObject = await getContactsUsingPrefs();
  if (eventObject.id == Events.READ_CONTACTS_SUCCESSFUL) {
    List<Contact> contacts = eventObject.object;
    List<Contact> searchedContacts = new List();
    for (Contact contact in contacts) {
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
  } else {
    return EventObject(id: Events.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY);
  }
}

Future<void> saveDeletedContactUsingPrefs(
    DeletedContact deletedContact, SharedPreferences prefs) async {
  EventObject eventObject = await getDeletedContactsUsingPrefs();
  List<DeletedContact> deletedContacts;
  if (eventObject.id == Events.READ_DELETED_CONTACTS_SUCCESSFUL) {
    deletedContacts = eventObject.object;
  } else {
    deletedContacts = new List();
  }
  deletedContacts.add(deletedContact);

  bool saveSuccessful = await prefs.setString(
      SharedPreferenceKeys.DELETED_CONTACTS, json.encode(deletedContacts));
  if (saveSuccessful != null) {
// Deleted Contact Saved Successfully
  } else {
// Unable to Save Deleted Contact
  }
}

Future<void> saveLogsUsingPrefs(
    String logTransaction, SharedPreferences prefs) async {
  EventObject eventObject = await getLogsUsingPrefs();
  List<Log> logs;
  if (eventObject.id == Events.READ_LOGS_SUCCESSFUL) {
    logs = eventObject.object;
  } else {
    logs = new List();
  }
  logs.add(getLog(logTransaction));

  bool saveSuccessful =
      await prefs.setString(SharedPreferenceKeys.LOGS, json.encode(logs));
  if (saveSuccessful != null) {
// Log Saved Successfully
  } else {
// Unable to Save Log
  }
}
