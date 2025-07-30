import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/data/model/AiChat.dart';
import 'package:learn_nova/data/source/remote/aiAdssistant.dart';

class AiAssistantController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late Statusrequest statusrequest;
  late ScrollController scrollController;

  bool isTyping = false;
  late TextEditingController messageSend;
  List<AiChatModel> messages = [];
  var aiAssistant = AiAssistantData();

  @override
  void onInit() {
    messageSend = TextEditingController();
    scrollController = ScrollController();
    super.onInit();
  }

  sendMessage() async {
    if (formstate.currentState!.validate()) {
      isTyping = true;
      update();
      messages.add(
        AiChatModel(
          question: messageSend.text,
          answer: '',
          timestamp: DateTime.now(),
          isUser: true,
        ),
      );
      update();

      var response = await aiAssistant.getData(messageSend.text);

      messageSend.clear();
      if (response.containsKey("data")) {
        final aiReply = response["data"];
        messages.add(
          AiChatModel(
            question: '',
            answer: aiReply.toString(),
            timestamp: DateTime.now(),
            isUser: false,
          ),
        );
        messageSend.clear();
      } else if (response.containsKey("error")) {
        showCustomSnackbar(
          title: 'Connection failure',
          message: 'Try again!',
          icon: Icons.error,
          backgroundColor: Colors.red,
        );
      }

      isTyping = false;
      update();
      await Future.delayed(
          Duration(milliseconds: 100)); // تأخير بسيط للسماح بالرسم
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      print('Not valid');
    }
  }

  @override
  void onClose() {
    messageSend.dispose();
    super.onClose();
  }
}
