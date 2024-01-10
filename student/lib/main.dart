import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student/model/model.dart';
import 'package:student/view/homepage.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory=await getApplicationCacheDirectory();
  Hive.init(directory.path);
Hive.registerAdapter(studentmodelAdapter());
  await Hive.openBox<studentmodel>("schoolbox");
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home:Studenthomepage() ,

  ));
}