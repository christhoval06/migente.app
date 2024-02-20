import 'package:flutter/material.dart';
import 'package:mi_gente/ui/widgets/render_if_view.dart';

class FutureStatView<T> extends StatelessWidget {
  final String? title;
  final Function(T?) render;
  final Future<T> future;
  final Function(BuildContext)? onPress;
  final IconData icon;

  final double? width;
  final double? height;
  final double? widthFactor;

  const FutureStatView(
      {super.key,
      required this.render,
      required this.future,
      this.title,
      this.onPress,
      this.icon = Icons.refresh,
      this.height = 200,
      this.widthFactor = 0.45,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
        width: width != null
            ? width!
            : MediaQuery.of(context).size.width * widthFactor!,
        height: height,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RenderIfView(
                    condition: title != null,
                    child: Text(title ?? '',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600))),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: FutureBuilder(
                            future: future,
                            builder: (BuildContext context,
                                AsyncSnapshot<T> snapshot) {
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
                                        stackTrace: snapshot.stackTrace,
                                        label: 'app.mi.gente');
                                    return const Center(child: Text('Error'));
                                  }

                                  return render(snapshot.data);
                                default:
                                  return Container();
                              }
                            })))
              ],
            ),
          ),
        ),
      ),
      RenderIfView(
          condition: onPress != null,
          child: Positioned(
              top: 0.5,
              right: 0.5,
              child: IconButton(
                icon: Icon(icon),
                onPressed: () {
                  onPress!(context);
                },
              )))
    ]);
  }
}
