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

//------------------------------------------------------------------------------
class APIConstants {
  static const String _CONTACT_API_BASE_URL = "http://hafinse.pe.hu/contact/";

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
}

//------------------------------------------------------------------------------
class EventConstants {
  static const int NO_INTERNET_CONNECTION = 0;

//------------------------------------------------------------------------------

  static const int READ_CONTACTS_SUCCESSFUL = 500;
  static const int NO_CONTACTS_FOUND = 501;
  static const int READ_CONTACTS_UN_SUCCESSFUL = 502;

//------------------------------------------------------------------------------

  static const int READ_DELETED_CONTACTS_SUCCESSFUL = 503;
  static const int NO_DELETED_CONTACTS_FOUND = 504;
  static const int READ_DELETED_CONTACTS_UN_SUCCESSFUL = 505;

//------------------------------------------------------------------------------

  static const int READ_LOGS_SUCCESSFUL = 506;
  static const int NO_LOGS_FOUND = 507;
  static const int READ_LOGS_UN_SUCCESSFUL = 508;
//------------------------------------------------------------------------------
}

//------------------------------------------------------------------------------
class APIResponseCode {
  static const int SC_OK = 200;
  static const int SC_CREATED = 201;
  static const int SC_BAD_REQUEST = 400;
  static const int SC_NOT_FOUND = 404;
  static const int SC_INTERNAL_SERVER_ERROR = 500;
}
//------------------------------------------------------------------------------

class SharedPreferenceKeys {}

//------------------------------------------------------------------------------
class ProgressDialogTitles {
  static const String LOADING_CONTACTS = "Contacts...";
  static const String LOADING_DELETED_CONTACTS = "Contacts...";
  static const String LOADING_LOGS = "Logs...";
}

//------------------------------------------------------------------------------
class SnackBarText {
  static const String TAPPED_ON_API_HEADER =
      "Contacts App Implemented Using Rest APIS";

//------------------------------------------------------------------------------

  static const String CONTACTS_LOADED_SUCCESSFULLY =
      "Contacts Loaded Successfully";
  static const String UNABLE_TO_LOAD_CONTACTS = "Unable to Load Contacts";
  static const String NO_CONTACTS_FOUND = "No Contacts Found";

//------------------------------------------------------------------------------

  static const String DELETED_CONTACTS_LOADED_SUCCESSFULLY =
      "Deleted Contacts Loaded Successfully";
  static const String NO_DELETED_CONTACTS_FOUND = "No Deleted Contacts Found";
  static const String UNABLE_TO_LOAD_DELETED_CONTACTS =
      "Unable to Load Deleted Contacts";

//------------------------------------------------------------------------------

  static const String LOGS_LOADED_SUCCESSFULLY = "Logs Loaded Successfully";
  static const String NO_LOGS_FOUND = "No Logs Found";
  static const String UNABLE_TO_LOAD_LOGS = "Unable to Load Logs";

//------------------------------------------------------------------------------

  static const String PLEASE_PICK_AN_IMAGE_EITHER_FROM_GALLERY_OR_CAMERA =
      "Please pick an image from Gallery/Camera";

  static const String PLEASE_FILL_NAME =
      "Please fill name within range of 4 to 15 Characters";

  static const String PLEASE_FILL_PHONE_NO =
      "Please fill phone no within range od 4 to 15 digits";

  static const String PLEASE_FILL_VALID_PHONE_NO = "Please fill valid phone no";

  static const String PLEASE_FILL_VALID_EMAIL_ADDRESS =
      "Please fill valid email address";

  static const String PLEASE_FILL_ADDRESS =
      "Please fill address within range od 4 to 1000 Characters";

//------------------------------------------------------------------------------

  static const String NO_INTERNET_CONNECTION = "!! No Internet Connection !!";
}

//------------------------------------------------------------------------------
class Texts {
  static const String APP_NAME = "Contacts";
  static const String WAYS = "Ways";
  static const String API = "API";
  static const String CUSTOM = "Custom";
  static const String CONTACT_DETAILS = "Contact Details";
  static const String PREFERENCES = "Preferences";
  static const String CREATE_CONTACT = "Create Contact";
  static const String SQFLITE = "Sqflite";
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
  static const YOU_HAVE_NOT_YET_PICKED_AN_IMAGE =
      "You have not yet picked an image.";
}

//------------------------------------------------------------------------------
class DrawerTitles {
  static const String CONTACTS = "Contacts";
  static const String DELETED_CONTACTS = "Deleted Contacts";
  static const String SEARCH_CONTACTS = "Search Contacts";
  static const String LOGS = "Logs";
}

//------------------------------------------------------------------------------
class Actions {
  static const String VIEW_CONTACT = "View";
  static const String CREATE_CONTACT = "View";
  static const String DELETE_CONTACT = "Delete";
  static const String EDIT_OR_UPDATE_CONTACT = "Edit";
}
//------------------------------------------------------------------------------
