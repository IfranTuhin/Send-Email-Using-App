//
// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:send_email_using_flutter/service/email_service.dart';
// import 'package:http/http.dart' as http;
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   // Controller
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController messageController = TextEditingController();
//
//   // Id
//   final String serviceId = service_id;
//   final String templateId = template_id;
//   final String userId = user_id;
//
//   // Send Email Function
//   Future<void> sendEmail() async {
//     // Url
//     final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
//     // Headers
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//     };
//
//     try {
//       var response = await http.post(
//           url, headers: headers,
//           body: jsonEncode({
//             'service_id': serviceId,
//             'template_id': templateId,
//             'user_id': user_id,
//             'template_params' : {
//               'user_name': nameController.text,
//               'user_email': emailController.text,
//               'user_message': messageController.text,
//             },
//           }),
//       );
//       log('Email Send Status Code : ${response.statusCode} -- Email Send Response : ${response.body}');
//       if(response.statusCode == 200) {
//         Fluttertoast.showToast(
//             msg: "Email Send Successfully",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 3,
//             backgroundColor: Colors.green,
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//         emailController.clear();
//         nameController.clear();
//         messageController.clear();
//       } else {
//         Fluttertoast.showToast(
//             msg: "Failed to Send Email",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 3,
//             backgroundColor: Colors.green,
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//         log('Failed to Send Email : ${response.body}');
//       }
//     }catch (e) {
//       log('Email Send Error : ${e.toString()}');
//       throw Text(e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Send Email Using App', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
//       ),
//       body: SafeArea(child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//
//                 const Text('Send Email Using App', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
//                 const SizedBox(height: 20),
//
//                 TextField(
//                   controller: nameController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Name',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//
//                 TextField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Email',
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(height: 10),
//
//                 TextField(
//                   controller: messageController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Message',
//                   ),
//                   maxLines: 5,
//                 ),
//                 const SizedBox(height: 50),
//
//                 GestureDetector(
//                   onTap: () async{
//                    await sendEmail();
//                   },
//                   child: Container(
//                     height: 50,
//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: Colors.deepPurple,
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                     child: const Text('Submit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }



import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:send_email_using_flutter/service/email_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();



  // Send Email Function
  Future<void> sendEmail() async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'service_id': service_id,
          'template_id': template_id,
          'user_id': user_id,
          'template_params': {
            'user_name': nameController.text,
            'user_email': emailController.text,
            'user_message': messageController.text,
          },
        }),
      );

      log('Email Send Status Code: ${response.statusCode} -- Email Send Response: ${response.body}');

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Email Sent Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        emailController.clear();
        nameController.clear();
        messageController.clear();
      } else {
        Fluttertoast.showToast(
          msg: "Failed to Send Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        log('Failed to Send Email: ${response.body}');
      }
    } catch (e) {
      log('Email Send Error: $e');
      Fluttertoast.showToast(
        msg: "Error Sending Email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Email Using App', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Send Email Using App', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),

                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Message',
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 50),

                  GestureDetector(
                    onTap: () async {
                      await sendEmail();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Text('Submit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
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
