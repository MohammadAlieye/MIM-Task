import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/features/home/text/controllers/text_controller.dart';
import 'package:task/features/home/text/models/text_model.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/services/firebase/database/firestore_service.dart';
import '../../../../core/utils/widgets/textfields.dart';

class TextView extends StatelessWidget {
  const TextView({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = Get.put(TextController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(Collection.messages.name)
                    .where("createdBy",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.size == 0) {
                    return Center(
                      child: SvgPicture.asset(
                        AppAssets.kmessage,
                        width: 300,
                      ),
                    );
                  }
                  final List<TextModel> messages = snapshot.data!.docs
                      .map((doc) => TextModel.fromMap(doc.data()))
                      .toList();

                  return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.kBlue,
                          ),
                          child: ListTile(
                            title: Text(
                              messages[index].message,
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: AppColor.white,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(messages[index].createdAt.toDate()),
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
          ChatTextField(
            messageController: textController.text,
            sendIcon: textController.sendMessage,
          ),
        ],
      ),
    );
  }
}
