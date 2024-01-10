import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/controller/controller.dart';
import 'package:student/model/model.dart';
import 'package:student/model/text.dart';
import 'package:student/view/homepage.dart';

class adduser extends StatefulWidget {
  const adduser({super.key});

  @override
  State<adduser> createState() => _adduserState();
}

class _adduserState extends State<adduser> {
  final namecontroller = TextEditingController();
  final rollnumbercontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final clscontroller = TextEditingController();
  Box todbox = Hive.box<studentmodel>("schoolbox");
  final controller = Get.put(getxstudentcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add user"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Obx(() => controller.selectedimagepath.value.isEmpty?   Icon(
                        Icons.add_a_photo,
                        size: 60,
                      ): CircleAvatar(radius: 60,backgroundImage: FileImage(File(controller.selectedimagepath.value)),)),
              SizedBox(
                height: 30,
              ),
              coustomtext(name: "name", controller: namecontroller),
              SizedBox(
                height: 10,
              ),
              coustomtext(name: "rollnumber", controller: rollnumbercontroller),
              SizedBox(
                height: 10,
              ),
              coustomtext(name: "age", controller: agecontroller),
              SizedBox(
                height: 10,
              ),
              coustomtext(name: "phone", controller: phonecontroller),
              SizedBox(
                height: 10,
              ),
              coustomtext(name: "email", controller: emailcontroller),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: ()async{
               controller.getimage(ImageSource.camera);
              }, child: Text('add image')),
              ElevatedButton(
  onPressed: () async {
    if (namecontroller.text.isEmpty ||
        rollnumbercontroller.text.isEmpty ||
        agecontroller.text.isEmpty ||
        phonecontroller.text.isEmpty ||
        emailcontroller.text.isEmpty ||
        controller.selectedimagepath.value.isEmpty) {
      // Show a dialog indicating that all fields are required
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Incomplete Details"),
            content: Text("Please fill in all details and add an image."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      // Proceed with saving student details
      String filePath = controller.selectedimagepath.value;
      Uint8List imageBytes = await File(filePath).readAsBytes();
      controller.addstudent(
        namecontroller.text,
        rollnumbercontroller.text,
        agecontroller.text,
        phonecontroller.text,
        emailcontroller.text,
        imageBytes,
      );
      Get.to(Studenthomepage());
    }
  },
  child: Text("Save"),
)
  
            ],
          ),
        ),
      ),
    );
  }

 
}
 