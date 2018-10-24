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

const String DATABASE_NAME = "contacts.db";

const String GOOGLE_PLACE_API_KEY = "REPLACE_IT_WITH_YOUR_OWN_API_KEY";

class APIConstants {
  static const String _CONTACT_API_BASE_URL = "https://hafinse.000webhostapp.com/contact/";

  static const String READ_CONTACTS =
      _CONTACT_API_BASE_URL + "ReadContacts.php";

  static const String READ_ONE_CONTACT =
      _CONTACT_API_BASE_URL + "ReadOneContact.php?_id=";

  static const String SEARCH_CONTACT =
      _CONTACT_API_BASE_URL + "SearchContact.php?s=";

  static const String CREATE_CONTACT =
      _CONTACT_API_BASE_URL + "CreateContact.php";

  static const String DELETE_CONTACT =
      _CONTACT_API_BASE_URL + "DeleteContact.php";

  static const String UPDATE_CONTACT =
      _CONTACT_API_BASE_URL + "UpdateContact.php";

  static const String READ_DELETED_CONTACTS =
      _CONTACT_API_BASE_URL + "ReadDeletedContacts.php";

  static const String READ_LOGS = _CONTACT_API_BASE_URL + "ReadLogs.php";

  static const String OCTET_STREAM_ENCODING = "application/octet-stream";
}

class APIResponseCode {
  static const int SC_OK = 200;
  static const int SC_CREATED = 201;
  static const int SC_BAD_REQUEST = 400;
  static const int SC_NOT_FOUND = 404;
  static const int SC_INTERNAL_SERVER_ERROR = 500;
}

class Events {
  static const int NO_INTERNET_CONNECTION = 0;

  static const int READ_CONTACTS_SUCCESSFUL = 500;
  static const int NO_CONTACTS_FOUND = 501;

  static const int READ_LOGS_SUCCESSFUL = 502;
  static const int NO_LOGS_FOUND = 503;

  static const int READ_DELETED_CONTACTS_SUCCESSFUL = 504;
  static const int NO_DELETED_CONTACTS_FOUND = 505;

  static const int CONTACT_WAS_CREATED_SUCCESSFULLY = 506;
  static const int UNABLE_TO_CREATE_CONTACT = 507;
  static const int USER_HAS_NOT_CREATED_ANY_CONTACT = 508;

  static const int CONTACT_WAS_DELETED_SUCCESSFULLY = 509;
  static const int PLEASE_PROVIDE_THE_ID_OF_THE_CONTACT_TO_BE_DELETED = 510;
  static const int NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE = 511;
  static const int UNABLE_TO_DELETE_CONTACT = 512;

  static const int CONTACT_WAS_UPDATED_SUCCESSFULLY = 513;
  static const int UNABLE_TO_UPDATE_CONTACT = 514;
  static const int USER_HAS_NOT_PERFORMED_UPDATE_ACTION = 515;

  static const int SEARCH_CONTACTS_SUCCESSFUL = 516;
  static const int NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY = 517;
}

class SharedPreferenceKeys {
  static const String AUTO_INCREMENT = "Auto Increment";
  static const String CONTACTS = "Contacts";
  static const String DELETED_CONTACTS = "Deleted Contacts";
  static const String LOGS = "LOGS";
}

class ProgressDialogTitles {
  static const String LOADING_CONTACTS = "Contacts...";
  static const String DELETING_CONTACT = "Deleting...";
  static const String SEARCHING_CONTACTS = "Searching...";
  static const String CREATING_CONTACT = "Creating...";
  static const String EDITING_CONTACT = "Editing...";
  static const String LOADING_DELETED_CONTACTS = "Contacts...";
  static const String LOADING_LOGS = "Logs...";
}

class SnackBarText {
  static const String TAPPED_ON_API_HEADER =
      "Contacts App Implemented Using Rest APIS";
  static const String TAPPED_ON_SQF_LITE_HEADER =
      "Contacts App Implemented Using SQFLITE";
  static const String TAPPED_ON_CUSTOM_HEADER =
      "Contacts App Implemented Using Custom";
  static const String TAPPED_ON_PREFERENCES_HEADER =
      "Contacts App Implemented Using Preferences";

  static const String CONTACTS_LOADED_SUCCESSFULLY =
      "Contacts Loaded Successfully";
  static const String NO_CONTACTS_FOUND = "No Contacts Found";

  static const String LOGS_LOADED_SUCCESSFULLY = "Logs Loaded Successfully";
  static const String NO_LOGS_FOUND = "No Logs Found";

  static const String DELETED_CONTACTS_LOADED_SUCCESSFULLY =
      "Deleted Contacts Loaded Successfully";
  static const String NO_DELETED_CONTACTS_FOUND = "No Deleted Contacts Found";

  static const String CONTACTS_SEARCHED_SUCCESSFULLY =
      "Contacts Searched Successfully";
  static const String NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY =
      "No Contact Found for Search Query ";

  static const String CONTACT_WAS_CREATED_SUCCESSFULLY =
      "Contact was created successfully";
  static const String UNABLE_TO_CREATE_CONTACT = "Unable to create Contact";
  static const String USER_HAS_NOT_PERFORMED_ANY_ACTION =
      "User has not performed any action";

  static const String CONTACT_WAS_DELETED_SUCCESSFULLY =
      "Contact was Deleted Succesfully";
  static const String PLEASE_PROVIDE_THE_ID_OF_THE_CONTACT_TO_BE_DELETED =
      "Please provide the id of the contact to be deleted";
  static const String NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE =
      "No contact with provided id exist in Prferences";

  static const String CONTACT_WAS_UPDATED_SUCCESSFULLY =
      "Contact was Updated Succesfully";
  static const String UNABLE_TO_UPDATE_CONTACT = "Unable to update Contact";
  static const String USER_HAS_NOT_PERFORMED_EDIT_ACTION =
      "User has not performed edit action";

  static const String PLEASE_PICK_AN_IMAGE_EITHER_FROM_GALLERY_OR_CAMERA =
      "Please pick an image from Gallery/Camera";

  static const String PLEASE_FILL_VALID_NAME =
      "Please fill name within range of 4 to 20 Characters";

  static const String PLEASE_FILL_PHONE_NO =
      "Please fill phone no within range of 7 to 20 digits";

  static const String PLEASE_FILL_VALID_PHONE_NO = "Please fill valid phone no";

  static const String PLEASE_FILL_VALID_EMAIL_ADDRESS =
      "Please fill valid email address";

  static const String PLEASE_FILL_ADDRESS =
      "Please fill address within range of 4 to 1000 Characters";

  static const String PLEASE_FILL_VALID_LATITUDE = "Please fill valid latitude";

  static const String PLEASE_FILL_VALID_LONGITUDE =
      "Please fill valid longitude";

  static const String PLEASE_FILL_SOMETHING_IN_SEARCH_FIElD =
      "Please fill something in search field";

  static const String NO_INTERNET_CONNECTION = "!! No Internet Connection !!";
}

class Ways {
  static const String WAYS = "Ways";
  static const String API = "API";
  static const String CUSTOM = "Custom";
  static const String SQFLITE = "Sqflite";
  static const String PREFERENCES = "Preferences";
}

class Texts {
  static const String APP_NAME = "Contacts";
  static const String DELETE_CONTACT = "Delete Contact";
  static const String EDIT_CONTACT = "Edit Contact";
  static const String CONTACT_DETAILS = "Contact Details";
  static const String CREATE_CONTACT = "Create Contact";
  static const String NO_CONTACTS = "No Contacts";
  static const String NO_DELETED_CONTACTS = "No Deleted Contacts";
  static const String NO_LOGS = "No Logs";
  static const String ERROR_PICKING_IMAGE = "Error picking image.";
  static const String PICK_IMAGE_FROM_GALLERY = "Pick Image from gallery";
  static const String TAKE_A_PHOTO = "Take a Photo";
  static const String SAVE_CONTACT = "Save Contact";
  static const String NAME = "Name";
  static const String PHONE = "Phone";
  static const String EMAIL = "Email";
  static const String ADDRESS = "Address";
  static const String LATITUDE = "Latitude";
  static const String LONGITUDE = "Longitude";
  static const String PICK_A_PLACE = "Pick a Place";
  static const String TYPE_SOMETHING_HERE = "Type Something here";
  static const YOU_HAVE_NOT_YET_PICKED_AN_IMAGE =
      "You have not yet picked an image.";
  static const String CONTACT_STORED_IN_DELETED_CONTACTS_TABLE =
      "Contact Stored in Deleted Contacts Table";
  static const String UNABLE_TO_STORE_CONTACT_IN_DELETED_CONTACT_TABLE =
      "Unable to Store  Contact in Deleted Contacts Table";
  static const String LOGS_STORED_IN_LOGS_TABLE = "Logs Stored in Logs Table";
  static const String UNABLE_TO_STORE_LOGS_IN_LOG_TABLE =
      "Unable to Store  Logs in Logs Table";
}

class DrawerTitles {
  static const String TAPPED_ON_HEADER = "Tapped On Header";
  static const String CONTACTS = "Contacts";
  static const String CREATE_CONTACT = "Create Contact";
  static const String DELETED_CONTACTS = "Deleted Contacts";
  static const String SEARCH_CONTACTS = "Search Contacts";
  static const String LOGS = "Logs";
  static const String GO_BACK = "Go Back";
}

class RegularExpressionsPatterns {
  static const String EMAIL_VALIDATION =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const String PHONE_VALIDATION = r'^[0-9]+$';

  static const String LATITUDE_PATTERN =
      r'^(\+|-)?((\d((\.)|\.\d{1,10})?)|(0*?[0-8]\d((\.)|\.\d{1,10})?)|(0*?90((\.)|\.0{1,10})?))$';

  static const String LONGITUDE_PATTERN =
      r'^(\+|-)?((\d((\.)|\.\d{1,10})?)|(0*?\d\d((\.)|\.\d{1,10})?)|(0*?1[0-7]\d((\.)|\.\d{1,10})?)|(0*?180((\.)|\.0{1,10})?))$';
}

class ContactTable {
  static String TABLE_NAME = "Contact";
  static String ID = "_id";
  static String NAME = "name";
  static String PHONE = "phone";
  static String EMAIL = "email";
  static String ADDRESS = "address";
  static String LATITUDE = "latitude";
  static String LONGITUDE = "longitude";
  static String CONTACT_IMAGE = "contact_image";
}

class DeletedContactsTable {
  static String TABLE_NAME = "DeletedContacts";
  static String ID = "_id";
  static String NAME = "name";
  static String PHONE = "phone";
  static String EMAIL = "email";
  static String ADDRESS = "address";
  static String LATITUDE = "latitude";
  static String LONGITUDE = "longitude";
  static String CONTACT_IMAGE = "contact_image";
}

class LogsTable {
  static String TABLE_NAME = "Logs";
  static String COLUMN_TRANSACTION = "column_transaction";
  static String COLUMN_TIMESTAMP = "column_timestamp";
  static String COLUMN_DATE = "column_date";
}

class CreateTableQueries {
  static String CREATE_CONTACT_TABLE = "CREATE TABLE " +
      ContactTable.TABLE_NAME +
      "(" +
      ContactTable.ID +
      " INTEGER PRIMARY KEY AUTOINCREMENT," +
      ContactTable.NAME +
      " TEXT NOT NULL," +
      ContactTable.PHONE +
      " TEXT NOT NULL," +
      ContactTable.EMAIL +
      " TEXT NOT NULL," +
      ContactTable.ADDRESS +
      " TEXT NOT NULL," +
      ContactTable.LATITUDE +
      " TEXT NOT NULL," +
      ContactTable.LONGITUDE +
      " TEXT NOT NULL," +
      ContactTable.CONTACT_IMAGE +
      " TEXT NOT NULL);";

  static String CREATE_DELETED_CONTACTS_TABLE = "CREATE TABLE " +
      DeletedContactsTable.TABLE_NAME +
      "(" +
      DeletedContactsTable.ID +
      " INTEGER NOT NULL," +
      DeletedContactsTable.NAME +
      " TEXT NOT NULL," +
      DeletedContactsTable.PHONE +
      " TEXT NOT NULL," +
      DeletedContactsTable.EMAIL +
      " TEXT NOT NULL," +
      DeletedContactsTable.ADDRESS +
      " TEXT NOT NULL," +
      DeletedContactsTable.LATITUDE +
      " TEXT NOT NULL," +
      DeletedContactsTable.LONGITUDE +
      " TEXT NOT NULL," +
      DeletedContactsTable.CONTACT_IMAGE +
      " TEXT NOT NULL);";

  static String CREATE_LOG_TABLE = "CREATE TABLE " +
      LogsTable.TABLE_NAME +
      "(" +
      LogsTable.COLUMN_TIMESTAMP +
      " TEXT NOT NULL," +
      LogsTable.COLUMN_TRANSACTION +
      " TEXT NOT NULL," +
      LogsTable.COLUMN_DATE +
      " TEXT NOT NULL);";
}

class LogTableTransactions {
  static const String READING_CONTACTS =
      "Reading All the Contacts Available In Database.";
  static const String CREATING_CONTACT =
      "A New Contact is Being Inserted in Contact Table.";
  static const String READING_DELETED_CONTACTS =
      "Reading all the Deleted Contacts from Database.";
  static const String CREATING_DELETED_CONTACT =
      "Creating a Contact in Deleted Contacts Table.";
  static const String UPDATING_CONTACT = "Updating a Contact in Database.";
  static const String DELETING_CONTACT = "Deleting a Contact from Database.";
  static const String SEARCHING_CONTACT = "Searching a Contact in Database.";
  static const String DATE_FORMAT = "MM/dd/yyyy kk:mm:s a";
}

class LogPreferenceTransactions {
  static const String READING_CONTACTS =
      "Reading All the Contacts Available In Prferences.";
  static const String CREATING_CONTACT =
      "A New Contact is Being Inserted in Contacts Preference.";
  static const String READING_DELETED_CONTACTS =
      "Reading all the Deleted Contacts from Preferences.";
  static const String CREATING_DELETED_CONTACT =
      "Creating a Contact in Deleted Contacts Prferences.";
  static const String UPDATING_CONTACT = "Updating a Contact in Prferences.";
  static const String DELETING_CONTACT = "Deleting a Contact from Prferences.";
  static const String SEARCHING_CONTACT = "Searching a Contact in Prferences.";
  static const String DATE_FORMAT = "MM/dd/yyyy kk:mm:s a";
}

class LogCustomTransactions {
  static const String READING_CONTACTS =
      "Reading All the Contacts Available.";
  static const String CREATING_CONTACT =
      "A New Contact is Being Inserted.";
  static const String READING_DELETED_CONTACTS =
      "Reading all the Deleted Contacts.";
  static const String CREATING_DELETED_CONTACT =
      "Creating a Contact in Deleted Contacts.";
  static const String UPDATING_CONTACT = "Updating a Contact.";
  static const String DELETING_CONTACT = "Deleting a Contact.";
  static const String SEARCHING_CONTACT = "Searching a Contact.";
  static const String DATE_FORMAT = "MM/dd/yyyy kk:mm:s a";
}