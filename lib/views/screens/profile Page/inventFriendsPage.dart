import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class InviteFriendsPage extends StatelessWidget {
  final String inviteLink = "https://learnovaeducation.netlify.app";

  void shareLink() {
    Share.share(inviteLink);
  }

  void copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: inviteLink));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            "link copied to clipboard",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Your Friends"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Theme.of(context).colorScheme.background,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/app_icon.png',
                    width: 130,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Share Invite Via',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 15),
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: shareLink,
              child: Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blueAccent,
                    ),
                    Icon(
                      FontAwesomeIcons.facebookMessenger,
                      color: Colors.blueAccent,
                    ),
                    Icon(
                      FontAwesomeIcons.instagram,
                      color: Colors.pinkAccent,
                    ),
                    Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                    ),
                    Icon(
                      FontAwesomeIcons.telegram,
                      color: Colors.blueAccent,
                    ),
                    Icon(
                      FontAwesomeIcons.sms,
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'copy link',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 15),
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: () => copyLink(context),
              child: Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        inviteLink,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
