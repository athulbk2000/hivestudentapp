import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student/controller/controller.dart';
import 'package:student/model/model.dart';
import 'package:student/view/adduser.dart';
import 'package:student/view/update.dart';

class Studenthomepage extends StatefulWidget {
  const Studenthomepage({super.key});

  @override
  State<Studenthomepage> createState() => _StudenthomepageState();
}

class _StudenthomepageState extends State<Studenthomepage> {
  final todobox = Hive.box<studentmodel>("schoolbox");
  final controller = Get.put(getxstudentcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ... Your existing AppBar code
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ValueListenableBuilder(
          valueListenable: todobox.listenable(),
          builder: (context, Box<studentmodel> todobox, child) {
            if (todobox.isEmpty) {
              return Center(child: Text("no data"));
            }
            return StreamBuilder(
              stream: todobox.watch(),
              builder: (context, snapshot) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: todobox.length,
                  itemBuilder: (context, index) {
                    studentmodel newbox = todobox.getAt(index) as studentmodel;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateUser(
                              index: index,
                              name: newbox.name,
                              rollnumber: newbox.rollnumber,
                              age: newbox.age,
                              phone: newbox.phone,
                              email: newbox.email,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: SizedBox(
                          height: 100,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: MemoryImage(newbox.image),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('name:${newbox.name}'),
                                Text('rollnumber:${newbox.rollnumber}'),
                                Text('age:${newbox.age}'),
                                Text('phone:${newbox.phone}'),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                controller.deletestudent(index);
                              },
                              icon: Icon(Icons.delete),
                            
                          ),
                        ),
                      ),
                    ));
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(adduser());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
