import 'package:dp2papp/presentation/widgets/active_symbol_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deriv App Sample")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Active Symbol"),
          ),
          ActiveSymbolsWidget(),
        ],
      ),
    );
  }
}
