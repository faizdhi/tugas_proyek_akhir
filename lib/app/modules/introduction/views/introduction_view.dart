import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:rupuchat/app/routes/app_pages.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Berintraksi dengan mudah",
            body: "Kamu hanya perlu dirumah saja untuk mendapatkan teman baru",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(
                child: Lottie.asset("assets/lottie/main-laptop-duduk.json"),
              ),
            ),
          ),
          PageViewModel(
            title: "Temukan sahabat baru",
            body:
                "Jika kamu memang jodoh karena aplikasi ini, kami sangat bahagia",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(
                child: Lottie.asset("assets/lottie/ojek.json"),
              ),
            ),
          ),
          PageViewModel(
            title: "Aplikasi bebas biaya",
            body: "Kamu tidak perlu khawatir aplikasi ini gratis",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(
                child: Lottie.asset("assets/lottie/payment.json"),
              ),
            ),
          ),
          PageViewModel(
            title: "Daftar sekarang juga",
            body: "daftarkan diri untuk menjadi bagian dari kami!",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(
                child: Lottie.asset("assets/lottie/register.json"),
              ),
            ),
          )
        ],
        onDone: () => Get.offAllNamed(Routes.LOGIN),
        showSkipButton: true,
        skip: Text(
          "Skip",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        next: Text(
          "Next",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        done:
            const Text("LOGIN", style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
