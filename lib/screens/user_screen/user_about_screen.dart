import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/function/functions.dart';
import 'package:rick_and_morty/models/user_model.dart';
import 'package:rick_and_morty/screens/episode_screen/episode_about_screen.dart';
import 'package:rick_and_morty/screens/location_screen/location_about_screen.dart';
import 'package:rick_and_morty/screens/user_screen/bloc/user_bloc.dart';
import 'package:rick_and_morty/screens/user_screen/user_widgets/appBar_user_about_screen.dart';

import '../../widgets/loading_widget.dart';
import 'user_widgets/custom_user_inkwel.dart';

class UserAboutScreen extends StatefulWidget {
  final String id;

  const UserAboutScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<UserAboutScreen> createState() => _UserAboutScreenState();
}

class _UserAboutScreenState extends State<UserAboutScreen> {
  late UserBloc _userBloc;
  late UserModel _userModel;

  @override
  void initState() {
    _userBloc = UserBloc();
    _userBloc.add(GetUserEvent(widget.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<UserBloc, UserState>(
      bloc: _userBloc,
      listener: (context, state) {
        if (state is UserFetchedState) {
          _userModel = state.userModel;
        }
        if (state is UserErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message!),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is UserLoadingState) {
          return Center(child: LoadingWidget());
        }
        if (state is UserFetchedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                AppbarUserAboutScreen(url: _userModel.image!),
                Text(
                  _userModel.name!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 34.sp),
                ),
                Text(
                  _userModel.status!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: statusColor(_userModel.status!),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20).r,
                  child: Column(
                    children: [
                      Text(_userModel.created.toString()),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'gender',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                _userModel.gender!,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'race',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                _userModel.species!,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      CustomUserInkwel(
                        onTap: () {
                          _userModel.origin!.url == ''
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Unknown'),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LocationAboutScreen(
                                      id: _userModel.origin!.url!.substring(41),
                                    ),
                                  ),
                                );
                        },
                        title: 'birthplace',
                        info: _userModel.origin!.name!,
                      ),
                      SizedBox(height: 10.h),
                      CustomUserInkwel(
                        onTap: () {
                          _userModel.location!.url == ''
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Unknown'),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LocationAboutScreen(
                                      id: _userModel.location!.url!
                                          .substring(41),
                                    ),
                                  ),
                                );
                        },
                        title: 'location',
                        info: _userModel.location!.name!,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  color: Colors.grey[250],
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Episodes',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'All episodes',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.episodeModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EpisodeAboutScreen(
                                      id: state.episodeModel[index].id
                                          .toString()),
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
                                        'assets/img/episode.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'episode ${state.episodeModel[index].episode!.substring(4)}',
                                          style: TextStyle(
                                            color: Color(0xff22A2BD),
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.clip,
                                          state.episodeModel[index].name
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        Text(
                                          '${state.episodeModel[index].airDate}',
                                          style: TextStyle(
                                            color: Color(0xff828282),
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios)
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
