sealed class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {
  final bool showLoading;
  CommonLoadingState({this.showLoading = true});
}

class CommonErrorState extends CommonState {
  final String message;

  CommonErrorState({required this.message});
}

class CommonSuccessState<T> extends CommonState {
  final T item;

  CommonSuccessState({required this.item});
}
