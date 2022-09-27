part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class GetLocationsEvent extends LocationEvent {}

class GetLocationEvent extends LocationEvent {
  final String id;

  GetLocationEvent(this.id);
}

class GetFilterEvent extends LocationEvent {
  final String search;

  GetFilterEvent(this.search);
}
