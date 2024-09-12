part of 'groceries_detail_bloc.dart';

@immutable
sealed class GroceriesDetailState {}

final class GroceriesDetailInitial extends GroceriesDetailState {}

final class GroceriesDetailNoLoading extends GroceriesDetailState {}

final class GroceriesDetailLoading extends GroceriesDetailState {}

final class GroceriesDetailLoaded extends GroceriesDetailState {}

final class GroceriesDetailError extends GroceriesDetailState {
  final String? errorMessage;

  GroceriesDetailError({this.errorMessage});
}
