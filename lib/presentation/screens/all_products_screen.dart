import 'package:e_commerce_test/presentation/blocs/products_bloc.dart';
import 'package:e_commerce_test/presentation/components/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ProductsBloc>(context).add(GetAllProductsEvent());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ProductsBloc, ProductsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetAllProductsLoadingState) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()),
                      ),
                    );
                  }
                  if (state is GetAllProductsFailureState) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  if (state is GetAllProductsSuccessState) {
                    return GridView.builder(
                      itemCount: state.response.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.5,
                              mainAxisSpacing: 3),
                      itemBuilder: (context, index) => ProductItem(
                        product: state.response[index],
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
