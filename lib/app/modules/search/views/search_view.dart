import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rupuchat/app/controllers/auth_controller.dart';
import 'package:rupuchat/app/routes/app_pages.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextField(
                    controller: controller.searchC,
                    onChanged: (value) {
                      controller.searchFriend(value, authC.user.value.email!);
                      print(authC.user.value.email!);
                    },
                    decoration: InputDecoration(
                        suffixIcon:
                            InkWell(onTap: () {}, child: Icon(Icons.search)),
                        hintText: "SEARCH....",
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                ),
              ),
              title: Text('Search'),
              centerTitle: true,
            ),
            preferredSize: Size.fromHeight(120)),
        body: Obx(
          () => Center(
            child: controller.tempSearch.length == 0
                ? Center(
                    child: Container(
                      width: Get.width * 0.6,
                      height: Get.width * 0.6,
                      child: Lottie.asset("assets/lottie/empty.json"),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.tempSearch.length,
                    itemBuilder: (context, index) => ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          onTap: () {
                            authC.addNewConnection(
                                controller.tempSearch[index]["email"]);
                          },
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black26,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                "${controller.tempSearch[index]["photoUrl"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            "${controller.tempSearch[index]["name"]}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "${controller.tempSearch[index]["email"]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          trailing: Chip(label: Text("Message")),
                        )),
          ),
        ));
  }
}
