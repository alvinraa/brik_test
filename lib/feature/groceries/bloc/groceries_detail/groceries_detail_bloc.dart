import 'package:bloc/bloc.dart';
import 'package:brik_test/core/common/logger.dart';
import 'package:brik_test/feature/groceries/data/model/klontong_response.dart';
import 'package:brik_test/feature/groceries/data/repository/klontong_repository.dart';
import 'package:meta/meta.dart';

part 'groceries_detail_event.dart';
part 'groceries_detail_state.dart';

class GroceriesDetailBloc
    extends Bloc<GroceriesDetailEvent, GroceriesDetailState> {
  GroceriesDetailBloc() : super(GroceriesDetailInitial()) {
    on<GetGroceriesDetailRequest>((event, emit) async {
      await getGroceriesDetail(event, emit);
    });
  }

  KlontongRepository repository = KlontongRepository();
  GroceriesModel groceriesModel = GroceriesModel();

  Future getGroceriesDetail(
    GetGroceriesDetailRequest event,
    Emitter<GroceriesDetailState> emit,
  ) async {
    try {
      emit(GroceriesDetailLoading());

      // if id null
      if (event.id.isEmpty || event.id == '') {
        emit(GroceriesDetailLoaded());
        return;
      }

      GroceriesModel response =
          await repository.getKlontongDetail(id: event.id);
      groceriesModel = response;

      emit(GroceriesDetailLoaded());
    } catch (e) {
      Logger.print('err in bloc: ${e.toString()}');
      emit(GroceriesDetailError(errorMessage: e.toString()));
    }
  }
}
