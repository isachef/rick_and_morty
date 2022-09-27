import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/models/user_model.dart';
import 'package:rick_and_morty/screens/episode_screen/bloc/episode_repository.dart';
import 'package:rick_and_morty/screens/user_screen/bloc/user_repository.dart';

import '../../../helpers/catch_exception.dart';
import '../../../models/episode_model.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  EpisodeBloc() : super(EpisodeInitial()) {
    List<EpisodeModel> episodeModelList = [];
    EpisodeRepository episodeRepository = EpisodeRepository();

    on<GetEpisodesEvent>((event, emit) async {
      try {
        emit(EpisodeLoadingState());

        episodeModelList = await episodeRepository.getEpisodes(event.page);

        emit(EpisodesFetchedState(episodeModelList));
      } catch (e) {
        emit(EpisodeErrorState(CatchException.convertException(e)));
      }
    });
    on<GetEpisodeEvent>((event, emit) async {
      EpisodeModel episodeModel = EpisodeModel();
      List<UserModel> userModelList=[];
      Repository repository = Repository();

      try {
        emit(EpisodeLoadingState());
        episodeModel = await episodeRepository.getEpisode(event.id);

        for (var i = 0; i < episodeModel.characters!.length; i++) {
          userModelList.add(
            await repository.getUser(
              episodeModel.characters![i].substring(42),
            ),
          );
        }

        // for (var e in episodeModel.characters!) {
        //   userModelList.add(
        //     await repository.getUser(
        //       e.substring(42),
        //     ),
        //   );
        // }

        emit(
          EpisodeFetchedState(
            episodeModel: episodeModel,
            userModelList: userModelList,
          ),
        );
      } catch (e) {
        emit(EpisodeErrorState(CatchException.convertException(e)));
      }
    });
    // on((event, emit) {
    // if (event == '') {
    //       emit(EpisodeLoadingState());
    //       emit(EpisodesFetchedState(episodeModelList));
    //     } else {
    //       emit(EpisodeLoadingState());
    //       for (var elem in episodeModelList) {
    //         if (!elem.name!.toLowerCase().contains(event.search)) {
    //           episodeModelList.remove(elem);
    //         }
    //       }
    //       episodeModelList = await episodeRepository.getEpisodes();
    //       emit(EpisodesFetchedState(episodeModelList));
    //     }
    // });
  }
}
