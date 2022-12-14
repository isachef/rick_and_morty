import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/screens/episode_screen/tab_bar_screens/fitst_screen.dart';
import 'package:rick_and_morty/screens/episode_screen/tab_bar_screens/second_screen.dart';
import 'package:rick_and_morty/screens/episode_screen/tab_bar_screens/third_screen.dart';
import 'package:rick_and_morty/widgets/custom_text_field.dart';

class EpisodeScreen extends StatefulWidget {
  const EpisodeScreen({Key? key}) : super(key: key);

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomTextField(
                    title: 'find the episode', onSubmitted: (val) {}, onChange: (String val) {  },),
              ),
              TabBar(
                labelStyle: const TextStyle(color: Colors.black),
                labelColor: Colors.black,
                controller: _tabController,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  const Tab(text: '1 page'),
                  const Tab(text: '2 page'),
                  const Tab(text: '3 page'),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TabBarView(
                    controller: _tabController,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const FirstScreen(),
                      const SecondScreen(),
                      const ThirdScreen(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
