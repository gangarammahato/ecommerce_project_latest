import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/button/custom_icon_buttom.dart';
import 'package:ecommerce_project/common/button/custom_rounded_buttom.dart';
import 'package:ecommerce_project/common/text_field/custom_text_form_field.dart';
import 'package:ecommerce_project/common/utils/snakbar_utils.dart';
import 'package:ecommerce_project/features/auth/cubit/login_cubit.dart';
import 'package:ecommerce_project/features/auth/cubit/social_login_cubit.dart';
import 'package:ecommerce_project/features/auth/ui/pages/signup_page.dart';
import 'package:ecommerce_project/features/dashboard/ui/pages/dashboard_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({super.key});

  @override
  State<LoginWidgets> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginWidgets> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
            child: MultiBlocListener(
              listeners:[
                BlocListener<LoginCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  setState(() {
                    isLoading = true;
                  });
                } else if (state is CommonErrorState) {
                  setState(() {
                    isLoading = false;
                  });
                }
                if (state is CommonErrorState) {
                  SnakbarUtils.showMessage(
                      context: context, message: state.message);
                } else if (state is CommonSuccessState) {
                  SnakbarUtils.showMessage(
                      context: context, message: "User register Succefully");
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: const DashboardPage(),
                          type: PageTransitionType.fade),
                      (route) => false);
                }
              },
                ),

                BlocListener<SocialLoginCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  setState(() {
                    isLoading = true;
                  });
                } else if (state is CommonErrorState) {
                  setState(() {
                    isLoading = false;
                  });
                }
                if (state is CommonErrorState) {
                  SnakbarUtils.showMessage(
                      context: context, message: state.message);
                } else if (state is CommonSuccessState) {
                  SnakbarUtils.showMessage(
                      context: context, message: "User register Succefully");
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: const DashboardPage(),
                          type: PageTransitionType.fade),
                      (route) => false);
                }
              },
                )
              ], 
              child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email Address",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        label: "email@gmail.com",
                        validator: (value) {
                          if (value == null) {
                            return "Please Fill the email";
                          } else if (value.isEmpty) {
                            return "Please Fill the email ";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        label: "Password",
                        validator: (value) {
                          if (value == null) {
                            return "Please Fill the password";
                          } else if (value.isEmpty) {
                            return "Please Fill the password ";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRoundedButton(
                        title: "Login",
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            context.read<LoginCubit>().logIn(
                                email: _emailController.text,
                                password: _passwordController.text);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconButton(
                            colors: Colors.grey.shade400,
                            iconColor: Colors.yellowAccent,
                            icon: Icons.mail,
                            iconSize: 30,
                            onPressed: () {
                              context
                                  .read<SocialLoginCubit>()
                                  .loginViaGoogle();
                            },
                          ),
                          CustomIconButton(
                            colors: Colors.grey.shade400,
                            iconColor: Colors.blue,
                            icon: Icons.facebook,
                            iconSize: 30,
                            onPressed: () {
                              context
                                  .read<SocialLoginCubit>()
                                  .loginViaFacebook();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(
                                text: "Don't have an account?   ",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                                children: <TextSpan>[
                              TextSpan(
                                text: "Sign Up",
                                style: const TextStyle(
                                  color: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPage()),
                                    );
                                  },
                              )
                            ])),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
