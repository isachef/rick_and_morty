import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/models/location_model.dart';
import 'package:rick_and_morty/screens/location_screen/location_about_screen.dart';
import 'package:rick_and_morty/widgets/custom_text_field.dart';

import '../../widgets/loading_widget.dart';
import 'bloc/location_bloc.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late LocationBloc _locationBloc;
  late List<LocationModel> locationModelList;
  int? locationListLength;
  ScrollController scrollController=ScrollController();

  @override
  void initState() {
    _locationBloc = LocationBloc();
    _locationBloc.add(GetLocationsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                CustomTextField(
                  title: 'найти локацию',
                  onSubmitted: (value) {
                    _locationBloc.add(GetFilterEvent(value));
                  }, onChange: (String val) {  },
                ),
                Expanded(
                  child: BlocConsumer<LocationBloc, LocationState>(
                    bloc: _locationBloc,
                    listener: (context, state) {
                      if (state is LocationsFetchedState) {
                        locationModelList = state.locationModelList;
                        locationListLength = locationModelList.length;
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
                      if (state is LocationsFetchedState) {
                        return locationModelList.isNotEmpty
                            ? Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text(
                                      'всего локаций: ${locationListLength ?? '0'}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color(0xff828282),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      controller:scrollController ,
                                      itemCount: locationModelList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LocationAboutScreen(
                                                  id: locationModelList[index]
                                                      .id
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(bottom: 20.h),
                                            height: 235.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20).r,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 5)
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                                20)
                                                            .r,
                                                    topRight:
                                                        const Radius.circular(
                                                                20)
                                                            .r,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/icons/earth.png',
                                                    height: 167.h,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 7, 0, 0),
                                                  child: Text(
                                                    locationModelList[index]
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 5, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${locationModelList[index].type} • ',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        locationModelList[index]
                                                            .dimension
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                height: 235,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  child: Image.asset('assets/img/notfound.png'),
                                ),
                              );
                      }
                      return Container(
                        height: 235.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).r,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              child: Image.asset('assets/icons/logoRick.png'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// final String url;
//   final String name;
//   final String type;
//   final String dimension;