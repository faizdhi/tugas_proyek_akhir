import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rupuchat/app/controllers/auth_controller.dart';
import 'package:rupuchat/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                authC.logout();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.all(15),
                    width: 165,
                    height: 165,
                    child: Obx(
                      () => authC.user.value.photoUrl! == "noimage"
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
                    )),
                Obx(
                  () => Text(
                    "${authC.user.value.name!}",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "${authC.user.value.email!}",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () => Get.toNamed(Routes.UPDATE_STATUS),
                    leading: Icon(Icons.note_add_outlined),
                    title: Text(
                      "Update Status",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_right),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(Routes.CHANGE_PROFILE),
                    leading: Icon(Icons.person),
                    title: Text(
                      "Change Profile",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_right),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.color_lens),
                    title: Text(
                      "Change Theme",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    trailing: Text(
                      "Light",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(bottom: context.mediaQueryPadding.bottom + 10),
            child: Column(
              children: [
                Text(
                  "Rupuchat",
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  "v.1.0",
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
