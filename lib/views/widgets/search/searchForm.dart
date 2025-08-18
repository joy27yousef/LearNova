import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/SearchController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';

class SearchForm extends StatelessWidget {
  final SearchCourseController controller = Get.find();

  SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<SearchCourseController>(
          builder: (controller) => InkWell(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            onTap: controller.toggleFiltersVisibility,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Appcolor.baselight,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Icon(
                controller.showFilters
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: TextField(
            onChanged: controller.updateSearchText,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                controller.addToSearchHistory(value.trim());
              }
            },
            style: Theme.of(context).textTheme.bodySmall,
            cursorColor: Appcolor.base,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.manage_search_rounded,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.background,
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
              label: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Search in courses',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
