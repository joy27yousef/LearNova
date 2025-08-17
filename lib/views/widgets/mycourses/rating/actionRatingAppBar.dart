import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/myCourses/ratingController.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/confirmationAlert.dart';

class ActionRatingAppBar extends StatelessWidget {
  const ActionRatingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // هنا ما نعمل put، فقط نجيب الكنترولر الموجود
    return GetBuilder<RatingController>(
      builder: (controller) {
        return controller.userRating.isNotEmpty
            ? PopupMenuButton<int>(
                onSelected: (value) {
                  if (value == 0) {
                    Get.toNamed(AppRoutes.editRatingPage);
                  } else if (value == 1) {
                    confirmationAelrt(
                        Appimages.delete,
                        'Are you sure you want to delete your rating ??',
                        'No, keep it',
                        'Yes, delete',
                        Colors.red, () {
                      controller.deleteUserRating();
                    });
                  }
                },
                icon: const Icon(Icons.more_vert),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Theme.of(context).colorScheme.background,
                elevation: 8,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(Iconsax.edit),
                        SizedBox(width: 10),
                        Text(
                          "Edit Rating",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 17, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Iconsax.trash),
                        SizedBox(width: 10),
                        Text(
                          "Delete Rating",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 17, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
