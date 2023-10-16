part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddToCartEvent extends CartEvent {
  final Product product;
  const AddToCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}

// class GetUserCartEvent extends CartEvent {
//   final AddToCartPayload payload;
//
//   const AddToCartEvent(this.payload);
//
//   @override
//   List<Object?> get props => [payload];
// }
