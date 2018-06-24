// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) => new Log(
    column_timestamp: json['column_timestamp'] as String,
    column_transaction: json['column_transaction'] as String,
    column_date: json['column_date'] as String);

abstract class _$LogSerializerMixin {
  String get column_timestamp;

  String get column_transaction;

  String get column_date;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'column_timestamp': column_timestamp,
        'column_transaction': column_transaction,
        'column_date': column_date
      };
}
