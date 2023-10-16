import 'dart:developer';

import 'package:e_commerce_test/constatnts/endpoints.dart';
import 'package:e_commerce_test/data/models/add_to_cart_payload.dart';
import 'package:e_commerce_test/data/models/all_products_response.dart';
import 'package:e_commerce_test/helpers/api_helper.dart';
import 'package:e_commerce_test/helpers/http_helper.dart';
import 'package:either_dart/either.dart';

import '../models/server_error_model.dart';

class ProductsRepository {
  final HttpHelper httpHelper;

  ProductsRepository(this.httpHelper);

  Future<Either<ServerErrorModel, List<Product>>> getAllProducts() async {
    return await SimplifyApiConsuming.makeRequest<ServerErrorModel,
            List<Product>>(
        () => httpHelper.get(
              Endpoints.getProducts,
            ), successResponse: (response) {
      log("Payment Response: $response");
      return (response as List).map((e) => Product.fromJson(e)).toList();
    }, errorResponse: (response) {
      return ServerErrorModel(
          statusCode: response.statusCode!,
          errorMessage: response.data.toString(),
          data: null);
    }, dioErrorResponse: (response) {
      return ServerErrorModel(
          statusCode: 400, errorMessage: response?.data['message'], data: null);
    });
  }

  Future<Either<ServerErrorModel, dynamic>> addToCart(
      AddToCartPayload payload) async {
    return await SimplifyApiConsuming.makeRequest<ServerErrorModel,
            List<Product>>(
        () => httpHelper.post(Endpoints.addToCart, body: payload.toJson()),
        successResponse: (response) {
      // log("Payment Response: $response");
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
