import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/helpers/catch_exception.dart';
import 'package:rick_and_morty/models/episode_model.dart';
import 'package:rick_and_morty/models/user_model.dart';
import 'package:rick_and_morty/screens/episode_screen/bloc/episode_repository.dart';
import 'package:rick_and_morty/screens/user_screen/bloc/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    Repository repository = Repository();
    List<UserModel> userModelList = [];
    List<UserModel> filterUserModelList = [];

    on<GetUsersEvent>((event, emit) async {
      try {
        emit(UserLoadingState());

        userModelList = await repository.getUsers();
        
        emit(UsersFetchedState(userModelList));
      } catch (e) {
        emit(UserErrorState(CatchException.convertException(e)));
      }
    });
    on<GetUserEvent>((event, emit) async {
      UserModel userModel;
      EpisodeRepository episodeRepository = EpisodeRepository();
      List<EpisodeModel> episodeModelList = [];

      try {
        emit(UserLoadingState());

        userModel = await repository.getUser(event.id);
        for (var i = 0; i < userModel.episode!.length; i++) {
          episodeModelList.add(
            await episodeRepository.getEpisode(
              userModel.episode![i].substring(40),
            ),
          );
        }

        emit(UserFetchedState(
          userModel: userModel,
          episodeModel: episodeModelList,
        ));
      } catch (e) {
        emit(UserErrorState(CatchException.convertException(e)));
      }
    });
    on<GetFilterUsersEvent>((event, emit) async {
      try {
        filterUserModelList.clear();
        filterUserModelList.addAll(userModelList);
        if (event.search == '') {
          emit(UserLoadingState());

          emit(UsersFetchedState(userModelList));
        } else {
          for (var i = filterUserModelList.length - 1; i >= 0; i--) {
            if (!filterUserModelList[i]
                .name!
                .toLowerCase()
                .contains(event.search)) {
              filterUserModelList.removeAt(i);
            }
          }
        }

        emit(UsersFetchedState(filterUserModelList));
      } catch (e) {
        emit(UserErrorState(CatchException.convertException(e)));
      }
    });
  }
}
