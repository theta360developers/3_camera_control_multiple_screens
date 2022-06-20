import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theta_bloc_app/view/screens/video_settings.dart';

import '../../blocs/theta/theta_bloc.dart';

class ButtonColumn extends StatelessWidget {
  const ButtonColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  context.read<ThetaBloc>().add(GetInfoEvent());
                },
                child: const Text(
                  "Info",
                  style: TextStyle(
                      fontFamily: 'BaksoSapi',
                      fontSize: 20,
                      color: Color.fromARGB(255, 252, 143, 179)),
                )),
            TextButton(
                onPressed: () {
                  context.read<ThetaBloc>().add(GetStateEvent());
                },
                child: const Text(
                  "State",
                  style: TextStyle(
                      fontFamily: 'BaksoSapi',
                      fontSize: 20,
                      color: Color.fromARGB(255, 252, 143, 179)),
                )),
            TextButton(
                onPressed: () {
                  context.read<ThetaBloc>().add(PictureEvent());
                },
                child: const Text(
                  "Take Pic",
                  style: TextStyle(
                      fontFamily: 'BaksoSapi',
                      fontSize: 20,
                      color: Color.fromARGB(255, 252, 143, 179)),
                )),
            TextButton(
                onPressed: () {
                  context.read<ThetaBloc>().add(ListFilesEvent());
                },
                child: const Text(
                  "List Files",
                  style: TextStyle(
                      fontFamily: 'BaksoSapi',
                      fontSize: 20,
                      color: Color.fromARGB(255, 252, 143, 179)),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  context.read<ThetaBloc>().add(GetLastUrlEvent());
                },
                child: const Text(
                  "Get Last Url",
                  style: TextStyle(
                      fontFamily: 'BaksoSapi',
                      fontSize: 20,
                      color: Color.fromARGB(255, 172, 120, 227)),
                )),
            TextButton(
                onPressed: () {
                  context.read<ThetaBloc>().add(GetListImagesEvent());
                },
                child: const Text(
                  "Get List Images",
                  style: TextStyle(
                      fontFamily: 'BaksoSapi',
                      fontSize: 20,
                      color: Color.fromARGB(255, 172, 120, 227)),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  context.read<ThetaBloc>().add(ShowImageEvent());
                },
                child: const Text(
                  "Show Image",
                  style: TextStyle(
                      fontFamily: 'BaksoSapi',
                      fontSize: 20,
                      color: Color.fromARGB(255, 87, 194, 137)),
                )),
            TextButton(
                onPressed: () {
                  context.read<ThetaBloc>().add(ShowListImagesEvent());
                },
                child: const Text(
                  "Show List Images",
                  style: TextStyle(
                      fontFamily: 'BaksoSapi',
                      fontSize: 20,
                      color: Color.fromARGB(255, 87, 194, 137)),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  context.read<ThetaBloc>().add(TurnOffLCDEvent());
                },
                child: Text(
                  "Turn Off LCD",
                  style: TextStyle(
                      fontFamily: 'BaksoSapi',
                      fontSize: 20,
                      color: Color.fromARGB(255, 87, 128, 194)),
                )),
            TextButton(
                onPressed: () {
                  context.read<ThetaBloc>().add(GetOptionsEvent());
                },
                child: Text(
                  'Get options',
                  style: TextStyle(
                      fontFamily: 'BaksoSapi',
                      fontSize: 20,
                      color: Color.fromARGB(255, 87, 128, 194)),
                ))
          ],
        )
      ],
    );
  }
}
