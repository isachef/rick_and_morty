import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/screens/user_screen/user_about_screen.dart';
import 'package:rick_and_morty/screens/user_screen/user_widgets/custom_user_card.dart';
import 'package:rick_and_morty/widgets/custom_text_field.dart';
import 'package:rick_and_morty/widgets/loading_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/user_model.dart';
import 'bloc/user_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late List<UserModel> usermodelList;
  late UserBloc userBloc;
  ValueNotifier _isGrid = ValueNotifier<bool>(true);
  late var localization;

  @override
  void initState() {
    userBloc = UserBloc();
    userBloc.add(GetUsersEvent());
    localization== AppLocalizations.of(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Column(
              children: [
                CustomTextField(
                  title: localization.find_person,
                  onSubmitted: (value) {
                    userBloc.add(GetFilterUsersEvent(value));
                  },
                  onChange: (value){
                    userBloc.add(GetFilterUsersEvent(value));
                  },
                ),
                Expanded(
                  child: BlocConsumer<UserBloc, UserState>(
                    bloc: userBloc,
                    listener: (context, state) {
                      if (state is UsersFetchedState) {
                        usermodelList = state.userModelList;
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
                        return LoadingWidget();
                      }
                      if (state is UsersFetchedState) {
                        return state.userModelList.isEmpty
                            ? Container(
                                height: 235,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  child: Image.asset('assets/img/notfound.png'),
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Text(
                                          'всего персонажей: ${state.userModelList.length}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color(0xff828282),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _isGrid.value = !_isGrid.value;
                                          setState(() {});
                                        },
                                        icon: _isGrid.value == true
                                            ? Icon(Icons.list)
                                            : Icon(Icons.grid_on_outlined),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: ValueListenableBuilder(
                                      valueListenable: _isGrid,
                                      builder:
                                          (BuildContext context, value, child) {
                                        return GridView.builder(
                                          itemCount: usermodelList.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      _isGrid.value ? 2 : 1,
                                                  crossAxisSpacing: 5,
                                                  mainAxisSpacing: 24,
                                                  childAspectRatio:
                                                      _isGrid.value
                                                          ? 164 / 192
                                                          : 343 / 74),
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return CustomUserCard(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserAboutScreen(
                                                      id: usermodelList[index]
                                                          .id
                                                          .toString(),
                                                    ),
                                                  ),
                                                );
                                              },
                                              isGrid: _isGrid.value,
                                              url: usermodelList[index].image!,
                                              status:
                                                  usermodelList[index].status!,
                                              name: usermodelList[index].name!,
                                              species:
                                                  usermodelList[index].species!,
                                              gender:
                                                  usermodelList[index].gender!,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )
                                ],
                              );
                      }
                      return Container();
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
