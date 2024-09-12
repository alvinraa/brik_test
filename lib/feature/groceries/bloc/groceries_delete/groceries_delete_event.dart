part of 'groceries_delete_bloc.dart';

@immutable
sealed class GroceriesDeleteEvent {}

class GroceriesDetailDeleteRequest extends GroceriesDeleteEvent {
  final String id;

  GroceriesDetailDeleteRequest({
    required this.id,
  });
}
