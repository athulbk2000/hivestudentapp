import 'dart:typed_data';

import 'package:hive_flutter/adapters.dart';

part 'model.g.dart';
@HiveType(typeId: 1)
class studentmodel{
  @HiveField(0)
  String name;
  @HiveField(1)
  String rollnumber;
  @HiveField(2)
  String age;
  @HiveField(3)
  String phone;
  @HiveField(4)
  String email;
  @HiveField(5)
  Uint8List image;
  studentmodel({
    required this.name,required this.rollnumber,required this.age,required this.phone,required this.email,
    required this.image
  });
}