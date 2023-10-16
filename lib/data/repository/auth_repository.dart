import 'dart:developer';

import 'package:e_commerce_test/constatnts/endpoints.dart';
import 'package:e_commerce_test/data/models/all_products_response.dart';
import 'package:e_commerce_test/helpers/api_helper.dart';
import 'package:e_commerce_test/helpers/http_helper.dart';
import 'package:either_dart/either.dart';

import '../models/server_error_model.dart';

class AuthRepository {
  final HttpHelper httpHelper;

  AuthRepository(this.httpHelper);

  Future<Either<ServerErrorModel, dynamic>> login(
      String username, String password) async {
    return await SimplifyApiConsuming.makeRequest<ServerErrorModel, dynamic>(
        () => httpHelper.post(Endpoints.login,
            body: {"username": username, "password": password}),
        successResponse: (response) {
      log("Payment Response: $response");
      return response;
    }, errorResponse: (response) {
      return ServerErrorModel(
          statusCode: response.statusCode!,
          errorMessage: response.data.toString(),
          data: null);
    }, dioErrorResponse: (response) {
      return ServerErrorModel(
          statusCode: 400, errorMessage: response!.data.toString(), data: null);
    });
  }
}
