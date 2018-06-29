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

import 'package:contacts/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact extends Object with _$ContactSerializerMixin {
  String id;
  String name;
  String phone;
  String email;
  String address;
  String latitude;
  String longitude;
  String contactImage;

  Contact(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.latitude,
      this.longitude,
      this.contactImage});

  static Future<List<Contact>> fromContactJson(List<dynamic> json) async {
    List<Contact> contactList = new List<Contact>();
    for (var contact in json) {
      contactList.add(new Contact(
        id: contact['_id'],
        name: contact['name'],
        phone: contact['phone'],
        email: contact['email'],
        address: contact['address'],
        latitude: contact['latitude'],
        longitude: contact['longitude'],
        contactImage: contact['contact_image'],
      ));
    }
    return contactList;
  }

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map toMap() {
    Map<String, dynamic> contactMap = <String, dynamic>{
      ContactTable.NAME: name,
      ContactTable.PHONE: phone,
      ContactTable.EMAIL: email,
      ContactTable.ADDRESS: address,
      ContactTable.LATITUDE: latitude,
      ContactTable.LONGITUDE: longitude,
      ContactTable.CONTACT_IMAGE: contactImage,
    };

    return contactMap;
  }

  static Contact fromMap(Map map) {
    return new Contact(
      id: map[ContactTable.ID].toString(),
      name: map[ContactTable.NAME],
      phone: map[ContactTable.PHONE],
      email: map[ContactTable.EMAIL],
      address: map[ContactTable.ADDRESS],
      latitude: map[ContactTable.LATITUDE],
      longitude: map[ContactTable.LONGITUDE],
      contactImage: map[ContactTable.CONTACT_IMAGE],
    );
  }
}
