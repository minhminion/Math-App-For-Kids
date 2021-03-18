import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/app_dialog.dart';
import 'package:math_app_for_kid/services/app/app_loading.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: AppBar(
            elevation: 0,
            brightness: Brightness.dark,
          ),
        ),
        body: Column(children: [
          Center(child: Text(widget.title ?? "Hello world ")),
          ElevatedButton(
            onPressed: () => AppDialogProvider.show(
              context,
              "Dialog opened",
              title: 'Error',
            ),
            child: Text("Open Dialog"),
          ),
          ElevatedButton(
            onPressed: () => AppLoadingProvider.show(context),
            child: Text("Open Loading"),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (widget.title != null) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, "/dasda");
            }
          },
          child: const Icon(Icons.navigation),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
