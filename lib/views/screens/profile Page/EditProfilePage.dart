import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/profile/EditprofileController.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/function/confirmationAlert.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/TextFormGen.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class EditProfilePage extends StatelessWidget {
  EditprofileControllerIMP controller = Get.put(EditprofileControllerIMP());
  EditProfilePage({super.key});

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
        centerTitle: true,
      ),
      body: Form(
        key: controller.formstate,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Center(
                child: controller.buildProfileImage(),
              ),
              const SizedBox(height: 30),

              // First Name
              TextFormGen(
                hint: 'First Name',
                lable: 'First Name',
                iconform: Icon(Icons.person, color: Colors.grey.shade400),
                mycontroller: controller.firstname,
                typekey: TextInputType.text,
                valid: (val) {
                  if (val == null || val.isEmpty) return null;
                  return validInput(val, 2, 100, 'name');
                },
              ),
              const SizedBox(height: 20),

              // Last Name
              TextFormGen(
                hint: 'Last Name',
                lable: 'Last Name',
                iconform: Icon(Icons.person, color: Colors.grey.shade400),
                mycontroller: controller.lastname,
                typekey: TextInputType.text,
                valid: (val) {
                  if (val == null || val.isEmpty) return null;
                  return validInput(val, 2, 100, 'name');
                },
              ),
              const SizedBox(height: 20),

              // Phone
              TextFormGen(
                hint: 'Phone Number',
                lable: 'Phone',
                iconform: Icon(Icons.phone, color: Colors.grey.shade400),
                mycontroller: controller.phone,
                typekey: TextInputType.number,
                valid: (val) {
                  if (val == null || val.isEmpty) return null;
                  return validInput(val, 2, 100, 'phone');
                },
              ),
              const SizedBox(height: 20),

              // Country
              TextFormGen(
                hint: 'Country',
                lable: 'Country',
                iconform: Icon(Icons.location_on, color: Colors.grey.shade400),
                mycontroller: controller.country,
                typekey: TextInputType.text,
                valid: (val) {
                  if (val == null || val.isEmpty) return null;
                  return validInput(val, 2, 100, 'name');
                },
              ),
              const SizedBox(height: 20),

              // Specialization
              TextFormGen(
                hint: 'Specialization',
                lable: 'Specialization',
                iconform: Icon(Icons.work, color: Colors.grey.shade400),
                mycontroller: controller.specialization,
                typekey: TextInputType.text,
                // valid: (val) {
                //   if (val == null || val.isEmpty) return null;
                //   return validInput(val, 2, 100, 'name');
                // },
                valid: (val) {
                  if (val == null || val.isEmpty) {
                    return 'This field cannot be empty'; // رسالة لمنع الفراغ
                  }
                  return validInput(val, 2, 100, 'name');
                },
              ),
              const SizedBox(height: 20),

              // Bio
              TextFormGen(
                hint: 'Bio',
                lable: 'Bio',
                iconform: Icon(Icons.info_outline, color: Colors.grey.shade400),
                mycontroller: controller.bio,
                typekey: TextInputType.multiline,
                valid: (val) {
                  if (val == null || val.isEmpty) return null;
                  return validInput(val, 2, 1000, 'name');
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
        child: Boxtext(
          textin: "Update",
          onTapFun: () {
            confirmationAelrt(
         
                Appimages.editProfile,
                'Do you really want to edit your data??',
                'No, leave it',
                'Yes, edit it',
                Colors.blueAccent, () {
              controller.editProfile();
            });
          },
        ),
      ),
    );
  }
}
