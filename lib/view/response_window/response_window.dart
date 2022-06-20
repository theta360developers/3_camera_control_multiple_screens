import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theta_bloc_app/view/screens/full_image_screen.dart';

import '../../blocs/theta/theta_bloc.dart';

class ResponseWindow extends StatelessWidget {
  const ResponseWindow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThetaBloc, ThetaState>(
      builder: (context, state) {
        if (context.watch<ThetaBloc>().state.showImage) {
          print('show image');
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FullImageScreen(fileUrl: state.lastImageUrl)));
              },
              child: Image.network('${state.lastImageUrl}?type=thumb'));
        } else if (state.urlList.isNotEmpty) {
          print('show list of images');

          return ListView.builder(
              itemCount: state.urlList.length,
              itemBuilder: ((context, index) {
                var fileUrl = state.urlList[index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FullImageScreen(fileUrl: fileUrl)));
                    },
                    child: Image.network('${state.urlList[index]}?type=thumb'));
              }));
        } else if (context.watch<ThetaBloc>().state.showMessage) {
          return SelectableText(state.message);
        } else {
          return Text('camera response');
        }
      },
    );
  }
}
