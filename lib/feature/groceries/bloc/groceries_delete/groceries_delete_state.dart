part of 'groceries_delete_bloc.dart';

@immutable
sealed class GroceriesDeleteState {}

final class GroceriesDeleteInitial extends GroceriesDeleteState {}

final class GroceriesDeleteNoLoading extends GroceriesDeleteState {}

final class GroceriesDeleteLoading extends GroceriesDeleteState {}

final class GroceriesDeleteLoaded extends GroceriesDeleteState {}

final class GroceriesDeleteError extends GroceriesDeleteState {
  final String? errorMessage;

  GroceriesDeleteError({this.errorMessage});
}
