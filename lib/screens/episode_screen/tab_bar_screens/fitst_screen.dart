import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/models/episode_model.dart';
import 'package:rick_and_morty/screens/episode_screen/bloc/episode_bloc.dart';
import 'package:rick_and_morty/screens/episode_screen/episode_about_screen.dart';

import '../../../widgets/loading_widget.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late EpisodeBloc _episodeBloc;
  late List<EpisodeModel> episodeModelList;
  @override
  void initState() {
    _episodeBloc = EpisodeBloc();
    _episodeBloc.add(GetEpisodesEvent('1'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EpisodeBloc, EpisodeState>(
        bloc: _episodeBloc,
        listener: (context, state) {
          if (state is EpisodesFetchedState) {
            episodeModelList = state.episodeModelList;
          }
          if (state is EpisodeErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message!),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is EpisodeLoadingState) {
            return const LoadingWidget();
          }
          if (state is EpisodesFetchedState) {
            return SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: episodeModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EpisodeAboutScreen(
                            id: episodeModelList[index].id.toString(),
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 95.r,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 95.r,
                            height: 95.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30).r,
                              child: Image.asset(
                                'assets/icons/earth.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'episode ${episodeModelList[index].episode!}',
                                  style: TextStyle(
                                    color: const Color(0xff22A2BD),
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  overflow: TextOverflow.clip,
                                  episodeModelList[index].name.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Text(
                                  '${episodeModelList[index].airDate}',
                                  style: TextStyle(
                                    color: const Color(0xff828282),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 24.h,
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
