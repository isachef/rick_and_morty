import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/function/functions.dart';
import 'package:rick_and_morty/models/location_model.dart';
import 'package:rick_and_morty/screens/location_screen/bloc/location_bloc.dart';
import 'package:rick_and_morty/screens/user_screen/user_about_screen.dart';
import '../../widgets/loading_widget.dart';

class LocationAboutScreen extends StatefulWidget {
  final String id;

  const LocationAboutScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<LocationAboutScreen> createState() => _LocationAboutScreenState();
}

class _LocationAboutScreenState extends State<LocationAboutScreen> {
  late LocationBloc _locationBloc;
  late LocationModel locationModel;

  @override
  void initState() {
    _locationBloc = LocationBloc();
    _locationBloc.add(GetLocationEvent(widget.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LocationBloc, LocationState>(
        bloc: _locationBloc,
        listener: (context, state) {
          if (state is LocationFetchedState) {
            locationModel = state.locationModel;
          }
          if (state is LocationErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message!),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LocationLoadingState) {
            return const LoadingWidget();
          }
          if (state is LocationFetchedState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 1.sw,
                    height: 298.h,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Image.asset(
                          'assets/icons/earth.png',
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20).r,
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
                          locationModel.name.toString(),
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              '${locationModel.type} • ',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              locationModel.dimension.toString(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30).r,
                          child: Text(locationModel.created.toString()),
                        ),
                        const Text('Characters'),
                        locationModel.residents!.isEmpty
                            ? Image.asset('assets/icons/logoRick.png')
                            : ListView.separated(
                                padding: EdgeInsets.only(top: 24.h),
                                itemCount: locationModel.residents!.length,
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
                                            state.userModelList[index].image!,
                                            fit: BoxFit.cover,
                                            width: 74.r,
                                            height: 74.r,
                                          ),
                                        ),
                                        SizedBox(width: 18.w),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state
                                                  .userModelList[index].status!,
                                              style: TextStyle(
                                                color: statusColor(state
                                                    .userModelList[index]
                                                    .status!),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              state.userModelList[index].name!,
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '${state.userModelList[index].species}, ${state.userModelList[index].gender}',
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff828282),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp),
                                            ),
                                          ],
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
      ),
    );
  }
}
