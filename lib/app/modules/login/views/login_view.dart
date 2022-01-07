import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rupuchat/app/controllers/auth_controller.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.7,
                  height: Get.width * 0.7,
                  child: Lottie.asset("assets/lottie/login.json"),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      authC.login();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Image.asset("assets/logo/google.png"),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Sign In With Google",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        primary: Colors.red[900],
                        padding: EdgeInsets.symmetric(vertical: 15)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
