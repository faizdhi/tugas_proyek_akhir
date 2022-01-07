import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rupuchat/app/controllers/auth_controller.dart';

import '../controllers/update_status_controller.dart';

class UpdateStatusView extends GetView<UpdateStatusController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.statusC.text = authC.user.value.status!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Update Status'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                authC.updateStatus(controller.statusC.text);
              },
              controller: controller.statusC,
              decoration: InputDecoration(
                  labelText: "apa yang kamu pikirkan hari ini...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: Get.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                    onPressed: () {
                      authC.updateStatus(controller.statusC.text);
                    },
                    child: Text(
                      "UPDATE",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
