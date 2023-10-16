part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class GetAllProductsLoadingState extends ProductsState {
  @override
  List<Object> get props => [];
}

class GetAllProductsSuccessState extends ProductsState {
  final List<Product> response;

  const GetAllProductsSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class GetAllProductsFailureState extends ProductsState {
  final String error;

  const GetAllProductsFailureState(this.error);

  @override
  List<Object> get props => [error];
}
