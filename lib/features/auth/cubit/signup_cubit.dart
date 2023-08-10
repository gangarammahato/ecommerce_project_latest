import 'dart:io';

import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  SignupCubit({required this.userRepository}) : super(CommonInitialState());

  signUp({
    required String name,
    required String phone,
    required String address,
    required String email,
    required String password,
    File? profile,
  }) async {
    emit(CommonLoadingState());
    final res = await userRepository.signUp(
      name: name,
      phone: phone,
      address: address,
      email: email,
      password: password,
      profile: profile,
    );
    emit(res.fold((err) => CommonErrorState(message: err),
        (data) => CommonSuccessState(item: null)));
  }
}
