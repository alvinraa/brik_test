part of 'groceries_detail_bloc.dart';

@immutable
sealed class GroceriesDetailEvent {}

class GetGroceriesDetailRequest extends GroceriesDetailEvent {
  final bool hasLoading;
  final String id;

  GetGroceriesDetailRequest({
    this.hasLoading = true,
    required this.id,
  });
}
