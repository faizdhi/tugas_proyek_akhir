import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rupuchat/app/controllers/auth_controller.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.emailC.text = authC.user.value.email!;
    controller.nameC.text = authC.user.value.name!;
    controller.statusC.text = authC.user.value.status!;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                authC.changeProfile(
                    controller.nameC.text, controller.statusC.text);
              },
              icon: Icon(Icons.save))
        ],
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Change Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            AvatarGlow(
              endRadius: 75,
              glowColor: Colors.black,
              duration: Duration(seconds: 2),
              child: Container(
                margin: EdgeInsets.all(15),
                width: 110,
                height: 110,
                child: authC.user.value.photoUrl! == "noimage"
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.asset(
                          "assets/logo/noimage.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.network(
                          authC.user.value.photoUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            TextField(
              controller: controller.emailC,
              readOnly: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.nameC,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              textInputAction: TextInputAction.done,
              controller: controller.statusC,
              decoration: InputDecoration(
                  labelText: "status",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("No Image"),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "pilih file",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
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
                      authC.changeProfile(
                          controller.nameC.text, controller.statusC.text);
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
