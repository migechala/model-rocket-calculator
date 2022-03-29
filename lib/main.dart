import 'package:flutter/material.dart';
import 'package:modelrocketcalculator/get_info.dart';
import 'package:modelrocketcalculator/math.dart';
import 'package:modelrocketcalculator/show_info.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Model Rocket Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const GetFork(title: "Calculator"),
    );
  }
}

class ShowResults extends StatelessWidget {
  ShowResults({Key? key, required this.title, required this.math})
      : super(key: key) {
    this._velocity = math.velocity;
    this._burntime = math.burnTime;
    this._totalTime = math.totalTime;
    this._boostDistance = math.boostDistance;
    this._coastDistance = math.coastDistance;
    this._totalAltitude = math.totalAltitude;
    this._mass = math.mass;
    this._area = math.area;
  }

  final String title;

  final Math math;

  late double _velocity;
  late double _burntime;
  late double _totalTime;
  late double _boostDistance;
  late double _coastDistance;
  late double _totalAltitude;
  late double _mass;
  late double _area;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/launch.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            ShowInfo(dataName: "Mass", data: _mass.toString(), unit: "kg"),
            ShowInfo(dataName: "Area", data: _area.toString(), unit: "m^2"),
            ShowInfo(
                dataName: "Velocity at burnout",
                data: _velocity.toString(),
                unit: "m/s"),
            ShowInfo(
                dataName: "Burnout time",
                data: _burntime.toString(),
                unit: "seconds"),
            ShowInfo(
                dataName: "Total time",
                data: _totalTime.toString(),
                unit: "seconds"),
            ShowInfo(
                dataName: "Boost distance",
                data: _boostDistance.toString(),
                unit: "meters"),
            ShowInfo(
                dataName: "Coast distance",
                data: _coastDistance.toString(),
                unit: "meters"),
            ShowInfo(
                dataName: "Total altitude",
                data: _totalAltitude.toString(),
                unit: "meters"),
            ElevatedButton(
                onPressed: (() {
                  Navigator.pop(context);
                }),
                child: const Text("Try a Different Rocket"))
          ],
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Please fill in the form with valid numbers'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("A value that you have entered is invalid"),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}

class GetFork extends StatelessWidget {
  const GetFork({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/launch.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ElevatedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GetAutomaticInformation()),
                  );
                }),
                child: const Text(
                  "Get Automatic Data",
                  textScaleFactor: 2,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ElevatedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GetRocketInformation(title: title)),
                  );
                }),
                child: const Text(
                  "Set Manual Data",
                  textScaleFactor: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GetAutomaticInformation extends StatelessWidget {
  const GetAutomaticInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GetRocketInformation extends StatelessWidget {
  GetRocketInformation({Key? key, required this.title}) : super(key: key);

  final String title;

  final dController = TextEditingController();
  final wController = TextEditingController();
  final iController = TextEditingController();
  final tController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/launch.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            GetInfo(
                controller: dController,
                hintText: "Rocket Diameter (in inches)"),
            GetInfo(
                controller: wController,
                hintText: "Rocket Weight (in kilograms)"),
            GetInfo(controller: iController, hintText: "Rocket Impulsion"),
            GetInfo(controller: tController, hintText: "Rocket Thrust"),
            Column(
              children: [
                ElevatedButton(
                  onPressed: (() {
                    if (double.parse(dController.text) != 0 &&
                        double.parse(wController.text) != 0 &&
                        double.parse(iController.text) != 0 &&
                        double.parse(tController.text) != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowResults(
                            title: title,
                            math: Math(
                              diameter: double.parse(dController.text),
                              weight: double.parse(wController.text),
                              impulsion: double.parse(iController.text),
                              thrust: double.parse(tController.text),
                            ),
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    }
                  }),
                  child: const Text("Calculate!"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


/*
  * ----------------------------------------------------------------

  * Test values
    !weight = 1.9
    !diameter = 0.976 inches
    !thrust = 6
    !impulsion =  9

  * ----------------------------------------------------------------
*/