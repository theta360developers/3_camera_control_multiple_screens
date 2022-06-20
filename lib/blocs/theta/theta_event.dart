part of 'theta_bloc.dart';

@immutable
abstract class ThetaEvent extends Equatable {
  const ThetaEvent();

  @override
  List<Object> get props => [];
}

class GetInfoEvent extends ThetaEvent {}

class GetStateEvent extends ThetaEvent {}

class PictureEvent extends ThetaEvent {}

class ListFilesEvent extends ThetaEvent {}

class GetLastUrlEvent extends ThetaEvent {}

class ShowImageEvent extends ThetaEvent {}

class GetListImagesEvent extends ThetaEvent {}

class ShowListImagesEvent extends ThetaEvent {}

class TurnOffLCDEvent extends ThetaEvent {}

class GetOptionsEvent extends ThetaEvent {}

class SetVideoModeEvent extends ThetaEvent {}

class SetImageModeEvent extends ThetaEvent {}

class SetVideo5FPSEvent extends ThetaEvent {}

class SetVideo2FPSEvent extends ThetaEvent {}

class SetImage5KEvent extends ThetaEvent {}

class SetImage11KEvent extends ThetaEvent {}

class StartCaptureEvent extends ThetaEvent {}

class StopCaptureEvent extends ThetaEvent {}
