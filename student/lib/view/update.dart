import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:student/controller/controller.dart';
import 'package:student/model/model.dart';
import 'package:student/model/text.dart';

class UpdateUser extends StatefulWidget {
  final String name;
  final String rollnumber;
  final String age;
  final String phone;
  final String email;
  final int index;
  final Uint8List? image;

  const UpdateUser({
    required this.index,
    required this.name,
    required this.rollnumber,
    required this.age,
    required this.phone,
    required this.email,
    this.image,
  });

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final rollNumberController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  late Box<studentmodel> todoBox;
  late getxstudentcontroller controller;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<studentmodel>("schoolbox");
    controller = Get.put(getxstudentcontroller());
    updateTextControllers(); // Set initial values
  }

  void updateTextControllers() {
    nameController.text = widget.name;
    ageController.text = widget.age;
    rollNumberController.text = widget.rollnumber;
    phoneController.text = widget.phone;
    emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update page"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              coustomtext(name: "name", controller: nameController),
              SizedBox(height: 10),
              coustomtext(name: "rollnumber", controller: rollNumberController),
              SizedBox(height: 10),
              coustomtext(name: "age", controller: ageController),
              SizedBox(height: 10),
              coustomtext(name: "phone", controller: phoneController),
              SizedBox(height: 10),
              coustomtext(name: "email", controller: emailController),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final rollNumber = rollNumberController.text;
                  final age = ageController.text;
                  final phone = phoneController.text;
                  final email = emailController.text;
                  final image = widget.image;

                  Navigator.pop(context);

                  if (image != null) {
                    studentmodel updatedStudent = studentmodel(
                      name: name,
                      rollnumber: rollNumber,
                      age: age,
                      phone: phone,
                      email: email,
                      image: image,
                    );

                    controller.updatestudent(
                      widget.index,
                      name,
                      rollNumber,
                      age,
                      phone,
                      email,
                      image,
                    );
                    todoBox.put((context), updatedStudent);
                  }
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
