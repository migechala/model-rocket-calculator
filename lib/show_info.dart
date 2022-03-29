import 'package:flutter/material.dart';

class ShowInfo extends StatelessWidget {
  const ShowInfo(
      {Key? key,
      required this.dataName,
      required this.unit,
      required this.data})
      : super(key: key);

  final String data;
  final String unit;
  final String dataName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Card(
            color: Colors.blueGrey.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50,
              child: Column(
                children: [
                  Text(dataName, textScaleFactor: 2.0),
                  Text("$data $unit"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
