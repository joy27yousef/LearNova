import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/controller/alAssistantController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/views/widgets/auth/textformAuth.dart';

class AiAssistantPage extends StatelessWidget {
  const AiAssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final bool isDark = storage.read('isDarkMode') ?? false; // ✅ حل مشكلة null
    AiAssistantController controller = Get.put(AiAssistantController());

    return Form(
      key: controller.formstate,
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.6,
        expand: false,
        builder: (_, scrollController) {
          return SafeArea(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 150),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: isDark
                        ? AssetImage(Appimages.backgrounddark)
                        : AssetImage(Appimages.background),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: GetBuilder<AiAssistantController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        Text(
                          "LearNova Assistant",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),

                        // الرسائل
                        Expanded(
                          child: ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.messages.length +
                                (controller.isTyping ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (controller.isTyping &&
                                  index == controller.messages.length) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? Colors.grey[700]
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text("typing..."),
                                  ),
                                );
                              }

                              final msg = controller.messages[index];
                              return Align(
                                alignment: msg.isUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? (msg.isUser
                                            ? Appcolor.base
                                            : Colors.grey[700])
                                        : (msg.isUser
                                            ? Appcolor.baselight
                                            : Colors.grey[200]),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    msg.isUser ? msg.question : msg.answer,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 10),

                        // حقل الإدخال
                        TextformAuth(
                          hint: '',
                          lable: 'Send Message',
                          iconform: Icon(
                            Icons.send,
                            color: Appcolor.baselight3,
                          ),
                          mycontroller: controller.messageSend,
                          typekey: TextInputType.text,
                          valid: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a message';
                            }
                            return null;
                          },
                          onTapicon: () async {
                            if (controller.messageSend.text.trim().isEmpty) {
                              return;
                            }
                            controller.isTyping = true;
                            controller.update();
                            await controller.sendMessage();
                            controller.isTyping = false;
                            controller.update();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
