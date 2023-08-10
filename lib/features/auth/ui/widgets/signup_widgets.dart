// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/button/custom_rounded_buttom.dart';
import 'package:ecommerce_project/common/text_field/custom_text_form_field.dart';
import 'package:ecommerce_project/common/utils/snakbar_utils.dart';
import 'package:ecommerce_project/features/auth/cubit/signup_cubit.dart';
import 'package:ecommerce_project/features/auth/ui/pages/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpWidgets extends StatefulWidget {
  const SignUpWidgets({super.key});

  @override
  State<SignUpWidgets> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpWidgets> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  File? profilePicture;

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: BlocListener<SignupCubit, CommonState>(
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
                    Navigator.pop(context);
                  }
                },
                child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                DottedBorder(
                                  borderType: BorderType.Circle,
                                  dashPattern: const [6],
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: profilePicture == null
                                          ? const Icon(
                                              Icons.person,
                                              size: 60,
                                            )
                                          : Image.file(
                                              profilePicture!,
                                              fit: BoxFit.cover,
                                              height: 80,
                                              width: 80,
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () async {
                                      final imagePicker = ImagePicker();
                                      final res = await imagePicker.pickImage(
                                          source: ImageSource.gallery);
                                      if (res != null) {
                                        setState(() {
                                          profilePicture = File(res.path);
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Text(
                          "Full Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                        CustomTextFormField(
                          controller: _nameController,
                          label: "Full Name",
                          validator: (value) {
                            if (value == null) {
                              return "Please Fill the full name";
                            } else if (value.isEmpty) {
                              return "Please fill the full name ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Text(
                          "Phone Number",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                        CustomTextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          label: "Phone Number",
                          validator: (value) {
                            if (value == null) {
                              return "Please Fill the phone number";
                            } else if (value.isEmpty) {
                              return "Please Fill the phone number ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Text(
                          "Address",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                        CustomTextFormField(
                          controller: _addressController,
                          label: "Address",
                          validator: (value) {
                            if (value == null) {
                              return "Please Fill the address";
                            } else if (value.isEmpty) {
                              return "Please Fill the address ";
                            } else {
                              return null;
                            }
                          },
                        ),
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
                        const Text(
                          "Confirm-Password",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                        CustomTextFormField(
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: "Confirm-Password",
                          validator: (value) {
                            if (value == null) {
                              return "Please Fill the confirm-password";
                            } else if (value.isEmpty) {
                              return "Please Fill the confirm-password ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomRoundedButton(
                          title: "Sign Up",
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              context.read<SignupCubit>().signUp(
                                    name: _nameController.text,
                                    phone: _phoneNumberController.text,
                                    address: _addressController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    profile: profilePicture!,
                                  );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                              text: TextSpan(
                                  text: "I have already an account?   ",
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: "Login",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
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
      ),
    );
  }
}
