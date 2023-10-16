import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_commerce_test/data/models/add_to_cart_payload.dart';
import 'package:e_commerce_test/data/models/all_products_response.dart';
import 'package:e_commerce_test/data/repository/products_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ProductsRepository productsRepository;

  final List<Product> cart = [];

  CartBloc(this.productsRepository) : super(CartInitial()) {
    on<CartEvent>((event, emit) {});
    on<AddToCartEvent>(_mapAddToCartEventToState);
  }

  FutureOr<void> _mapAddToCartEventToState(
      AddToCartEvent event, Emitter<CartState> emit) async {
    cart.add(event.product);

    emit(AddToCartLoading());

    try {
      var result = await productsRepository.addToCart(AddToCartPayload(
          userId: 5,
          date: DateTime.now(),
          products: [CartProduct(productId: event.product.id, quantity: 1)]));
      result
          .fold((errorModel) => emit(AddToCartFailure(errorModel.errorMessage)),
              (response) {
        emit(AddToCartSuccess(response));
      });
    } on Exception catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      emit(AddToCartFailure(e.toString()));
    }
  }
}
