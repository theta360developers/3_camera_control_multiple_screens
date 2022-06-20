import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'theta_event.dart';
part 'theta_state.dart';

class ThetaBloc extends Bloc<ThetaEvent, ThetaState> {
  ThetaBloc() : super(ThetaState.initial()) {
    on<GetInfoEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/info');
      var response = await http.get(url);
      var encoder = JsonEncoder.withIndent('  ');
      var formattedResponse = encoder.convert(jsonDecode(response.body));
      emit(ThetaState(message: formattedResponse));
    });
    on<GetStateEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/state');
      var response = await http.post(url);
      var encoder = JsonEncoder.withIndent('  ');
      var formattedResponse = encoder.convert(jsonDecode(response.body));
      emit(ThetaState(message: formattedResponse));
    });
    on<PictureEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {'name': 'camera.takePicture'};
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    });
    on<ListFilesEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.listFiles',
        'parameters': {
          'fileType': 'image',
          'startPosition': 0,
          'entryCount': 1,
          'maxThumbSize': 0,
          '_detail': true,
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      var encoder = JsonEncoder.withIndent('  ');
      var formattedResponse = encoder.convert(jsonDecode(response.body));
      emit(ThetaState(message: formattedResponse));
      print(state.urlList.isEmpty);
    });
    on<GetLastUrlEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.listFiles',
        'parameters': {
          'fileType': 'image',
          'startPosition': 0,
          'entryCount': 1,
          'maxThumbSize': 0,
          '_detail': true,
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      var thetaFiles = jsonDecode(response.body);
      var fileUrl = thetaFiles['results']['entries'][0]['fileUrl'];
      //print(response.body);
      emit(ThetaState(message: fileUrl));
    });
    on<ShowImageEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.listFiles',
        'parameters': {
          'fileType': 'image',
          'startPosition': 0,
          'entryCount': 1,
          'maxThumbSize': 0
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      var thetaFiles = jsonDecode(response.body);

      var fileUrl = thetaFiles['results']['entries'][0]['fileUrl'];

      emit(ThetaState(
          message: 'url here', showImage: true, lastImageUrl: fileUrl));
    });

    on<GetListImagesEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.listFiles',
        'parameters': {
          'fileType': 'image',
          'startPosition': 0,
          'entryCount': 10,
          'maxThumbSize': 0
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      var thetaFiles = jsonDecode(response.body);
      var filesList = [];
      // int index = 10;
      // if (thetaFiles['results']['entries'].length < 10) {
      //   index = thetaFiles['results']['entries'].length;
      // }
      for (int i = 0; i < 10; i++) {
        filesList.add(thetaFiles['results']['entries'][i]['fileUrl']);
      }
      var filesResponse = filesList.toString();

      emit(ThetaState(
          message: filesResponse, showMessage: true, showImage: false));
      print(state.urlList.isEmpty);
    });
    on<ShowListImagesEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.listFiles',
        'parameters': {
          'fileType': 'image',
          'startPosition': 0,
          'entryCount': 10,
          'maxThumbSize': 0
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      var thetaFiles = jsonDecode(response.body);
      List<String> filesList = [];
      // int index = 10;
      // if (thetaFiles['results']['entries'].length < 10) {
      //   index = thetaFiles['results']['entries'].length;
      // }
      for (int i = 0; i < 10; i++) {
        filesList.add(thetaFiles['results']['entries'][i]['fileUrl']);
      }

      emit(ThetaState(message: '', showImage: false, urlList: filesList));
      print(state.urlList.isEmpty);
    });
    on<TurnOffLCDEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.setOptions',
        'parameters': {
          'options': {'_cameraControlSource': 'app'}
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    });
    on<GetOptionsEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.getOptions',
        'parameters': {
          'optionNames': ['_cameraControlSource']
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    });
    on<SetVideoModeEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.setOptions',
        'parameters': {
          'options': {'captureMode': 'video'}
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    });
    on<SetImageModeEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.setOptions',
        'parameters': {
          'options': {'captureMode': 'image'}
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    });
    on<SetVideo2FPSEvent>(((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.setOptions',
        'parameters': {
          'options': {
            'fileFormat': {
              'type': 'mp4',
              'width': 7680,
              'height': 3840,
              '_codec': 'H.264/MPEG-4 AVC',
              '_frameRate': 2
            }
          }
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    }));
    on<SetVideo5FPSEvent>(((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.setOptions',
        'parameters': {
          'options': {
            'fileFormat': {
              'type': 'mp4',
              'width': 7680,
              'height': 3840,
              '_codec': 'H.264/MPEG-4 AVC',
              '_frameRate': 5
            }
          }
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    }));
    on<SetImage11KEvent>(((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.setOptions',
        'parameters': {
          'options': {
            'fileFormat': {
              'type': 'jpeg',
              'width': 11008,
              'height': 5504,
            }
          }
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    }));
    on<SetImage5KEvent>(((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.setOptions',
        'parameters': {
          'options': {
            'fileFormat': {
              'type': 'jpeg',
              'width': 5504,
              'height': 2752,
            }
          }
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    }));
    on<StartCaptureEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {'name': 'camera.startCapture'};
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    });
    on<StopCaptureEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {'name': 'camera.stopCapture'};
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(ThetaState(message: response.body));
    });
  }
}
