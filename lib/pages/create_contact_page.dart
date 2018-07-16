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

import 'dart:convert';
import 'dart:io';

import 'package:contacts/common_widgets/progress_dialog.dart';
import 'package:contacts/models/base/event_object.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/utils/constants.dart';
import 'package:contacts/utils/functions.dart';
import 'package:contacts/futures/common.dart';
import 'package:contacts/pages/google_place_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:image_picker/image_picker.dart';

class CreateContactPage extends StatefulWidget {
  @override
  createState() => new CreateContactPageState();
}

class CreateContactPageState extends State<CreateContactPage> {
  static final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(
      ProgressDialogTitles.CREATING_CONTACT, false);

  File _imageFile;

  TextEditingController nameController = new TextEditingController(text: "");

  TextEditingController phoneController = new TextEditingController(text: "");

  TextEditingController emailController = new TextEditingController(text: "");

  TextEditingController addressController = new TextEditingController(text: "");

  TextEditingController latController = new TextEditingController(text: "");

  TextEditingController longController = new TextEditingController(text: "");

  Widget createContactWidget = new Container();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    createContactWidget = ListView(
      reverse: true,
      children: <Widget>[
        new Center(
          child: new Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: new Column(
              children: <Widget>[
                _contactImageContainer(),
                _formContainer(),
              ],
            ),
          ),
        )
      ],
    );
    return new Scaffold(
      key: globalKey,
      appBar: new AppBar(
        centerTitle: true,
        leading: new GestureDetector(
          onTap: () {
            Navigator.pop(context, Events.USER_HAS_NOT_CREATED_ANY_CONTACT);
          },
          child: new Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
        ),
        textTheme: new TextTheme(
            title: new TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        )),
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(Texts.CREATE_CONTACT),
        actions: <Widget>[
          new GestureDetector(
            onTap: () {
              _validateCreateContactForm();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: new Icon(
                Icons.done,
                size: 30.0,
              ),
            ),
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[createContactWidget, progressDialog],
      ),
      backgroundColor: Colors.grey[150],
    );
  }

  void _pickImage(ImageSource source) async {
    var imageFile = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = imageFile;
    });
  }

  Widget _contactImageContainer() {
    return new Container(
      height: 150.0,
      margin: EdgeInsets.only(top: 10.0),
      child: new Row(
        children: <Widget>[
          _pickFromGallery(),
          _imagePicked(),
          _pickFromCamera()
        ],
      ),
    );
  }

  Widget _pickFromGallery() {
    return new Flexible(
      child: new GestureDetector(
        onTap: () {
          _pickImage(ImageSource.gallery);
        },
        child: new Container(
          height: 60.0,
          width: 60.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle, color: Colors.blue[400]),
          child: new Icon(
            Icons.photo_library,
            size: 35.0,
            color: Colors.white,
          ),
        ),
      ),
      fit: FlexFit.tight,
      flex: 1,
    );
  }

  Widget _imagePicked() {
    return new Flexible(
      child: _imageFile == null
          ? new Text(
              Texts.YOU_HAVE_NOT_YET_PICKED_AN_IMAGE,
              style: new TextStyle(
                color: Colors.blueGrey[400],
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            )
          : new Image.file(
              _imageFile,
              fit: BoxFit.cover,
            ),
      fit: FlexFit.tight,
      flex: 2,
    );
  }

  Widget _pickFromCamera() {
    return new Flexible(
      child: new GestureDetector(
        onTap: () {
          _pickImage(ImageSource.camera);
        },
        child: new Container(
          height: 60.0,
          width: 60.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle, color: Colors.blue[400]),
          child: new Icon(
            Icons.camera_alt,
            size: 35.0,
            color: Colors.white,
          ),
        ),
      ),
      fit: FlexFit.tight,
      flex: 1,
    );
  }

  Widget _pickAPlace() {
    return new GestureDetector(
      onTap: () {
        _navigateToPlaceSearch(context);
      },
      child: new Container(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Flexible(
              child: new Text(
                Texts.PICK_A_PLACE,
                style: new TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              fit: FlexFit.tight,
            ),
            new Flexible(
              child: new Icon(
                Icons.search,
                color: Colors.blue[400],
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      ),
    );
  }

  Widget _formContainer() {
    return new Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: new Form(
          child: new Theme(
              data: new ThemeData(primarySwatch: Colors.blue),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _formField(nameController, Icons.face, Texts.NAME,
                      TextInputType.text),
                  _formField(phoneController, Icons.phone, Texts.PHONE,
                      TextInputType.phone),
                  _formField(emailController, Icons.email, Texts.EMAIL,
                      TextInputType.emailAddress),
                  _pickAPlace(),
                  _formField(addressController, Icons.location_on,
                      Texts.ADDRESS, TextInputType.text),
                  new Row(
                    children: <Widget>[
                      new Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: _formField(latController, Icons.my_location,
                              Texts.LATITUDE, TextInputType.number),
                        ),
                      ),
                      new Flexible(
                        child: _formField(longController, Icons.my_location,
                            Texts.LONGITUDE, TextInputType.number),
                      )
                    ],
                  ),
                ],
              ))),
    );
  }

  Widget _formField(TextEditingController textEditingController, IconData icon,
      String text, TextInputType textInputType) {
    return new Container(
        child: new TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
              suffixIcon: new Icon(
                icon,
                color: Colors.blue[400],
              ),
              labelText: text,
              labelStyle: TextStyle(fontSize: 18.0)),
          keyboardType: textInputType,
        ),
        margin: EdgeInsets.only(bottom: 10.0));
  }

  void _validateCreateContactForm() {
    if (_imageFile == null) {
      showSnackBar(
          SnackBarText.PLEASE_PICK_AN_IMAGE_EITHER_FROM_GALLERY_OR_CAMERA);
      return;
    }

    String name = nameController.text;
    if (name.length < 3 || name.length > 20) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_NAME);
      return;
    }

    String phone = phoneController.text;
    if (!isValidPhone(phone)) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_PHONE_NO);
      return;
    }

    if (phone.length < 6 || phone.length > 20) {
      showSnackBar(SnackBarText.PLEASE_FILL_PHONE_NO);
      return;
    }

    String email = emailController.text;
    if (!isValidEmail(email)) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_EMAIL_ADDRESS);
      return;
    }

    String address = addressController.text;
    if (address.length < 3 || address.length > 1000) {
      showSnackBar(SnackBarText.PLEASE_FILL_ADDRESS);
      return;
    }

    String latitude = latController.text;
    if (!isValidLatitude(latitude)) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_LATITUDE);
      return;
    }

    String longitude = longController.text;
    if (!isValidLongitude(longitude)) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_LONGITUDE);
      return;
    }
    FocusScope.of(context).requestFocus(new FocusNode());
    Contact contactToBeCreated = new Contact();
    contactToBeCreated.id = "";
    contactToBeCreated.name = nameController.text;
    contactToBeCreated.phone = phoneController.text;
    contactToBeCreated.email = emailController.text;
    contactToBeCreated.address = addressController.text;
    contactToBeCreated.latitude = latController.text;
    contactToBeCreated.longitude = longController.text;
    List<int> contactImageBytes = _imageFile.readAsBytesSync();
    contactToBeCreated.contactImage = base64Encode(contactImageBytes);
    progressDialog.show();
    createContact(contactToBeCreated);
  }

  void createContact(Contact contactToBeCreated) async {
    EventObject contactObject = await saveContact(contactToBeCreated);
    if (this.mounted) {
      setState(() {
        progressDialog.hide();
        switch (contactObject.id) {
          case Events.CONTACT_WAS_CREATED_SUCCESSFULLY:
            Navigator.pop(context, Events.CONTACT_WAS_CREATED_SUCCESSFULLY);
            break;
          case Events.UNABLE_TO_CREATE_CONTACT:
            Navigator.pop(context, Events.UNABLE_TO_CREATE_CONTACT);
            break;

          case Events.NO_INTERNET_CONNECTION:
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

  void _navigateToPlaceSearch(BuildContext context) async {
    Contact contact = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlaceSearchPage()),
    );
    setState(() {
      if (contact != null) {
        addressController.text = contact.address;
        latController.text = contact.latitude;
        longController.text = contact.longitude;
      }
    });
  }
}
