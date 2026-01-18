import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ControlScreen(),
    );
  }
}

class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  final String esp32Ip = "http://192.168.4.1"; // CHANGE THIS

  Future<void> sendCmd(String cmd) async {
    try {
      print(cmd);
      await http.get(Uri.parse("$esp32Ip/$cmd"));
    } catch (_) {}
  }

  Widget controlButton({
    required IconData icon,
    required String cmd,
    Color color = Colors.blueGrey,
  }) {
    return GestureDetector(
      onTapDown: (_) => sendCmd(cmd),
      onTapUp: (_) => sendCmd("S"),

      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(icon, color: Colors.white, size: 36),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          const SizedBox(width: 20),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),

              Column(
                children: [
                  controlButton(icon: Icons.arrow_upward, cmd: "L"),
                  const SizedBox(height: 30),
                  controlButton(icon: Icons.arrow_downward, cmd: "R"),
                ],
              ),
              const SizedBox(height: 30),

              controlButton(
                icon: Icons.stop_circle,
                cmd: "S",
                color: Colors.redAccent,
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  SizedBox(width: 30),
                  controlButton(icon: Icons.arrow_left, cmd: "B"),
                  const SizedBox(width: 30),
                  controlButton(icon: Icons.arrow_right, cmd: "F"),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),

          Expanded(child: Container()),
        ],
      ),
    );
  }
}
