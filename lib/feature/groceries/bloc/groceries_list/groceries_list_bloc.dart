import 'package:bloc/bloc.dart';
import 'package:brik_test/core/common/logger.dart';
import 'package:brik_test/feature/groceries/data/model/klontong_response.dart';
import 'package:brik_test/feature/groceries/data/repository/klontong_repository.dart';
import 'package:meta/meta.dart';

part 'groceries_list_event.dart';
part 'groceries_list_state.dart';

class GroceriesListBloc extends Bloc<GroceriesListEvent, GroceriesListState> {
  GroceriesListBloc() : super(GroceriesListLoading()) {
    on<GetGroceriesListRequest>((event, emit) async {
      await getGroceriesList(event, emit);
    });
  }

  KlontongRepository repository = KlontongRepository();
  List<GroceriesModel> listGroceries = [];

  Future getGroceriesList(
    GetGroceriesListRequest event,
    Emitter<GroceriesListState> emit,
  ) async {
    try {
      emit(GroceriesListLoading());

      List<GroceriesModel> response = await repository.getListGroceries();
      listGroceries = response;

      emit(GroceriesListLoaded());
    } catch (e) {
      Logger.print('err in bloc: ${e.toString()}');
      emit(GroceriesListError(errorMessage: e.toString()));
    }
  }
}
