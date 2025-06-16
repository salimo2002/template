abstract class ImeiStatus {}

class ImeiSuccessState extends ImeiStatus {
  final List<String> devices;
  final List<String> users;
  final String? message;
  ImeiSuccessState(this.message, {required this.devices,required this.users});
}

class ImeiFaliureState extends ImeiStatus {
  final String errorMessage;

  ImeiFaliureState({required this.errorMessage});
}

class ImeiInitState extends ImeiStatus {}

class ImeiLoadingState extends ImeiStatus {}
