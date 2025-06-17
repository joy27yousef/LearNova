import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/helpCenterController.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/TextFormGen.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    HelpCenterController controller = Get.put(HelpCenterController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              """We’re always happy to hear from you! Whether you have a question, need support, or simply want to share your feedback, our team is here and ready to help. """,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'First Name',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormGen(
              hint: 'First Name',
              lable: "Enter Your First Name",
              iconform: Icon(
                Icons.person_pin,
                color: Colors.grey.shade500,
              ),
              mycontroller: controller.first,
              typekey: TextInputType.text,
              valid: (val) {
                return validInput(val!, 5, 100, 'name');
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Last Name',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormGen(
              hint: 'Last Name',
              lable: "Enter Your Last Name",
              iconform: Icon(
                Icons.person_pin,
                color: Colors.grey.shade500,
              ),
              mycontroller: controller.last,
              typekey: TextInputType.text,
              valid: (val) {
                return validInput(val!, 5, 100, 'name');
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Email',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormGen(
              hint: 'Email',
              lable: "Enter Your Email",
              iconform: Icon(
                Icons.email_rounded,
                color: Colors.grey.shade500,
              ),
              mycontroller: controller.email,
              typekey: TextInputType.emailAddress,
              valid: (val) {
                return validInput(val!, 5, 100, 'email');
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Phone',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormGen(
              hint: 'Phone',
              lable: "Enter Your Phone",
              iconform: Icon(
                Icons.phone,
                color: Colors.grey.shade500,
              ),
              mycontroller: controller.number,
              typekey: TextInputType.number,
              valid: (val) {
                return validInput(val!, 5, 100, 'phone');
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Subject',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormGen(
              hint: 'Subject',
              lable: "Enter Your Subject",
              iconform: Icon(
                Icons.subject_rounded,
                color: Colors.grey.shade500,
              ),
              mycontroller: controller.subject,
              typekey: TextInputType.text,
              valid: (val) {
                return validInput(val!, 5, 100, 'name');
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Message',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormGen(
              hint: 'Message',
              lable: "Enter Your Message",
              iconform: Icon(
                Iconsax.message_2,
                color: Colors.grey.shade500,
              ),
              mycontroller: controller.message,
              typekey: TextInputType.text,
              valid: (val) {
                return validInput(val!, 5, 100, 'name');
              },
            ),
            SizedBox(
              height: 20,
            ),
            Boxtext(textin: "Send Your Message", onTapFun: () {}),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
