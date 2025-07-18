import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:learn_nova/controller/myCourses/ratingController.dart';

class ActionRatingAppBar extends StatelessWidget {
  const ActionRatingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingController>(
      builder: (controller) {
        return controller.userRating.isNotEmpty
            ? PopupMenuButton<int>(
                onSelected: (value) {
                  if (value == 0) {
                    controller.userRating.clear();
                    controller.update();
                  } else if (value == 1) {
                    controller.deleteUserRating();
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
                      children: const [
                        Icon(Icons.mode_edit_outline_rounded, size: 30),
                        SizedBox(width: 10),
                        Text("Evaluation adjustment"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(Icons.delete_rounded, color: Colors.red, size: 30),
                        SizedBox(width: 10),
                        Text("Delete the rating"),
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
