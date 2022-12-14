import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/function/functions.dart';
import 'package:rick_and_morty/models/episode_model.dart';
import 'package:rick_and_morty/models/user_model.dart';
import 'package:rick_and_morty/screens/episode_screen/bloc/episode_bloc.dart';

import '../../widgets/loading_widget.dart';
import '../user_screen/user_about_screen.dart';

class EpisodeAboutScreen extends StatefulWidget {
  final String id;
  const EpisodeAboutScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EpisodeAboutScreen> createState() => _EpisodeAboutScreenState();
}

class _EpisodeAboutScreenState extends State<EpisodeAboutScreen> {
  late EpisodeBloc _episodeBloc;
  late List<UserModel> userModelList;
  late EpisodeModel episodeModel;

  @override
  void initState() {
    _episodeBloc = EpisodeBloc();
    _episodeBloc.add(GetEpisodeEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<EpisodeBloc, EpisodeState>(
      bloc: _episodeBloc,
      listener: (context, state) {
        if (state is EpisodeFetchedState) {
          userModelList = state.userModelList;
          episodeModel = state.episodeModel;
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
        if (state is EpisodeFetchedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 1.sw,
                  height: 298.h,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Image.asset(
                        'assets/img/anatomyPark.png',
                        fit: BoxFit.cover,
                        width: 1.sw,
                        height: 298.h,
                      ),
                      Positioned(
                        top: 40.h,
                        left: 20.w,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ),
                      Positioned(
                        top: 270.h,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20).r,
                          width: 1.sw,
                          height: 1.sh,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(26.r),
                              topRight: Radius.circular(26.r),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        episodeModel.name.toString(),
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30).r,
                        child: Text(episodeModel.created.toString()),
                      ),
                      const Text('Characters'),
                      episodeModel.characters!.isEmpty
                          ? Image.asset('assets/icons/logoRick.png')
                          : ListView.separated(
                              padding: EdgeInsets.only(top: 24.h),
                              itemCount: episodeModel.characters!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserAboutScreen(
                                          id: state.userModelList[index].id
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          userModelList[index].image!,
                                          fit: BoxFit.cover,
                                          width: 74.r,
                                          height: 74.r,
                                        ),
                                      ),
                                      SizedBox(width: 18.w),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userModelList[index].status!,
                                              style: TextStyle(
                                                color: statusColor(state
                                                    .userModelList[index]
                                                    .status!),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              userModelList[index].name!,
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '${userModelList[index].species}, ${userModelList[index].gender}',
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff828282),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 24.h,
                                );
                              },
                            )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    ));
  }
}
