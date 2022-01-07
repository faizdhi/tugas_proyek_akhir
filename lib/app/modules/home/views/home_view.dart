import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rupuchat/app/controllers/auth_controller.dart';
import 'package:rupuchat/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.SEARCH),
        child: Icon(Icons.search),
      ),
      body: Column(
        children: [
          Material(
            color: Colors.blue,
            elevation: 2,
            child: Container(
              margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black26))),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rupuchat",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.PROFILE),
                    child: Icon(
                      Icons.person,
                      size: 35,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.chatsStream(authC.user.value.email!),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.active) {
                  var listDocsChats = snapshot1.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: listDocsChats.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<
                          DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller
                            .friendStream(listDocsChats[index]["connection"]),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.active) {
                            var data = snapshot2.data!.data();
                            return data!["status"] == ""
                                ? ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    onTap: () => controller.goToChatRoom(
                                      "${listDocsChats[index].id}",
                                      authC.user.value.email!,
                                      listDocsChats[index]["connection"],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "${data["photoUrl"]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${data["name"]}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    trailing: listDocsChats[index]
                                                ["total_unread"] ==
                                            0
                                        ? SizedBox()
                                        : Chip(
                                            label: Text(
                                                "${listDocsChats[index]["total_unread"]}"),
                                          ),
                                  )
                                : ListTile(
                                    onTap: () => controller.goToChatRoom(
                                      "${listDocsChats[index].id}",
                                      authC.user.value.email!,
                                      listDocsChats[index]["connection"],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "${data["photoUrl"]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${data["name"]}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      "${data["status"]}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    trailing: listDocsChats[index]
                                                ["total_unread"] ==
                                            0
                                        ? SizedBox()
                                        : Chip(
                                            label: Text(
                                                "${listDocsChats[index]["total_unread"]}"),
                                          ),
                                  );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
