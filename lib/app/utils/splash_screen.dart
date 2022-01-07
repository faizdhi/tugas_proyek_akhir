import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rupuchat",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                width: Get.width * 0.6,
                height: Get.width * 0.6,
                child: Lottie.asset("assets/lottie/hello.json"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
