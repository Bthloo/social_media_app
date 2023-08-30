import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socila_app/custom_widget/dialog.dart';

import '../../custom_widget/custom_form_field.dart';
import '../../view model/register_view_model.dart';
import '../login_screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  static const String routeName = 'register';
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  var registerViewModel = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
        ),
        body: BlocConsumer<RegisterViewModel, RegisterViewState>(
          bloc: registerViewModel,
          listenWhen: (previous, current) {
            if (previous is LoadingState) {
              DialogUtilities.hideDialog(context);
            }
            if (current is SuccessState ||
                current is LoadingState ||
                current is FailState) {
              return true;
            }
            return false;
          },
          buildWhen: (previous, current) {
            if (current is InitialState) return true;
            return false;
          },
          listener: (context, state) {
            // event
            if (state is FailState) {
              // show message
              DialogUtilities.showMessage(
                  context,
                  state.message ??
                      state.exception?.toString() ??
                      "Something Went Wrong",
                  posstiveActionName: "ok");
            } else if (state is LoadingState) {
              //show loading...
              DialogUtilities.ShowLoadingDialog(
                  context, state.loadingMessage ?? "Loading...");
            } else if (state is SuccessState) {
              if (state.response.success == true) {
                DialogUtilities.showMessage(
                    context, "User Registered Successfully",
                    posstiveActionName: "ok", posstiveAction: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                });
              } else {
                DialogUtilities.showMessage(
                  context,
                  state.response.statusMessage ?? '',
                  posstiveActionName: "ok",
                );
              }
              // show dialog
              // navigate to home screen
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Full Name',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        hintlText: 'Enter Your Full Name',
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'E-mail address',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        hintlText: 'Enter Your E-mail address',
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please Enter Email Address';
                          }
                          return null;
                        },
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        hintlText: 'Enter Your Password',
                        validator: (text) {
                          if (text == null ||
                              text.trim().isEmpty ||
                              text.length < 6) {
                            return 'The Password Must at least 6 characters';
                          }
                          return null;
                        },
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Re-Password',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        hintlText: 'Enter Your Re-Password',
                        validator: (text) {
                          if (passwordController.text != text) {
                            return "Password Doesn't Match";
                          }
                          return null;
                        },
                        controller: rePasswordController,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          register();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('You Have an Account ?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: const Text(
                              'Login',
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  void register() async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    registerViewModel.register(
        nameController.text, emailController.text, passwordController.text);
  }
}
