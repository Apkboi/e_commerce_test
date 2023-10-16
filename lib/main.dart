import 'package:e_commerce_test/data/repository/auth_repository.dart';
import 'package:e_commerce_test/data/repository/products_repository.dart';
import 'package:e_commerce_test/helpers/http_helper.dart';
import 'package:e_commerce_test/presentation/blocs/auth/auth_bloc.dart';
import 'package:e_commerce_test/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_test/presentation/blocs/products_bloc.dart';
import 'package:e_commerce_test/presentation/screens/all_products_screen.dart';
import 'package:e_commerce_test/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<ProductsBloc>(
            create: (context) =>
                ProductsBloc(ProductsRepository(HttpHelper()))),
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(AuthRepository(HttpHelper()))),
        BlocProvider<CartBloc>(
            create: (context) => CartBloc(ProductsRepository(HttpHelper())))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
