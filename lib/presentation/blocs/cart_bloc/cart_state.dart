part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

// Loading state for adding items to the cart
class AddToCartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

// Success state for adding items to the cart
class AddToCartSuccess extends CartState {
  final dynamic response;

  const AddToCartSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

// Failure state for adding items to the cart
class AddToCartFailure extends CartState {
  final String error;

  const AddToCartFailure(this.error);

  @override
  List<Object?> get props => [error];
}
