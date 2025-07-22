import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/SearchController.dart';
import 'package:learn_nova/views/widgets/search/dataSearch.dart';
import 'package:learn_nova/views/widgets/search/filter.dart';
import 'package:learn_nova/views/widgets/search/searchForm.dart';
import 'package:learn_nova/views/widgets/search/searchHistory.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchCourseController controller = Get.put(SearchCourseController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Search in LearNova'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: PopupMenuButton<int>(
              onSelected: (value) {
                if (value == 0) {
                  controller.clearSearchHistory();
                } else if (value == 1) {}
              },
              icon: const Icon(Icons.more_vert),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Theme.of(context).colorScheme.background,
              elevation: 8,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.delete_rounded, color: Colors.red),
                      SizedBox(width: 10),
                      Text("Delete history"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchForm(),
            SizedBox(height: 10),
            GetBuilder<SearchCourseController>(
              builder: (controller) {
                return controller.showFilters
                    ? Column(
                        children: [
                          SizedBox(height: 10),
                          FilterTab(),
                          SizedBox(height: 20),
                        ],
                      )
                    : SizedBox();
              },
            ),
            SizedBox(height: 5),
            SearchHistory(),
            SizedBox(height: 12),
            DataSearch(),
          ],
        ),
      ),
    );
  }
}
