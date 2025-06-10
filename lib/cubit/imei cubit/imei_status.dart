abstract class ImeiStatus {}

class ImeiSuccessState extends ImeiStatus {
  final List<String> devices;
  final String? message;
  ImeiSuccessState(this.message, {required this.devices});
}

class ImeiFaliureState extends ImeiStatus {
  final String errorMessage;

  ImeiFaliureState({required this.errorMessage});
}

class ImeiInitState extends ImeiStatus {}

class ImeiLoadingState extends ImeiStatus {}
