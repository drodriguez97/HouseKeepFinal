
import 'package:flutter/material.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class WorkOrderForm extends StatelessWidget {
final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final roomController = TextEditingController();
  final buildingController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: const Color(0xfff5f5fd),
      body: Center(
        child: Container(
          height: 800,
          width: 800,
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 1,
                    color: Colors.grey[300]!)
              ]),
          child: Form(  
            key: _formKey,
child: SingleChildScrollView(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Work Order Form',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10.0,),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name',
                  focusedBorder: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                 const SizedBox(height: 6.0,),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email',
                  focusedBorder: OutlineInputBorder(), 
                  ),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Required*';
                    } else if (!EmailValidator.validate(email)) {
                      return 'Please enter a valid Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 6.0,),
                TextFormField(
                  controller: buildingController,
                  decoration: const InputDecoration(hintText: 'Building #',
                  focusedBorder: OutlineInputBorder(), 
                  ),
                  validator: (building) {
                    if (building == null || building.isEmpty) {
                      return 'Required*';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 6.0,),
                TextFormField(
                  controller: roomController,
                  decoration: const InputDecoration(hintText: 'Room #',
                  focusedBorder: OutlineInputBorder(), ),
                  validator: (room) {
                    if (room == null || room.isEmpty) {
                      return 'Required*';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0,),
                TextFormField(
                  controller: messageController,
                  maxLines: (5),
                  decoration: const InputDecoration(hintText: 'Message',
                  focusedBorder: OutlineInputBorder(),
                   contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 45,
                  width: 110,     
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color.fromARGB(255, 252, 19, 19),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                  onPressed: () async{       
                      if (_formKey.currentState!.validate()) {
                        final response = await sendEmail(
                            nameController.value.text,
                            emailController.value.text,
                            roomController.value.text,
                            buildingController.value.text,
                            messageController.value.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          response == 200
                              ? const SnackBar(
                                  content: Text('Message Sent!'),
                                  backgroundColor: Colors.green)
                              : const SnackBar(
                                  content: Text('Failed to send message!'),
                                  backgroundColor: Colors.red),
                        );
                     nameController.clear();
                      emailController.clear();
                      roomController.clear();
                      buildingController.clear();
                      messageController.clear();
                      }
                    },
                    child: const Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
          ),
        ),
      ),
    );

  }
}

Future sendEmail(String name,String room, String building, String email, String message) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_xpjj41e';
  const templateId = 'template_vkvjy1l';
  const userId = 'Yb6xcGXbkQlZpHTl3';


  final response = await http.post(url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json'},//This line makes sure it works for all platforms.
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'from_name': name,
          'from_email': email,
          "room": room,
          'building': building,
          'message': message
        }
      }),
  );
  return response.statusCode;
}