import 'package:brik_test/core/client/client.dart';
import 'package:brik_test/core/common/endpoint.dart';
import 'package:brik_test/core/common/logger.dart';
import 'package:brik_test/feature/groceries/data/model/klontong_response.dart';
import 'package:dio/dio.dart';

class KlontongRepository {
  Dio dio = Client().dio;
  late Response response;

  // Get List Groceries
  Future<List<GroceriesModel>> getListGroceries() async {
    Logger.print('--- KlontongRepository @getListGroceries : ---');
    try {
      response = await dio.get(Endpoint.klontong);
      List responseData = response.data;

      List<GroceriesModel> listGroceries =
          responseData.map((e) => GroceriesModel.fromJson(e)).toList();

      return listGroceries;
    } on DioException catch (e) {
      throw e.message ?? '';
    }
  }

  // Get Detail Groceries
  Future<GroceriesModel> getKlontongDetail(String id) async {
    try {
      response = await dio.get(Endpoint.klontong);
      var responseData = response.data;

      GroceriesModel groceriesModel = GroceriesModel.fromJson(responseData);

      return groceriesModel;
    } on DioException catch (e) {
      throw e.message ?? '';
    }
  }
}
