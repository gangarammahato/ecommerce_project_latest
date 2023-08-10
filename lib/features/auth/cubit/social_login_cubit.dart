import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  SocialLoginCubit({required this.userRepository})
      : super(CommonInitialState());

  loginViaFacebook() async {
    emit(CommonLoadingState());
    final res = await userRepository.facebookLogIn();

    emit(res.fold((err) => CommonErrorState(message: err), 
    (data) => CommonSuccessState(item: null)));
  }

  loginViaGoogle() async {
    emit(CommonLoadingState());
    final res = await userRepository.googleLogIn();

    emit(res.fold((err) => CommonErrorState(message: err), 
    (data) => CommonSuccessState(item: null)));
  }
}
