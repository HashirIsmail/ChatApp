import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController chatController = TextEditingController();

  toast(String title) {
    return showToast(
      title,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    var getData;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      getData = await json.decode(prefs.getString("UserDetails") ?? "");
    });

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFa58cc6),
          flexibleSpace: SafeArea(
              child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage("chat.jpg"),
                      maxRadius: 20,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Group Chat",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Online",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ])))),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Chats')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              // .orderBy('createdAt', descending: true)
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      // print(doc['Email'].runtimeType);
                      // print(doc['Email']);
                      // print(getData['email']);

                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          // alignment: Alignment.topLeft,
                          alignment: (getData == doc['Email']
                              ? Alignment.topRight
                              : Alignment.topLeft),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomLeft: getData == doc['Email']
                                    ? Radius.circular(20)
                                    : Radius.circular(0),
                                bottomRight: getData == doc['Email']
                                    ? Radius.circular(0)
                                    : Radius.circular(20),
                              ),
                              color: (getData == doc['Email']
                                  ? Color.fromRGBO(51, 61, 86, 1)
                                  : Color.fromARGB(255, 202, 202, 202)),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc['Email'],
                                  style: GoogleFonts.alike(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                      color: (getData == doc['Email']
                                          ? Colors.white
                                          : Colors.black),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    doc['chat'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: (getData == doc['Email']
                                            ? Colors.white
                                            : Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("No Messages"));
                }
              },
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // height: 50,
              margin: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xFF333D56),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 12.0),
                    child: Transform.rotate(
                        angle: 45,
                        child: const Icon(
                          Icons.attach_file_sharp,
                          color: Colors.white,
                        )),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: chatController,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 6,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 11.0),
                    child: Transform.rotate(
                      angle: -3.14 / 5,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: GestureDetector(
                          onTap: () async {
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // var getData = await json
                            //     .decode(prefs.getString("UserDetails") ?? "");
                            // // print("getData");
                            print("getData");
                            print(getData);
                            print("getData");
                            if (chatController.text != "") {
                              chat(getData, chatController.text);
                              chatController.clear();
                            }
                          },
                          onLongPress: () {
                            setState(() {
                              // messageList.add(
                              //     MessageData(textEditingController.text, false));
                              // textEditingController.clear();
                              // scrollAnimation();
                            });
                          },
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future chat(String email, String message) async {
    try {
      final chat = FirebaseFirestore.instance.collection('Chats');
      final data = {
        'Email': email,
        'chat': message,
        'createdAt': DateTime.now().toUtc(),
      };
      await chat.add(data);
      // message = 'Successfully created Event';
      toast("Sent");
    } catch (e) {
      toast(e.toString());
    }
  }
}
