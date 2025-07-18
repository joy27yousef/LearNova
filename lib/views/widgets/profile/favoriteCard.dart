// import 'package:flutter/material.dart';
// import 'package:learn_nova/core/function/favoriteHeart.dart';
// import 'package:learn_nova/core/function/translationData.dart';
// import 'package:learn_nova/views/widgets/boxText.dart';

// class FavoriteCard extends StatelessWidget {
//   const FavoriteCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.background,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 5,
//             blurStyle: BlurStyle.outer,
//             color: Colors.grey.shade300,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // صورة الدورة
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Image.network(
//                   course['thumbnail_url'],
//                   width: 120,
//                   height: 125,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(width: 10),
//               // معلومات الدورة
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       course['title'][translationData()],
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                       style: Theme.of(context)
//                           .textTheme
//                           .titleLarge!
//                           .copyWith(fontSize: 15),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       "By ${course['teacher']['name']}",
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Lottie.asset(Appimages.advantage, width: 25),
//                         SizedBox(width: 5),
//                         Text(course['difficulty_level'],
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(fontSize: 12)),
//                       ],
//                     ),
//                     SizedBox(height: 5),
//                     Row(
//                       children: [
//                         Lottie.asset(Appimages.time, width: 20),
//                         SizedBox(width: 5),
//                         Text(
//                           course['duration'][translationData()],
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyMedium!
//                               .copyWith(fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           // الأزرار
//           Row(
//             children: [
//               Expanded(
//                 flex: 3,
//                 child: Boxtext(
//                   textin: "Go to Course",
//                   onTapFun: () {
//                     // انتقل لصفحة الدورة هنا
//                   },
//                   withheight: true,
//                   heightedit: 40,
//                 ),
//               ),
//               SizedBox(width: 10),
//               FavoriteHeart(courseId: course['id']),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
