import 'package:flutter/material.dart';
import 'package:theta_bloc_app/blocs/theta/theta_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theta_bloc_app/view/components/main_drawer.dart';

import 'view/button/button_column.dart';
import 'view/screens/video_settings.dart';
import 'view/response_window/response_window.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThetaBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black45,
              ),
              drawer: const MainDrawer(),
              body: BlocBuilder<ThetaBloc, ThetaState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              'Main',
                              style: TextStyle(
                                  fontFamily: 'BaksoSapi',
                                  fontSize: 50,
                                  color: Color.fromARGB(255, 86, 86, 86)),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(flex: 4, child: ButtonColumn()),
                      const Expanded(flex: 4, child: ResponseWindow()),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
