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

part 'log.g.dart';

@JsonSerializable()
class Log extends Object with _$LogSerializerMixin {
  String column_timestamp;
  String column_transaction;
  String column_date;

  Log({this.column_timestamp, this.column_transaction, this.column_date});

  static Future<List<Log>> fromLogsJson(List<dynamic> json) async {
    List<Log> logs = new List<Log>();
    for (var log in json) {
      logs.add(new Log(
        column_timestamp: log['column_timestamp'],
        column_transaction: log['column_transaction'],
        column_date: log['column_date'],
      ));
    }
    return logs;
  }

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);

  Map toMap() {
    Map<String, dynamic> contactMap = <String, dynamic>{
      LogsTable.COLUMN_TIMESTAMP: column_timestamp,
      LogsTable.COLUMN_DATE: column_date,
      LogsTable.COLUMN_TRANSACTION: column_transaction,
    };

    return contactMap;
  }

  static Log fromMap(Map map) {
    return new Log(
      column_timestamp: map[LogsTable.COLUMN_TIMESTAMP],
      column_date: map[LogsTable.COLUMN_DATE],
      column_transaction: map[LogsTable.COLUMN_TRANSACTION],
    );
  }
}
