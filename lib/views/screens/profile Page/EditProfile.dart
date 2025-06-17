import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/EditprofileController.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/TextFormGen.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class EditProfile extends StatelessWidget {
  EditprofileControllerIMP controller = Get.put(EditprofileControllerIMP());
  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Edit Profile',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Center(
                child: controller.buildProfileImage(),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormGen(
                hint: 'Name',
                lable: 'Full Name',
                iconform:
                    Icon(Icons.person_2_rounded, color: Colors.grey.shade400),
                mycontroller: controller.name,
                typekey: TextInputType.text,
                valid: (val) {
                  return validInput(val!, 5, 100, 'email');
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormGen(
                hint: 'Email',
                lable: 'Email',
                iconform: Icon(Icons.email, color: Colors.grey.shade400),
                mycontroller: controller.Email,
                typekey: TextInputType.text,
                valid: (val) {
                  return validInput(val!, 5, 100, 'email');
                },
              ),
              SizedBox(
                height: 40,
              ),
              Boxtext(textin: "Update", onTapFun: () {})
            ],
          ),
        ));
  }
}
