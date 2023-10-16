import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_test/data/models/all_products_response.dart';
import 'package:e_commerce_test/data/repository/products_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository;

  ProductsBloc(this.productsRepository) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) {});
    on<GetAllProductsEvent>(_mapGetAllProductsEventToState);
  }

  FutureOr<void> _mapGetAllProductsEventToState(
      GetAllProductsEvent event, Emitter<ProductsState> emit) async {
    emit(GetAllProductsLoadingState());

    try {
      var result = await productsRepository.getAllProducts();

      result.fold(
          (errorModel) =>
              emit(GetAllProductsFailureState(errorModel.errorMessage)),
          (response) {
        emit(GetAllProductsSuccessState(response));
      });
    } on Exception catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      emit(GetAllProductsFailureState(e.toString()));
    }
  }
}
