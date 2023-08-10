import 'package:ecommerce_project/features/auth/cubit/signup_cubit.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/auth/ui/widgets/signup_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        userRepository: context.read<UserRepository>()),
      child: const SignUpWidgets(),
    );
  }
}
