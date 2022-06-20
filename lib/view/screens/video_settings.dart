import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theta_bloc_app/blocs/theta/theta_bloc.dart';

class VideoSettings extends StatelessWidget {
  const VideoSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThetaBloc, ThetaState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black54,
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Shooting \n Settings',
                    style: TextStyle(
                        fontFamily: 'BaksoSapi',
                        fontSize: 50,
                        color: Color.fromARGB(255, 86, 86, 86)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: () {
                          context.read<ThetaBloc>().add(SetVideoModeEvent());
                        },
                        icon: Icon(
                          Icons.videocam,
                          size: 40,
                          color: Color.fromARGB(255, 172, 120, 227),
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: () {
                          context.read<ThetaBloc>().add(SetImageModeEvent());
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Color.fromARGB(255, 252, 143, 179),
                        )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                        onPressed: () {
                          context.read<ThetaBloc>().add(StartCaptureEvent());
                        },
                        child: Text(
                          "Start",
                          style: TextStyle(
                              color: Color.fromARGB(255, 172, 120, 227)),
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        context.read<ThetaBloc>().add(StopCaptureEvent());
                      },
                      child: Text(
                        "Stop",
                        style: TextStyle(
                            color: Color.fromARGB(255, 172, 120, 227)),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        context.read<ThetaBloc>().add(SetVideo2FPSEvent());
                      },
                      child: Text(
                        "8K 2fps",
                        style: TextStyle(
                            fontFamily: 'RainyHearts',
                            fontSize: 30,
                            color: Color.fromARGB(255, 172, 120, 227)),
                      )),
                  TextButton(
                      onPressed: () {
                        context.read<ThetaBloc>().add(SetVideo5FPSEvent());
                      },
                      child: Text(
                        "8K 5fps",
                        style: TextStyle(
                            fontFamily: 'RainyHearts',
                            fontSize: 30,
                            color: Color.fromARGB(255, 172, 120, 227)),
                      )),
                  TextButton(
                      onPressed: () {
                        context.read<ThetaBloc>().add(SetImage5KEvent());
                      },
                      child: Text(
                        "5.5K",
                        style: TextStyle(
                            fontFamily: 'RainyHearts',
                            fontSize: 30,
                            color: Color.fromARGB(255, 252, 143, 179)),
                      )),
                  TextButton(
                      onPressed: () {
                        context.read<ThetaBloc>().add(SetImage11KEvent());
                      },
                      child: Text(
                        "11K",
                        style: TextStyle(
                            fontFamily: 'RainyHearts',
                            fontSize: 30,
                            color: Color.fromARGB(255, 252, 143, 179)),
                      ))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
