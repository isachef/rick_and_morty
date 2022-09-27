import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/models/location_model.dart';
import 'package:rick_and_morty/models/user_model.dart';
import 'package:rick_and_morty/screens/location_screen/bloc/location_repository.dart';

import '../../../helpers/catch_exception.dart';
import '../../user_screen/bloc/user_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    List<LocationModel> locationModelList = [];
    List<LocationModel> locationFilterList = [];

    LocationRepository locationRepository = LocationRepository();

    on<GetLocationsEvent>((event, emit) async {
      emit(LocationLoadingState());

      try {
        locationModelList = await locationRepository.getLocations();

        emit(LocationsFetchedState(locationModelList));
      } catch (e) {
        emit(LocationErrorState(CatchException.convertException(e)));
      }
    });
    on<GetLocationEvent>((event, emit) async {
      Repository repository = Repository();
      LocationModel locationModel = LocationModel();
      List<UserModel> userModelList = [];

      try {
        emit(LocationLoadingState());

        locationModel = await locationRepository.getLocation(event.id);

        for (var i = 0; i < locationModel.residents!.length; i++) {
          userModelList.add(
            await repository.getUser(
              locationModel.residents![i].substring(42),
            ),
          );
        }

        emit(LocationFetchedState(
            locationModel: locationModel, userModelList: userModelList));
      } catch (e) {
        emit(LocationErrorState(CatchException.convertException(e)));
      }
    });

    on<GetFilterEvent>((event, emit) async {
      locationFilterList.clear();
      locationFilterList.addAll(locationModelList);

      try {
        if (event.search == '') {
          emit(LocationLoadingState());

          emit(LocationsFetchedState(locationModelList));
        } else {
          emit(LocationLoadingState());

          for (var i = locationFilterList.length - 1; i >= 0; i--) {
            if (!locationFilterList[i]
                .name!
                .toLowerCase()
                .contains(event.search)) {
              locationFilterList.removeAt(i);
            }
          }

          emit(LocationsFetchedState(locationFilterList));
        }
      } catch (e) {
        emit(LocationErrorState(CatchException.convertException(e)));
      }
    });
  }
}
