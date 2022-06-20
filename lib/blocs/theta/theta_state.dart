part of 'theta_bloc.dart';

@immutable
class ThetaState extends Equatable {
  final String message;
  final bool showImage;
  final bool showMessage;
  final String lastImageUrl;
  final List<String> urlList;
  static const List<String> emptyList = [];

  const ThetaState(
      {required this.message,
      this.showMessage = true,
      this.showImage = false,
      this.lastImageUrl = "",
      this.urlList = emptyList});

  factory ThetaState.initial() => ThetaState(message: "Response from Camera");

  ThetaState copyWith({
    String? message,
  }) {
    return ThetaState(
      message: message ?? this.message,
    );
  }

  @override
  String toString() => 'ThetaState(message: $message)';

  @override
  List<Object> get props => [message];
}
