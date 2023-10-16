import 'package:e_commerce_test/helpers/custom_snackbar.dart';
import 'package:e_commerce_test/presentation/blocs/auth/auth_bloc.dart';
import 'package:e_commerce_test/presentation/components/filled_textfield.dart';
import 'package:e_commerce_test/presentation/screens/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                CustomSnackBar.showSuccess(context,
                    message: "Welcome", action: () {});

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllProductsScreen(),
                    ));
              }
              if (state is LoginFailureState) {
                CustomSnackBar.showError(context,
                    message: state.error, action: () {});
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FilledTextField(
                      hint: 'Username',
                      outline: true,
                      controller: _usernameController,
                      validator: RequiredValidator(errorText: "Enter username"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FilledTextField(
                      hint: 'Password',
                      outline: true,
                      controller: _passwordController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Enter password'),
                        MinLengthValidator(6,
                            errorText: 'Password should be up to 6 characters')
                      ]),
                      inputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(18),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          _login(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...state is LoginLoadingState
                                ? [const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),]
                                : [
                              const Text('Login')
                                  ],
                          ],
                        ))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEvent(
          username: _usernameController.text,
          password: _passwordController.text));
    }
  }
}
