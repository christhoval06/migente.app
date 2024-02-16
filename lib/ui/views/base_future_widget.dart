import 'package:flutter/material.dart';

class BaseFutureWidget<T> extends StatelessWidget {
  final Function(T?) renderChildren;
  final Future<T>? future;

  const BaseFutureWidget(
      {super.key, required this.renderChildren, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                debugPrintStack(
                    stackTrace: snapshot.stackTrace, label: 'app.mi.gente');
                return const Center(child: Text('Error Loading data...'));
              }

              return renderChildren(snapshot.data);
            default:
              return Container();
          }
        });
  }
}
