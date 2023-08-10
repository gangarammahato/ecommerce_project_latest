import 'package:ecommerce_project/features/auth/cubit/login_cubit.dart';
import 'package:ecommerce_project/features/auth/cubit/social_login_cubit.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/auth/ui/widgets/login_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LoginCubit(userRepository: context.read<UserRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              SocialLoginCubit(userRepository: context.read<UserRepository>()),
        ),
      ],
      child: const LoginWidgets(),
    );
  }
}
