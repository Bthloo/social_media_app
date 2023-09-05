import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socila_app/providers/auth_provider.dart';

import '../../custom_widget/custom_form_field.dart';
import '../../custom_widget/dialog.dart';
import '../../view model/login_view_model.dart';
import '../home/home_screen.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName = 'login';
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: BlocConsumer<LoginViewModel, LoginViewState>(
            bloc: viewModel,
            listenWhen: (previous, current) {
              if (previous is LoginLoadingState) {
                DialogUtilities.hideDialog(context);
              }
              if (current is LoginSuccessState ||
                  current is LoginLoadingState ||
                  current is LoginFailState) {
                return true;
              }
              return false;
            },
            buildWhen: (previous, current) {
              if (current is LoginInitialState) return true;
              return false;
            },
            listener: (context, state) {
              // event
              if (state is LoginFailState) {
                // show message
                DialogUtilities.showMessage(
                    context,
                    state.message ??
                        state.exception?.toString() ??
                        "Something Went Wrong",
                    posstiveActionName: "ok");
              } else if (state is LoginLoadingState) {
                //show loading...
                DialogUtilities.ShowLoadingDialog(
                    context, state.loadingMessage ?? "Loading...");
              } else if (state is LoginSuccessState) {
                if (state.response?.success == true) {
                  DialogUtilities.showMessage(context, "Logedin Successfully",
                      posstiveActionName: "ok", posstiveAction: () async {
                    AuthProvider userProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    userProvider.currentUser = state.response?.results;

                    //keepLogin(c);
                    // final String? action = prefs.getString('action');
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString(
                        'token', userProvider.currentUser?.accessToken ?? "");
                    await prefs.setInt(
                        "id", userProvider.currentUser?.userId ?? 0);
                    userProvider.token = prefs.getString('token');
                    userProvider.id = prefs.getInt('id');

                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  });
                } else if (state.response?.success == false) {
                  DialogUtilities.showMessage(
                    context,
                    " ${state.response?.statusMessage}",
                    posstiveActionName: "Ok",
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Welcome Back To فسبك',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Please sign in with your mail',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 40,
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
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't Have an Account ?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, RegisterScreen.routeName);
                                },
                                child: const Text('Register'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  void register() async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    viewModel.login(
        email: emailController.text, password: passwordController.text);
  }

  static void keepLogin(String string) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', string);
  }
}
