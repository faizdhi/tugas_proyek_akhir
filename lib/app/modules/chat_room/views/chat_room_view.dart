import 'dart:io';
import 'dart:async';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rupuchat/app/controllers/auth_controller.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  final authC = Get.find<AuthController>();
  final String chat_id = (Get.arguments as Map<String, dynamic>)["chat_id"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(100),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.arrow_back),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: StreamBuilder<DocumentSnapshot<Object?>>(
                    stream: controller.streamFriendData(
                        (Get.arguments as Map<String, dynamic>)["friendEmail"]),
                    builder: (context, snapFriendUser) {
                      if (snapFriendUser.connectionState ==
                          ConnectionState.active) {
                        var dataFriend =
                            snapFriendUser.data!.data() as Map<String, dynamic>;

                        if (dataFriend["photoUrl"] == "noimage") {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/logo/noimage.png",
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              dataFriend["photoUrl"],
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/logo/noimage.png",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  radius: 25,
                )
              ],
            ),
          ),
          title: StreamBuilder<DocumentSnapshot<Object?>>(
            stream: controller.streamFriendData(
                (Get.arguments as Map<String, dynamic>)["friendEmail"]),
            builder: (context, snapFriendUser) {
              if (snapFriendUser.connectionState == ConnectionState.active) {
                var dataFriend =
                    snapFriendUser.data!.data() as Map<String, dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataFriend["name"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      dataFriend["status"],
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
          ),
          centerTitle: false,
        ),
        body: WillPopScope(
          onWillPop: () {
            if (controller.isShowEmoji.isTrue) {
              controller.isShowEmoji.value = false;
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.streamChats(chat_id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var alldata = snapshot.data!.docs;
                        Timer(
                          Duration.zero,
                          () => controller.scrollC.jumpTo(
                              controller.scrollC.position.maxScrollExtent),
                        );
                        return ListView.builder(
                          controller: controller.scrollC,
                          itemCount: alldata.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    "${alldata[index]["groupTime"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  itemChat(
                                    msg: "${alldata[index]["msg"]}",
                                    isSender: alldata[index]["pengirim"] ==
                                            authC.user.value.email!
                                        ? true
                                        : false,
                                    time: "${alldata[index]["time"]}",
                                  ),
                                ],
                              );
                            } else {
                              if (alldata[index]["groupTime"] ==
                                  alldata[index - 1]["groupTime"]) {
                                return itemChat(
                                  msg: "${alldata[index]["msg"]}",
                                  isSender: alldata[index]["pengirim"] ==
                                          authC.user.value.email!
                                      ? true
                                      : false,
                                  time: "${alldata[index]["time"]}",
                                );
                              } else {
                                return Column(
                                  children: [
                                    Text(
                                      "${alldata[index]["groupTime"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    itemChat(
                                      msg: "${alldata[index]["msg"]}",
                                      isSender: alldata[index]["pengirim"] ==
                                              authC.user.value.email!
                                          ? true
                                          : false,
                                      time: "${alldata[index]["time"]}",
                                    ),
                                  ],
                                );
                              }
                            }
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
                          autocorrect: false,
                          controller: controller.chatC,
                          focusNode: controller.focusNode,
                          onEditingComplete: () => controller.newChat(
                            authC.user.value.email!,
                            Get.arguments as Map<String, dynamic>,
                            controller.chatC.text,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Icon(Icons.emoji_emotions_outlined),
                              onPressed: () {
                                controller.focusNode.unfocus();
                                controller.isShowEmoji.toggle();
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(80)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue,
                      child: InkWell(
                        onTap: () => controller.newChat(
                          authC.user.value.email!,
                          Get.arguments as Map<String, dynamic>,
                          controller.chatC.text,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(13),
                          child: Icon(Icons.send),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => controller.isShowEmoji.isTrue
                  ? Container(
                      height: 250,
                      child: EmojiPicker(
                        onEmojiSelected: (category, emoji) {
                          controller.addEmojiToChat(emoji);
                        },
                        onBackspacePressed: () {
                          controller.deleteEmoji();
                        },
                        config: Config(
                            columns: 7,
                            emojiSizeMax: 32 *
                                (Platform.isIOS
                                    ? 1.30
                                    : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                            verticalSpacing: 0,
                            horizontalSpacing: 0,
                            initCategory: Category.RECENT,
                            bgColor: Color(0xFFF2F2F2),
                            indicatorColor: Colors.blue,
                            iconColor: Colors.grey,
                            iconColorSelected: Colors.blue,
                            progressIndicatorColor: Colors.blue,
                            showRecentsTab: true,
                            recentsLimit: 28,
                            noRecentsText: "No Recents",
                            noRecentsStyle: const TextStyle(
                                fontSize: 20, color: Colors.black26),
                            tabIndicatorAnimDuration: kTabScrollDuration,
                            categoryIcons: const CategoryIcons(),
                            buttonMode: ButtonMode.MATERIAL),
                      ),
                    )
                  : SizedBox())
            ],
          ),
        ));
  }
}

class itemChat extends StatelessWidget {
  const itemChat({
    Key? key,
    required this.isSender,
    required this.msg,
    required this.time,
  }) : super(key: key);
  final bool isSender;
  final String msg;
  final time;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: isSender
                      ? BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))
                      : BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
              padding: EdgeInsets.all(12),
              child: Text(
                "$msg",
                style: TextStyle(color: Colors.white),
              )),
          SizedBox(
            height: 3,
          ),
          Text(DateFormat.jm().format(DateTime.parse(time))),
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
