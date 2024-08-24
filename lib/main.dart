import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';
import 'dart:async';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  O3DController o3dController = O3DController();
  PageController mainPageController = PageController();

  // Gradient color variables
  List<Color> colors1 = [Colors.blue, Colors.purple];
  List<Color> colors2 = [Colors.orange, Colors.red];
  bool toggle = false;

  @override
  void initState() {
    super.initState();

    // Timer to switch gradient colors every 3 seconds
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        toggle = !toggle;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Animated gradient background
            AnimatedContainer(
              duration: Duration(seconds: 3),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: toggle ? colors1 : colors2,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // 3D Model
            O3D(
              src: 'assets/dancing_girl.glb',
              controller: o3dController,
              ar: true,
              autoPlay: true,
              autoRotate: false,
              cameraControls: false,
            ),
            // PageView
            PageView(
              controller: mainPageController,
              children: [],
            ),
            // Button with Blur effect at the bottom of the page
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      // Action when button is pressed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      shadowColor: Colors.black.withOpacity(0.9),
                      elevation: 10,
                    ),
                    child: Text(
                      "Find",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
