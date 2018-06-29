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
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ContactsDatabase {
//------------------------------------------------------------------------------
  static final ContactsDatabase _contactsDatabase =
      new ContactsDatabase._internal();

  ContactsDatabase._internal();

  Database _database;

  static ContactsDatabase get() {
    return _contactsDatabase;
  }

  bool didInit = false;

  Future<Database> _getDb() async {
    if (!didInit) await _initDatabase();
    return _database;
  }

//------------------------------------------------------------------------------

  Future _initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DATABASE_NAME);
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await _createContactTable(db);
      await _createDeletedContactsTable(db);
      await _createLogTable(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE ${ContactTable.TABLE_NAME}");
      await db.execute("DROP TABLE ${DeletedContactsTable.TABLE_NAME}");
      await db.execute("DROP TABLE ${LogsTable.TABLE_NAME}");
      await _createContactTable(db);
      await _createDeletedContactsTable(db);
      await _createLogTable(db);
    });
    didInit = true;
  }

  Future _createContactTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute(CreateTableQueries.CREATE_CONTACT_TABLE);
    });
  }

  Future _createDeletedContactsTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute(CreateTableQueries.CREATE_DELTED_CONTACTS_TABLE);
    });
  }

  Future _createLogTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute(CreateTableQueries.CREATE_LOG_TABLE);
    });
  }

//------------------------------------------------------------------------------

}

//------------------------------------------------------------------------------
Future<EventObject> getContacts() async {
  try {
    var db = await ContactsDatabase.get()._getDb();
    saveLog(LogTableTransactions.READING_CONTACTS);

    List<Map> contactsMap =
        await db.rawQuery("Select * from ${ContactTable.TABLE_NAME}");
    List<Contact> contacts = new List();
    if (contactsMap.isNotEmpty) {
      for (int i = 0; i < contactsMap.length; i++) {
        contacts.add(Contact.fromMap(contactsMap[i]));
      }
      return EventObject(
          id: EventConstants.READ_CONTACTS_SUCCESSFUL, object: contacts);
    } else {
      return EventObject(id: EventConstants.NO_CONTACTS_FOUND);
    }
  } catch (e) {
    print(e.toString());
    return new EventObject(id: EventConstants.READ_CONTACTS_UN_SUCCESSFUL);
  }
}

//------------------------------------------------------------------------------
Future<EventObject> searchContactsInLocalDatabase(String searchQuery) async {
  try {
    var db = await ContactsDatabase.get()._getDb();
    saveLog(LogTableTransactions.SEARCHING_CONTACT);

    //Like query not used here in searching cuz its not working for sqflite
    List<Map> contactsMap =
        await db.rawQuery("Select * from ${ContactTable.TABLE_NAME}");

    List<Contact> contacts = new List();
    if (contactsMap.isNotEmpty) {
      for (int i = 0; i < contactsMap.length; i++) {
        contacts.add(Contact.fromMap(contactsMap[i]));
      }
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
            id: EventConstants.SEARCH_CONTACTS_SUCCESSFUL,
            object: searchedContacts);
      } else {
        return EventObject(
            id: EventConstants.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY);
      }
    } else {
      return EventObject(
          id: EventConstants.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY);
    }
  } catch (e) {
    print(e.toString());
    return new EventObject(
        id: EventConstants.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY);
  }
}

//------------------------------------------------------------------------------
Future<EventObject> updateContact(Contact contact) async {
  try {
    var db = await ContactsDatabase.get()._getDb();
    saveLog(LogTableTransactions.UPDATING_CONTACT);

    int affectedRows = await db.update(ContactTable.TABLE_NAME, contact.toMap(),
        where: "${ContactTable.ID}=?", whereArgs: [contact.id]);

    if (affectedRows > 0) {
      return EventObject(
        id: EventConstants.CONTACT_WAS_UPDATED_SUCCESSFULLY,
      );
    } else {
      return EventObject(
          id: EventConstants.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE);
    }
  } catch (e) {
    print(e.toString());
    return new EventObject(id: EventConstants.UNABLE_TO_UPDATE_CONTACT);
  }
}

//------------------------------------------------------------------------------
Future<EventObject> saveContact(Contact contact) async {
  try {
    var db = await ContactsDatabase.get()._getDb();
    saveLog(LogTableTransactions.CREATING_CONTACT);
    int affectedRows =
        await db.insert(ContactTable.TABLE_NAME, contact.toMap());
    if (affectedRows > 0) {
      return EventObject(
        id: EventConstants.CONTACT_WAS_CREATED_SUCCESSFULLY,
      );
    } else {
      return EventObject(id: EventConstants.UNABLE_TO_CREATE_CONTACT);
    }
  } catch (e) {
    print(e.toString());
    return new EventObject(id: EventConstants.UNABLE_TO_CREATE_CONTACT);
  }
}

//------------------------------------------------------------------------------
Future<void> saveDeletedContact(DeletedContact deletedContact) async {
  try {
    var db = await ContactsDatabase.get()._getDb();
    saveLog(LogTableTransactions.CREATING_DELETED_CONTACT);
    int affectedRows = await db.insert(
        DeletedContactsTable.TABLE_NAME, deletedContact.toMap());
    if (affectedRows > 0) {
//      print(Texts.CONTACT_STORED_IN_DELETED_CONTACTS_TABLE);
    } else {
//      print(Texts.UNABLE_TO_STORE_CONTACT_IN_DELETED_CONTACT_TABLE);
    }
  } catch (e) {
    print(e.toString());
  }
}

//------------------------------------------------------------------------------
Future<EventObject> removeContact(Contact contact) async {
  try {
    var db = await ContactsDatabase.get()._getDb();
    saveLog(LogTableTransactions.DELETING_CONTACT);

    saveDeletedContact(new DeletedContact(
        id: contact.id,
        name: contact.name,
        phone: contact.phone,
        email: contact.email,
        address: contact.address,
        latitude: contact.latitude,
        longitude: contact.longitude,
        contactImage: contact.contactImage));

    int affectedRows = await db.delete(ContactTable.TABLE_NAME,
        where: "${ContactTable.ID}=?", whereArgs: [contact.id]);
    if (affectedRows > 0) {
      return EventObject(
        id: EventConstants.CONTACT_WAS_DELETED_SUCCESSFULLY,
      );
    } else {
      return EventObject(
          id: EventConstants.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE);
    }
  } catch (e) {
    print(e.toString());
    return new EventObject(
        id: EventConstants.PLEASE_PROVIDE_THE_ID_OF_THE_CONTACT_TO_BE_DELETED);
  }
}

//------------------------------------------------------------------------------
Future<EventObject> getDeletedContacts() async {
  try {
    var db = await ContactsDatabase.get()._getDb();
    saveLog(LogTableTransactions.READING_DELETED_CONTACTS);
    List<Map> deletedContactsMap =
        await db.rawQuery("Select * from ${DeletedContactsTable.TABLE_NAME}");

    List<DeletedContact> deletedContacts = new List();
    if (deletedContactsMap.isNotEmpty) {
      for (int i = 0; i < deletedContactsMap.length; i++) {
        deletedContacts.add(DeletedContact.fromMap(deletedContactsMap[i]));
      }
      return EventObject(
          id: EventConstants.READ_DELETED_CONTACTS_SUCCESSFUL,
          object: deletedContacts);
    } else {
      return EventObject(id: EventConstants.NO_DELETED_CONTACTS_FOUND);
    }
  } catch (e) {
    print(e.toString());
    return new EventObject(
        id: EventConstants.READ_DELETED_CONTACTS_UN_SUCCESSFUL);
  }
}

//------------------------------------------------------------------------------
Future<EventObject> getLogs() async {
  try {
    var db = await ContactsDatabase.get()._getDb();
    List<Map> logsMap =
        await db.rawQuery("Select * from ${LogsTable.TABLE_NAME}");

    List<Log> logs = new List();
    if (logsMap.isNotEmpty) {
      for (int i = 0; i < logsMap.length; i++) {
        logs.add(Log.fromMap(logsMap[i]));
      }
      return EventObject(id: EventConstants.READ_LOGS_SUCCESSFUL, object: logs);
    } else {
      return EventObject(id: EventConstants.NO_LOGS_FOUND);
    }
  } catch (e) {
    print(e.toString());
    return new EventObject(id: EventConstants.READ_LOGS_UN_SUCCESSFUL);
  }
}

//------------------------------------------------------------------------------
Future<void> saveLog(String transaction) async {
  try {
    Log log = new Log();
    DateTime dateTime = DateTime.now();
    log.column_timestamp = dateTime.millisecondsSinceEpoch.toString();
    log.column_date =
        formatTimeStamp(dateTime, LogTableTransactions.DATE_FORMAT);
    log.column_transaction = transaction;

    var db = await ContactsDatabase.get()._getDb();

    int affectedRows = await db.insert(LogsTable.TABLE_NAME, log.toMap());
    if (affectedRows > 0) {
//      print(Texts.LOGS_STORED_IN_LOGS_TABLE);
    } else {
//      print(Texts.UNABLE_TO_STORE_LOGS_IN_LOG_TABLE);
    }
  } catch (e) {
    print(e.toString());
  }
}

//------------------------------------------------------------------------------
