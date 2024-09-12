part of 'groceries_list_bloc.dart';

@immutable
sealed class GroceriesListState {}

final class GroceriesListInitial extends GroceriesListState {}

class GetGroceriesListLoading extends GroceriesListState {}

class GetGroceriesListLoadMoreLoading extends GroceriesListState {}

class GetGroceriesListLoaded extends GroceriesListState {
  GetGroceriesListLoaded();
}

class GetGroceriesListError extends GroceriesListState {
  final String? errorMessage;
  GetGroceriesListError({this.errorMessage});
}
