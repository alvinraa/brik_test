part of 'groceries_update_bloc.dart';

@immutable
sealed class GroceriesUpdateEvent {}

class GroceriesUpdateRequest extends GroceriesUpdateEvent {
  final GroceriesPayload payload;
  final String id;

  GroceriesUpdateRequest({
    required this.payload,
    required this.id,
  });
}
