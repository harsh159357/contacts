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

import 'dart:io';

import 'package:contacts/customviews/progress_dialog.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/utils/constants.dart';
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
      ProgressDialogTitles.LOADING_CONTACTS, false);

  Contact contact;

  File _imageFile;

  TextEditingController nameController = new TextEditingController(text: "");

  TextEditingController phoneController = new TextEditingController(text: "");

  TextEditingController emailController = new TextEditingController(text: "");

  TextEditingController addressController = new TextEditingController(text: "");

  TextEditingController latitudeController =
      new TextEditingController(text: "28.1234567");

  TextEditingController longitudeController =
      new TextEditingController(text: "40.1234567");

  Widget createContactWidget = new Container();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    createContactWidget = ListView(
      children: <Widget>[
        new Center(
          child: new Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: new Column(
              children: <Widget>[
                _imageContainer(),
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
        textTheme: new TextTheme(
            title: new TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        )),
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(Texts.CREATE_CONTACT),
      ),
      body: new Stack(
        children: <Widget>[createContactWidget, progressDialog],
      ),
      backgroundColor: Colors.grey[150],
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _floatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton(
            onPressed: () {
              _validateCreateContactForm();
            },
            heroTag: Texts.SAVE_CONTACT,
            tooltip: Texts.SAVE_CONTACT,
            child: const Icon(Icons.done),
          ),
        ),
      ],
    );
  }

  void _pickImage(ImageSource source) async {
    var imageFile = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = imageFile;
    });
  }

  Widget _imageContainer() {
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

  Widget _formContainer() {
    return new Container(
      margin: EdgeInsets.only(top: 10.0),
      child: new Form(
          child: new Theme(
              data: new ThemeData(primarySwatch: Colors.blue),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _formField(nameController, Icons.face, Texts.NAME,
                      TextInputType.text, false),
                  _formField(phoneController, Icons.phone, Texts.PHONE,
                      TextInputType.phone, false),
                  _formField(emailController, Icons.email, Texts.EMAIL,
                      TextInputType.emailAddress, false),
                  _formField(addressController, Icons.location_on,
                      Texts.ADDRESS, TextInputType.text, false),
                ],
              ))),
    );
  }

  Widget _formField(TextEditingController textEditingController, IconData icon,
      String text, TextInputType textInputType, bool obscureText) {
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
          obscureText: obscureText,
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
    if (name.length < 3 || name.length > 15) {
      showSnackBar(SnackBarText.PLEASE_FILL_NAME);
      return;
    }

    String phone = phoneController.text;
    if (!isValidPhone(phone)) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_PHONE_NO);
      return;
    }

    if (phone.length < 3 || phone.length > 15) {
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
    showSnackBar("Validation Successful");
  }

  void createContact() async {}

  void showSnackBar(String textToBeShown) {
    globalKey.currentState.showSnackBar(new SnackBar(
      content: new Text(textToBeShown),
    ));
  }

  bool isValidEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  bool isValidPhone(String phone) {
    String p = r'^[0-9]+$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(phone);
  }
}
