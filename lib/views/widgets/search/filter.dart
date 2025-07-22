import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/SearchController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';

class FilterTab extends StatelessWidget {
  const FilterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchCourseController>(
      builder: (controller) {
        final categories = controller.getCategories();
        final levels = controller.getLevels();
        final durations = controller.getDurations();

        InputDecoration buildDecoration(String label) {
          return InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 250, 249, 255),
            label: Container(
              margin: EdgeInsets.all(10),
              child: Text(
                label,
                style: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Appcolor.baselight, width: 2),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Appcolor.base, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Appcolor.base, width: 2),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              decoration: buildDecoration('Category'),
              value: controller.selectedCategory,
              items: categories.map((cat) {
                return DropdownMenuItem(
                  child: Text(cat ?? 'All'),
                  value: cat,
                );
              }).toList(),
              onChanged: controller.updateCategory,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              decoration: buildDecoration('Level'),
              value: controller.selectedLevel,
              items: levels.map((level) {
                return DropdownMenuItem(
                  child: Text(level ?? 'All'),
                  value: level,
                );
              }).toList(),
              onChanged: controller.updateLevel,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              decoration: buildDecoration('Duration'),
              value: controller.selectedDuration,
              items: durations.map((dur) {
                return DropdownMenuItem(
                  child: Text(dur ?? 'All'),
                  value: dur,
                );
              }).toList(),
              onChanged: controller.updateDuration,
            ),
          ],
        );
      },
    );
  }
}
