part of 'groceries_list_bloc.dart';

@immutable
sealed class GroceriesListState {}

final class GroceriesListInitial extends GroceriesListState {}

class GroceriesListLoading extends GroceriesListState {}

class GroceriesListLoadMoreLoading extends GroceriesListState {}

class GroceriesListLoaded extends GroceriesListState {
  GroceriesListLoaded();
}

class GroceriesListError extends GroceriesListState {
  final String? errorMessage;
  GroceriesListError({this.errorMessage});
}
