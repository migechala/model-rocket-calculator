import 'dart:math';

class Math {
  Math(
      {required this.weight,
      required this.diameter,
      required this.impulsion,
      required this.thrust}) {
    runAll();
  }

  double gravityForce = 0,
      radius = 0,
      area = 0,
      burnTime = 0,
      densityAir = 1.2,
      dragCoef = 0.75,
      mass = 0,
      boostDistance = 0,
      windResistance = 0,
      coefQ = 0,
      coefX = 0,
      coastDistance = 0,
      totalAltitude = 0,
      coefQB = 0,
      coefQA = 0,
      totalTime = 0,
      coefK = 0,
      velocity = 0,
      weight,
      diameter,
      thrust,
      impulsion;

  void getMass() => mass = weight / 16.0 / 2.2;
  void getArea() =>
      area = 3.14 * pow((0.5 * (diameter / 12.0) * 0.3048), 2).toDouble();
  void getGravityForce() => gravityForce = mass * 9.8;
  void getBurnTime() => burnTime = impulsion / thrust;
  void getCoefficient() {
    coefK =
        0.5 * densityAir * dragCoef * area; // compute wind resistance factor
    coefQ = sqrt((thrust - gravityForce) / coefK);
    coefX = 2 * coefK * coefQ / mass;
  }

  void getVelAtBurn() => velocity =
      coefQ * (1 - exp(-coefX * burnTime)) / (1 + exp(-coefX * burnTime));

  void getwWindResistance() =>
      windResistance = 0.5 * densityAir * dragCoef * area * pow(velocity, 2);

  void getDistances() {
    boostDistance = ((-mass / (2 * coefK)) *
        log((thrust - gravityForce - coefK * velocity * velocity) /
            (thrust - gravityForce)));

    coastDistance = ((mass / (2 * coefK)) *
        log((gravityForce + coefK * velocity * velocity) / (gravityForce)));
  }

  void getTotalAltitude() => totalAltitude = boostDistance + coastDistance;

  void getTotalTime() {
    coefQA = sqrt(gravityForce / coefK);
    coefQB = sqrt(9.8 * coefK / mass);
    totalTime = (atan(velocity / coefQA) / coefQB) + burnTime;
  }

  void runAll() {
    getMass();
    getArea();
    getGravityForce();
    getBurnTime();
    getCoefficient();
    getVelAtBurn();
    getwWindResistance();
    getDistances();
    getTotalAltitude();
    getTotalTime();
  }
}
