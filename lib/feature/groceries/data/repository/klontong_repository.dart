import 'package:brik_test/core/client/client.dart';
import 'package:brik_test/core/common/endpoint.dart';
import 'package:brik_test/core/common/logger.dart';
import 'package:brik_test/feature/groceries/data/model/groceries_payload.dart';
import 'package:brik_test/feature/groceries/data/model/klontong_response.dart';
import 'package:dio/dio.dart';

class KlontongRepository {
  Dio dio = Client().dio;
  late Response response;

  // Get List Groceries
  Future<List<GroceriesModel>> getListGroceries() async {
    Logger.print('--- KlontongRepository @getListGroceries : ---');
    try {
      var endPoint = Endpoint.klontong;
      response = await dio.get(endPoint);

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
    Logger.print('--- KlontongRepository @getKlontongDetail : ---');
    try {
      var endPoint = '${Endpoint.klontong}/$id';
      response = await dio.get(endPoint);

      var responseData = response.data;
      GroceriesModel groceriesModel = GroceriesModel.fromJson(responseData);

      return groceriesModel;
    } on DioException catch (e) {
      throw e.message ?? '';
    }
  }

  // post
  Future postGroceries({required GroceriesPayload payload}) async {
    Logger.print('--- KlontongRepository @postGroceries : ---');
    try {
      var endPoint = Endpoint.klontong;
      response = await dio.post(endPoint, data: payload.toJson());

      // because from API cant get the return (success or failed)
      return null;
    } on DioException catch (e) {
      throw e.message ?? '';
    }
  }

  // put
  Future updateGroceries({
    required GroceriesPayload payload,
    required String id,
  }) async {
    Logger.print('--- KlontongRepository @updateGroceries : ---');
    try {
      var endPoint = '${Endpoint.klontong}/$id';
      response = await dio.put(endPoint, data: payload.toJson());

      // because from API cant get the return (success or failed)
      return null;
    } on DioException catch (e) {
      throw e.message ?? '';
    }
  }

  // Get Detail Groceries
  Future deleteKlontong(String id) async {
    Logger.print('--- KlontongRepository @deleteKlontong : ---');
    try {
      var endPoint = '${Endpoint.klontong}/$id';
      response = await dio.delete(endPoint);

      return null;
    } on DioException catch (e) {
      throw e.message ?? '';
    }
  }
}
