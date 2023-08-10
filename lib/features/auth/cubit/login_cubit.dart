import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  LoginCubit({required this.userRepository}) : super(CommonInitialState());

  logIn({required String email, required String password}) async {
    emit(CommonLoadingState());
    final res = await userRepository.logIn(
      email: email,
      password: password,
    );
    emit(res.fold(
      (err) => CommonErrorState(message: err), 
      (data) => CommonSuccessState(item: null),
      ));
  }
}
