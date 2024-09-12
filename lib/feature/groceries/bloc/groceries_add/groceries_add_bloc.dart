import 'package:bloc/bloc.dart';
import 'package:brik_test/core/common/logger.dart';
import 'package:brik_test/feature/groceries/data/model/groceries_payload.dart';
import 'package:brik_test/feature/groceries/data/repository/klontong_repository.dart';
import 'package:meta/meta.dart';

part 'groceries_add_event.dart';
part 'groceries_add_state.dart';

class GroceriesAddBloc extends Bloc<GroceriesAddEvent, GroceriesAddState> {
  GroceriesAddBloc() : super(GroceriesAddInitial()) {
    on<GroceriesAddRequest>((event, emit) async {
      await groceriesAdd(event, emit);
    });
  }

  KlontongRepository repository = KlontongRepository();

  Future groceriesAdd(
    GroceriesAddRequest event,
    Emitter<GroceriesAddState> emit,
  ) async {
    try {
      emit(GroceriesAddLoading());

      await repository.postGroceries(payload: event.payload);
      // var response = await repository.deleteKlontong(id: event.id);

      emit(GroceriesAddSuccess(message: 'success add item'));
    } catch (e) {
      Logger.print('err in bloc: ${e.toString()}');
      emit(GroceriesAddError(errorMessage: e.toString()));
    }
  }
}
