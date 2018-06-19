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

  factory DeletedContact.fromJson(Map<String, dynamic> json) =>
      _$DeletedContactFromJson(json);
}
