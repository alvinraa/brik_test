part of 'groceries_update_bloc.dart';

@immutable
sealed class GroceriesUpdateState {}

final class GroceriesUpdateInitial extends GroceriesUpdateState {}

final class GroceriesUpdateLoading extends GroceriesUpdateState {}

final class GroceriesUpdateSuccess extends GroceriesUpdateState {
  final String message;

  GroceriesUpdateSuccess({required this.message});
}

final class GroceriesUpdateError extends GroceriesUpdateState {
  final String? errorMessage;

  GroceriesUpdateError({this.errorMessage});
}
