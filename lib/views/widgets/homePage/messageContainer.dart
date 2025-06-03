import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/homePageController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/data/source/static.dart';
import 'package:learn_nova/views/widgets/homePage/pointScrol.dart';

class Messagecontainer extends StatelessWidget {
  const Messagecontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepagecontrollerIMP>(
        builder: (controller) => Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer,
                    offset: Offset(0, 0),
                    color: Appcolor.baselight,
                  )
                ],
                color: Appcolor.base,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (val) {
                        print(val);
                        controller.onChangeMessage(val);
                      },
                      itemCount: homeScrol.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return AnimatedBuilder(
                          animation: controller.pageController,
                          builder: (context, child) {
                            double value = 1.0;
                            if (controller
                                .pageController.position.haveDimensions) {
                              value = controller.pageController.page! - i;
                              value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                            }
                            return Opacity(
                              opacity: value,
                              child: Transform.scale(
                                scale: value,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      homeScrol[i].content!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Center(
                                      child: Image.asset(
                                        homeScrol[i].image!,
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Pointscrol(),
                ],
              ),
            ));
  }
}
