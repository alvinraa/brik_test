part of 'groceries_add_bloc.dart';

@immutable
sealed class GroceriesAddEvent {}

class GroceriesAddRequest extends GroceriesAddEvent {
  final GroceriesPayload payload;

  GroceriesAddRequest({
    required this.payload,
  });
}
