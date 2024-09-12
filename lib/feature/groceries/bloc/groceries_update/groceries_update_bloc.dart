import 'package:bloc/bloc.dart';
import 'package:brik_test/core/common/logger.dart';
import 'package:brik_test/feature/groceries/data/model/groceries_payload.dart';
import 'package:brik_test/feature/groceries/data/repository/klontong_repository.dart';
import 'package:meta/meta.dart';

part 'groceries_update_event.dart';
part 'groceries_update_state.dart';

class GroceriesUpdateBloc
    extends Bloc<GroceriesUpdateEvent, GroceriesUpdateState> {
  GroceriesUpdateBloc() : super(GroceriesUpdateInitial()) {
    on<GroceriesUpdateRequest>((event, emit) async {
      await groceriesUpdate(event, emit);
    });
  }

  KlontongRepository repository = KlontongRepository();

  Future groceriesUpdate(
    GroceriesUpdateRequest event,
    Emitter<GroceriesUpdateState> emit,
  ) async {
    try {
      emit(GroceriesUpdateLoading());

      await repository.updateGroceries(payload: event.payload, id: event.id);
      // var response = await repository.deleteKlontong(id: event.id);

      emit(GroceriesUpdateSuccess(message: 'success update item'));
    } catch (e) {
      Logger.print('err in bloc: ${e.toString()}');
      emit(GroceriesUpdateError(errorMessage: e.toString()));
    }
  }
}
