import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:learn_nova/core/class/AnimatedListItem.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class AboutLearnova extends StatelessWidget {
  AboutLearnova({super.key});

  final Map ach = {
    'title': [
      'Trusted by Thousands',
      'Award-Winning Courses',
      'Positive Student Feedback',
      'Industry Partnerships'
    ],
    'body': [
      'We have successfully served thousands of students, helping them unlock their potential and achieve their career goals.',
      'Our courses have received recognition and accolades in the industry for their quality, depth of content, and effective teaching methodologies.',
      'We take pride in the positive feedback we receive from our students, who appreciate the practicality and relevance of our course materials.',
      'We have established strong partnerships with industry leaders, enabling us to provide our students with access to the latest tools and technologies.'
    ],
    'icons': [
      Icons.verified,
      Icons.emoji_events,
      Icons.thumb_up,
      Icons.handshake
    ]
  };
  final Map goals = {
    'title': [
      'Provide Practical Skills',
      'Foster Creative Problem-Solving',
      'Promote Collaboration and Community',
      'Stay Ahead of the Curve'
    ],
    'body': [
      'We focus on delivering practical skills that are relevant to the current industry demands. Our courses are designed to equip learners with the knowledge and tools needed to excel in their chosen field.',
      'We encourage creative thinking and problem-solving abilities, allowing our students to tackle real world challenges with confidence and innovation.',
      'We believe in the power of collaboration and peer learning. Our platform fosters a supportive and inclusive community where learners can connect, share insights, and grow together.',
      'The digital landscape is constantly evolving, and we strive to stay at the forefront of industry trends. We regularly update our course content to ensure our students receive the latest knowledge and skills.'
    ],
    'icons': [
      Icons.build,
      Icons.psychology_alt,
      Icons.groups,
      Icons.trending_up
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About LearNova')),
      body: ListView(
        padding: const EdgeInsets.all(20),
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
          const SizedBox(height: 20),
          Text('Achievements', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          ...List.generate(ach['title'].length, (i) {
            return AnimatedListItem(
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 4,
                color: Theme.of(context).colorScheme.background,
                child: ListTile(
                  title: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          ach['icons'][i],
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        ach['title'][i],
                        softWrap: T,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 17),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      ach['body'][i],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          Text('Our Goals', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          ...List.generate(goals['title'].length, (i) {
            return AnimatedListItem(
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 4,
                color: Theme.of(context).colorScheme.background,
                child: ListTile(
                  title: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          goals['icons'][i],
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          goals['title'][i],
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      goals['body'][i],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
