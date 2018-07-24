# Contacts (In 4 Ways[API, Custom, Preferences and Sqflite])

[App in Action](https://youtu.be/yj1XKuq9TIQ)

## App Demonstrating the use of Flutter and PHP.

* App Logo Created Using [Material Design Icons](https://materialdesignicons.com/)
* For Hosting used [Hostinger](https://www.hostinger.in/)

## Built With

* [Flutter](https://flutter.io) - Cross Platform App Development Framework

## Screenshots

<div id="images" style="#images {
    white-space: nowrap;
}">
<img src="screenshots/App_In_App_Drawer.png" alt="Contacts App In App Drawer" width="150" height="250">
<img src="screenshots/App_Logo.jpg" alt="App Logo" width="150" height="250">
<img src="screenshots/Ways_Available.jpg" alt="Ways Available in The App" width="150" height="250">
<img src="screenshots/Contacts.jpg" alt="Contacts" width="150" height="250">
</div>
<br/>

<div id="images" style="#images {
    white-space: nowrap;
}">
<img src="screenshots/Logs.jpg" alt="Logs" width="150" height="250">
<img src="screenshots/Navigation_Drawer.jpg" alt="Navigation Drawer" width="150" height="250">
<img src="screenshots/Contact_Details.jpg" alt="Contact Details" width="150" height="250">
<img src="screenshots/Deleted_Contacts.jpg" alt="Deleted Contacts" width="150" height="250">
</div>
<br/>

<div id="images" style="#images {
    white-space: nowrap;
}">
<img src="screenshots/Edit_Contact.jpg" alt="Edit Contact" width="150" height="250">
<img src="screenshots/Search_Contacts_With_Search_Query.jpg" alt="Search Contacts With Search Query" width="150" height="250">
<img src="screenshots/Create_Contact.jpg" alt="Create Contact" width="150" height="250">
<img src="screenshots/Google_Place_Search.jpg" alt="Google Place Search" width="150" height="250">
</div>
<br/>


## How to use this App.
* Host the sample included inside [phpbackend](https://github.com/harsh159357/contacts/blob/master/phpbackend/) on preferred web hosting
* Create Tables inside your database using [contacts.sql](https://github.com/harsh159357/contacts/blob/master/phpbackend/contacts.sql)
* If you are using your own website with the steps mentioned above edit the following constant inside [constants.dart](https://github.com/harsh159357/contacts/blob/master/lib/utils/constants.dart)

  static const String _CONTACT_API_BASE_URL = "http://hafinse.pe.hu/contact/";

* Make sure to edit [DatabaseConnection.php](https://github.com/harsh159357/contacts/blob/master/phpbackend/config/DatabaseConnection.php) and change following things  If you are using the files available in phpbackend-

     private $host = "your_host";
     private $db_name = "your_database_name";
     private $username = "your_user_name";
     private $password = "your_password";
* Make Sure to Use your own Google Place Search API key edit the following constant inside [constants.dart](https://github.com/harsh159357/contacts/blob/master/lib/utils/constants.dart)

  const String GOOGLE_PLACE_API_KEY = "REPLACE_IT_WITH_YOUR_OWN_API_KEY";


### Not Interested in doing above steps just clone this repo and use it as it is already hosted on Free Web Host Hostinger [hafinse](https://hafinse.pe.hu)

## Features Implemented
* App is Working on Android and Ios Platforms.
* App Implemented in 4 Ways For all the Operations Available in the App
   -> API = Integrate REST APIs Created In PHP [Postman Collection Link for REST APIs](https://www.getpostman.com/collections/73c185782197c548c18a)
   -> Custom =  Used Classes and Objects
   -> Preferences = Used Shared Preferences
   -> Sqflite = Used Sqlite Database
* Rest APIs in PHP
* Splash
* Navigation Drawer
* Contacts List
* Deleted Contacts List
* Logs
* Create Contact
* Contact Details
* Edit Contact
* Search Contacts
* Floating Action Button
* Hero Animation
* Google Place Search


## Things you can learn through this project -
* Hero Animation from a Contact List Item to Contact Detail.
* Google Place Search.
* Right Swipe to Edit a Contact and Right Swipe to Delete a Contact.
* Regular Expressions.
* Form validations.
* Multiple Floating Action Button on Single Page.
* Starting a Page for Result.
* Conversion from Base64 String to Image and Image to Base64 String.
* Image Picking from Gallery and Camera.
* Call Intent Launching from Contact Details.
* Mail Intent Launching from Contact Details.
* Map Intent Launching from Contact Details
* Store and Retrieve values from APIs.
* Store and Retrieve values from Shared Preference.
* Store and Retrieve values from SQLite Database.
* Store and Retrieve values from temporary Objects.
* Navigation Drawer.
* Navigation Drawer with Multiple Type Of Views.
* Navigation Between Pages.
* Performing Operations in Background Thread.
* Background Operations Chaining.
* Integration of Rest APIs.
* Creation of REST APIs in PHP
* Serialization and DesSerialization of JSON.
* ProgressDialogs and SnackBar.
* Custom Progress Dialog & Custom Views.


#### Spread Some :heart:

[![GitHub stars](https://img.shields.io/github/stars/aritraroy/ultimate-android-reference.svg?style=social&label=Star)](https://github.com/harsh159357/contacts) [![GitHub forks](https://img.shields.io/github/forks/aritraroy/ultimate-android-reference.svg?style=social&label=Fork)](https://github.com/harsh159357/flutter_client_php_backend/fork) [![GitHub watchers](https://img.shields.io/github/watchers/aritraroy/ultimate-android-reference.svg?style=social&label=Watch)](https://github.com/harsh159357/flutter_client_php_backend)[![GitHub followers](https://img.shields.io/github/followers/aritraroy.svg?style=social&label=Follow)](https://github.com/harsh159357/)

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/Apache-2.0)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://github.com/harsh159357/contacts/blob/master/License.txt)

Check out the repo make a pull request, raise issues and give a star if it's helpful.

### Its Android CounterPart [Click Here](https://github.com/harsh159357/contacts)

### If you are aware of [Postman](https://www.getpostman.com/) you can use [Postman Collection](https://www.getpostman.com/collections/73c185782197c548c18a) for Rest API used in this repo

## Helping Hands for this project

* https://flutter.io/
* https://pub.dartlang.org/packages/flutter_launcher_icons
* https://pub.dartlang.org/packages/shared_preferences
* https://pub.dartlang.org/packages/http
* https://pub.dartlang.org/packages/json_annotation
* https://pub.dartlang.org/packages/path_provider
* https://pub.dartlang.org/packages/url_launcher
* https://pub.dartlang.org/packages/image_picker
* https://pub.dartlang.org/packages/json_serializable
* https://pub.dartlang.org/packages/sqflite
* https://libraries.io/pub/intl
* https://flutter.io/animations/hero-animations/
* https://flutter.io/cookbook/design/drawer/
* https://flutter.io/json/#creating-model-classes-the-json_serializable-way
* https://flutter.io/json/
* https://flutter.io/cookbook/networking/fetch-data/
* https://flutter.io/cookbook/


### :heart: Found this project useful?
If you found this project useful, then please consider giving it a :star: on Github and sharing it with your friends via social media.

### Last But not Least
There are still some things which are pending in this project make a pull request to improve this project or suggest an idea
to improve this project further by raising issues.

### Project Maintained By

# Harsh Sharma

Android Developer

<a href="https://stackoverflow.com/users/5159205/harsh-sharma"><img src="https://github.com/aritraroy/social-icons/blob/master/stackoverflow-icon.png?raw=true" width="60"></a>
<a href="https://www.linkedin.com/in/harsh159357/"><img src="https://github.com/aritraroy/social-icons/blob/master/linkedin-icon.png?raw=true" width="60"></a>
<a href="https://www.facebook.com/HARSH159357"><img src="https://github.com/aritraroy/social-icons/blob/master/facebook-icon.png?raw=true" width="60"></a>

License
-------

    Copyright 2018 Harsh Sharma

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
