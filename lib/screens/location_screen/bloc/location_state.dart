part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationsFetchedState extends LocationState {
  final List<LocationModel> locationModelList;

  LocationsFetchedState(this.locationModelList);
}

class LocationFetchedState extends LocationState {
  final LocationModel locationModel;
  final List<UserModel> userModelList;

  LocationFetchedState(
      {required this.locationModel, required this.userModelList});
}

class LocationLoadingState extends LocationState {}

class LocationErrorState extends LocationState {
  final CatchException error;

  LocationErrorState(this.error);
}
