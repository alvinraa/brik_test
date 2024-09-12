import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'groceries_detail_event.dart';
part 'groceries_detail_state.dart';

class GroceriesDetailBloc
    extends Bloc<GroceriesDetailEvent, GroceriesDetailState> {
  GroceriesDetailBloc() : super(GroceriesDetailInitial()) {
    on<GroceriesDetailEvent>((event, emit) {});
  }
}
