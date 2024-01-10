
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/model/model.dart';

class getxstudentcontroller extends GetxController{

 final todobox=Hive.box<studentmodel>('schoolbox');
 var selectedimagepath =''.obs;  

  void getimage(ImageSource imageSource)async{
    final picimage =ImagePicker();
final pickedFile=await picimage.pickImage(source: imageSource);
if(pickedFile!=null){
selectedimagepath.value=pickedFile.path;
}
  
  } 

addstudent(
  String name,
  String rollnumber,
  String age,
  String phone,
  String email,
  Uint8List image,
) {
  studentmodel student = studentmodel(
    name: name,
    rollnumber: rollnumber,
    age: age,
    phone: phone,
    email: email,
    image: image,
  );
  todobox.add(student);
}

  deletestudent(int index)async{
    await todobox.deleteAt(index);
    
  }
updatestudent(int index, String name, String rollnumber, String age, String phone, String email, Uint8List image) {
  if (name.isNotEmpty && rollnumber.isNotEmpty && age.isNotEmpty && phone.isNotEmpty && email.isNotEmpty) {
    studentmodel updatedStudent = studentmodel(
      name: name,
      rollnumber: rollnumber,
      age: age,
      phone: phone,
      email: email,
      image: image,
    );
    todobox.putAt(index, updatedStudent);
    
  }
}
}