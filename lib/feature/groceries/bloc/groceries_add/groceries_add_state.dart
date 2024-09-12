part of 'groceries_add_bloc.dart';

@immutable
sealed class GroceriesAddState {}

final class GroceriesAddInitial extends GroceriesAddState {}

final class GroceriesAddLoading extends GroceriesAddState {}

final class GroceriesAddSuccess extends GroceriesAddState {
  final String message;

  GroceriesAddSuccess({required this.message});
}

final class GroceriesAddError extends GroceriesAddState {
  final String? errorMessage;

  GroceriesAddError({this.errorMessage});
}
