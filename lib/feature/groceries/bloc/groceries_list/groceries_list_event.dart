part of 'groceries_list_bloc.dart';

@immutable
sealed class GroceriesListEvent {}

class GetGroceriesListRequest extends GroceriesListEvent {
  final bool isLoadMore;
  GetGroceriesListRequest({
    this.isLoadMore = false,
  });
}
