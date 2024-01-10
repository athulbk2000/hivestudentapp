import 'package:flutter/material.dart';

class coustomtext extends StatelessWidget {
  final TextEditingController controller;
  final String name;

   const coustomtext({
    Key ? key,
    required this.name, required this.controller,}):super(key: key);
   

  @override
  Widget build(BuildContext context) {
  
    return TextField(
  controller: controller,
  decoration: InputDecoration(
    labelText: name,
    hintText: name,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    )
  ),

    );
  }
}
