import 'package:bloc/bloc.dart';
import 'package:brik_test/core/common/logger.dart';
import 'package:brik_test/feature/groceries/data/repository/klontong_repository.dart';
import 'package:meta/meta.dart';

part 'groceries_delete_event.dart';
part 'groceries_delete_state.dart';

class GroceriesDeleteBloc
    extends Bloc<GroceriesDeleteEvent, GroceriesDeleteState> {
  GroceriesDeleteBloc() : super(GroceriesDeleteInitial()) {
    on<GroceriesDetailDeleteRequest>((event, emit) async {
      await groceriesDetailDelete(event, emit);
    });
  }

  KlontongRepository repository = KlontongRepository();

  Future groceriesDetailDelete(
    GroceriesDetailDeleteRequest event,
    Emitter<GroceriesDeleteState> emit,
  ) async {
    try {
      emit(GroceriesDeleteLoading());

      // if id null
      if (event.id.isEmpty || event.id == '') {
        emit(GroceriesDeleteLoaded());
        return;
      }

      await repository.deleteKlontong(id: event.id);
      // var response = await repository.deleteKlontong(id: event.id);

      emit(GroceriesDeleteLoaded());
    } catch (e) {
      Logger.print('err in bloc: ${e.toString()}');
      emit(GroceriesDeleteError(errorMessage: e.toString()));
    }
  }
}
