part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class GetAllProductsEvent extends ProductsEvent {
  @override
  List<Object?> get props => [];
}
