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

part 'deleted_contact.g.dart';

@JsonSerializable()
class DeletedContact extends Object with _$DeletedContactSerializerMixin {
  String id;
  String name;
  String phone;
  String email;
  String address;
  String latitude;
  String longitude;
  String contactImage;

  DeletedContact(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.latitude,
      this.longitude,
      this.contactImage});

  static Future<List<DeletedContact>> fromDeletedContactJson(
      List<dynamic> json) async {
    List<DeletedContact> deletedContactList = new List<DeletedContact>();
    for (var contact in json) {
      deletedContactList.add(new DeletedContact(
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
    return deletedContactList;
  }

  factory DeletedContact.fromJson(Map<String, dynamic> json) =>
      _$DeletedContactFromJson(json);

  Map toMap() {
    Map<String, dynamic> contactMap = <String, dynamic>{
      DeletedContactsTable.ID: int.parse(id),
      DeletedContactsTable.NAME: name,
      DeletedContactsTable.PHONE: phone,
      DeletedContactsTable.EMAIL: email,
      DeletedContactsTable.ADDRESS: address,
      DeletedContactsTable.LATITUDE: latitude,
      DeletedContactsTable.LONGITUDE: longitude,
      DeletedContactsTable.CONTACT_IMAGE: contactImage,
    };

    return contactMap;
  }

  static DeletedContact fromMap(Map map) {
    return new DeletedContact(
      id: map[DeletedContactsTable.ID].toString(),
      name: map[DeletedContactsTable.NAME],
      phone: map[DeletedContactsTable.PHONE],
      email: map[DeletedContactsTable.EMAIL],
      address: map[DeletedContactsTable.ADDRESS],
      latitude: map[DeletedContactsTable.LATITUDE],
      longitude: map[DeletedContactsTable.LONGITUDE],
      contactImage: map[DeletedContactsTable.CONTACT_IMAGE],
    );
  }
}
