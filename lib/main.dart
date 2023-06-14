import 'package:flutter/material.dart';
import 'dart:math';
import 'package:tilt/tilt.dart';

void main() {
  runApp(const OBAC());
}

class OBAC extends StatelessWidget {
  const OBAC({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optimum Ballastics Angle Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Ballastics'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // _MyHomePageState(){
  //   selectedbullet = bulletlist[0];
  // }
  var arController = TextEditingController();
  var vlController = TextEditingController();
  var msController = TextEditingController();
  var wsController = TextEditingController();
  var wdController = TextEditingController();
  var dController = TextEditingController();
  var hController = TextEditingController();

  var result = "";
  dynamic tiltx;
  dynamic tilty;
  final bulletlist = {
    "NONE",
    "AKM",
    "Dragunov",
    "Shyr SSG69",
    "imi Galil",
    "KOCH PSGE",
    "SAKDTRG",
    "MAUSER SP66",
    "Tikka f3",
    "SSG 3000",
    "Pistol Auto 9mm",
    "Glock",
    "KOCHMPS",
    "Micro VZI",
    "IBI FNSAS",
    "SIG 716i",
    "AK 203",
    "IMI FAVOR TARZ 1",
    " M4A1 Carline",
    "SCARL",
    "SCARH",
    "T91AR",
  };
  String? selectedbullet = "NONE";
  final rholist = {
    "Ultra Cold (-50)",
    "Sub Zero (0 to -10)",
    "Cool (10 to 20)",
    "Tropical (35)",
    "Hot (40 to 50)",
  };
  String? selectedrho = "Tropical (35)";

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Optimum Ballistic Angle Calculator'),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Bullet Options',
              style: TextStyle(fontSize: 17),
            ),
            Container(
              width: 300,
              child: DropdownButtonFormField(
                value: selectedbullet,
                items: bulletlist
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedbullet = val as String;
                  });
                },
                icon: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.greenAccent,
                ),
                dropdownColor: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
                onPressed: () {
                  isVisible = !isVisible;
                },
                child: const Text(
                    "Tap to fill Bullet info Manually (and select 'NONE')")),
            Visibility(
                visible: isVisible,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Cross Sectional Area Of Bullet ',
                      style: TextStyle(fontSize: 17),
                    ),
                    TextField(
                      controller: arController,
                      decoration: const InputDecoration(
                          label: Text('Enter Value in me2'),
                          prefixIcon: Icon(Icons.circle_rounded)),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Initial Muzzel Speed or Bullet Velocity',
                      style: TextStyle(fontSize: 17),
                    ),
                    TextField(
                      controller: vlController,
                      decoration: const InputDecoration(
                          label: Text('Enter Value in m/s'),
                          prefixIcon: Icon(Icons.speed)),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Mass Of Bullet',
                      style: TextStyle(fontSize: 17),
                    ),
                    TextField(
                      controller: msController,
                      decoration: const InputDecoration(
                          label: Text('Enter Value in kg'),
                          prefixIcon: Icon(Icons.line_weight)),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            const Text(
              'Speed Of Wind',
              style: TextStyle(fontSize: 17),
            ),
            TextField(
              controller: wsController,
              decoration: const InputDecoration(
                  label: Text('Enter Value in knots'),
                  prefixIcon: Icon(Icons.speed_sharp)),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            const Text(
              'Direction Of wind',
              style: TextStyle(fontSize: 17),
            ),
            TextField(
              controller: wdController,
              decoration: const InputDecoration(
                  label: Text('Enter Value in degree'),
                  prefixIcon: Icon(Icons.directions_outlined)),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            const Text(
              'The Distance Of Target',
              style: TextStyle(fontSize: 17),
            ),
            TextField(
              controller: dController,
              decoration: const InputDecoration(
                  label: Text('Enter Value in m'),
                  prefixIcon: Icon(Icons.social_distance)),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            const Text(
              'Height Of Bullet from Ground',
              style: TextStyle(fontSize: 17),
            ),
            TextField(
              controller: hController,
              decoration: const InputDecoration(
                  label: Text('Enter Value in m'),
                  prefixIcon: Icon(Icons.height)),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            const Text(
              'Choose region for air density in kg/cubic',
              style: TextStyle(fontSize: 17),
            ),
            Container(
              width: 300,
              child: DropdownButtonFormField(
                value: selectedrho,
                items: rholist
                    .map((r) => DropdownMenuItem(
                          value: r,
                          child: Text(r),
                        ))
                    .toList(),
                onChanged: (rval) {
                  setState(() {
                    selectedrho = rval as String;
                  });
                },
                icon: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.greenAccent,
                ),
                dropdownColor: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  var ar;
                  var vl;
                  var ms;
                  var iar;
                  var ivl;
                  var ims;

                  if (selectedbullet == "NONE") {
                    ar = arController.text.toString();
                    vl = vlController.text.toString();
                    ms = msController.text.toString();
                    iar = double.parse(ar);
                    ivl = double.parse(vl);
                    ims = double.parse(ms);
                  }
                  if (selectedbullet == "AKM") {
                    iar = ar = 0.0000228;
                    ivl = vl = 715;
                    ims = ms = 0.08;
                  }
                  if (selectedbullet == "Dragunov") {
                    iar = ar = 0.0000228;
                    ivl = vl = 850;
                    ims = ms = 0.01;
                  }
                  if (selectedbullet == "Shyr SSG69") {
                    iar = ar = 0.0000228;
                    ivl = vl = 1000;
                    ims = ms = 0.01;
                  }
                  if (selectedbullet == "imi Galil") {
                    iar = ar = 0.0000228;
                    ivl = vl = 900;
                    ims = ms = 0.01;
                  }
                  if (selectedbullet == "KOCH PSGE") {
                    iar = ar = 0.0000228;
                    ivl = vl = 868;
                    ims = ms = 0.01;
                  }
                  if (selectedbullet == "SAKDTRG") {
                    iar = ar = 0.0000291;
                    ivl = vl = 936;
                    ims = ms = 0.016;
                  }
                  if (selectedbullet == "MAUSER SP66") {
                    iar = ar = 0.0000228;
                    ivl = vl = 868;
                    ims = ms = 0.01;
                  }
                  if (selectedbullet == "Tikka f3") {
                    iar = ar = 0.0000228;
                    ivl = vl = 790;
                    ims = ms = 0.01;
                  }
                  if (selectedbullet == "SSG 3000") {
                    iar = ar = 0.0000318;
                    ivl = vl = 397;
                    ims = ms = 0.009;
                  }
                  if (selectedbullet == "Pistol Auto 9mm") {
                    iar = ar = 0.0000228;
                    ivl = vl = 868;
                    ims = ms = 0.01;
                  }
                  if (selectedbullet == "Glock") {
                    iar = ar = 0.0000318;
                    ivl = vl = 375;
                    ims = ms = 0.009;
                  }
                  if (selectedbullet == "KOCHMPS") {
                    iar = ar = 0.0000318;
                    ivl = vl = 400;
                    ims = ms = 0.009;
                  }
                  if (selectedbullet == "Micro VZI") {
                    iar = ar = 0.0000318;
                    ivl = vl = 350;
                    ims = ms = 0.009;
                  }
                  if (selectedbullet == "IBI FNSAS") {
                    iar = ar = 0.0000122;
                    ivl = vl = 915;
                    ims = ms = 0.0055;
                  }
                  if (selectedbullet == "SIG 716i") {
                    iar = ar = 0.0000228;
                    ivl = vl = 807;
                    ims = ms = 0.010;
                  }
                  if (selectedbullet == "AK 203") {
                    iar = ar = 0.0000228;
                    ivl = vl = 730;
                    ims = ms = 0.08;
                  }
                  if (selectedbullet == "IMI FAVOR TARZ 1") {
                    iar = ar = 0.0000122;
                    ivl = vl = 910;
                    ims = ms = 0.0055;
                  }
                  if (selectedbullet == " M4A1 Carline") {
                    iar = ar = 0.0000122;
                    ivl = vl = 910;
                    ims = ms = 0.0055;
                  }
                  if (selectedbullet == "SCARL") {
                    iar = ar = 0.0000122;
                    ivl = vl = 870;
                    ims = ms = 0.0055;
                  }
                  if (selectedbullet == "SCARH") {
                    iar = ar = 0.0000228;
                    ivl = vl = 710;
                    ims = ms = 0.010;
                  }
                  if (selectedbullet == "T91AR") {
                    iar = ar = 0.0000122;
                    ivl = vl = 975;
                    ims = ms = 0.0055;
                  }

                  var ws = wsController.text.toString();
                  var wd = wdController.text.toString();
                  var d = dController.text.toString();
                  var h = hController.text.toString();
                  var rho;

                  if (selectedrho == "Ultra Cold (-50)") {
                    rho = 1.58;
                  }
                  if (selectedrho == "Sub Zero (0 to -10)") {
                    rho = 1.32;
                  }
                  if (selectedrho == "Cool (10 to 20)") {
                    rho = 1.23;
                  }
                  if (selectedrho == "Tropical (35)") {
                    rho = 1.16;
                  } else {
                    selectedrho == "Hot (40 to 50)";
                    rho = 1.10;
                  }
                  if (ws != "" && wd != "" && d != "" && h != "") {
                    var iws = num.parse(ws);
                    var iwd = num.parse(wd);
                    var id = num.parse(d);
                    var ih = num.parse(h);
                    var g = 9.8;
                    var c = 0.295;

                    // Calculate the time it takes for the bullet to reach its peak height
                    var t = sqrt((2 * ih) / g);
                    // Calculate the distance traveled by the bullet
                    var v = ivl;
                    var x = (ivl * t) -
                        (c * rho * iar * (pow(v, 2)) * (pow(t, 2))) / (2 * ims);
                    // Calculate the angle at which the muzzle should be inclined
                    var hypo = sqrt((pow(x, 2) + pow(ih, 2)));
                    var J = (ih / x);
                    var Q = ((atan(J)) * 57.32);
                    // Calculate the height at which the bullet will hit the target when it is parallel to the ground
                    var Y = x - id;
                    var U = Y * tan(Q) * .017455;
                    var w1 = ((iws / 1.944) / ivl);
                    var w2 = w1 * sin(iwd);
                    var w3 = asin(w2);

                    setState(() {
                      result =
                          "Optimum angle of the muzzel : $Q and                             The target will hit at this height when parallel to ground : $U and                              Horizontal angle compensation shift due to wind is :  $w3";
                    });
                  } else {
                    setState(() {
                      result = "Please Fill All The Blanks!!";
                    });
                  }
                },
                child: const Text('Calculate')),
            const SizedBox(height: 10),
            Container(
              width: 340,
              color: Colors.greenAccent,
              child: Center(
                  child: Text(
                result,
                style: const TextStyle(fontSize: 17),
              )),
            ),
            const SizedBox(height: 20),
            Center(
              child: StreamBuilder<Tilt>(
                stream: DeviceTilt(
                  samplingRateMs: 20,
                  initialTilt: const Tilt(0, 0),
                  filterGain: 0.1,
                ).stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    tiltx = snapshot.data!.xDegrees.toString();
                    tilty = snapshot.data!.yDegrees.toString();

                    return Column(children: [
                      const Text(
                        'Vertical Angle',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$tiltx',
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            backgroundColor: Colors.green),
                      ),
                      const Text(
                        'Horizontal Angle',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$tilty',
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            backgroundColor: Colors.green),
                      )
                    ]);
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            const SizedBox(height: 30)
          ],
        )));
  }
}
