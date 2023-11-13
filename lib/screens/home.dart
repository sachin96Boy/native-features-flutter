import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('samples.sachin96boy.dev/battery');
  String _batteryLevel = 'unknown Battery Level';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final battery = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = battery;
    } on PlatformException catch (e) {
      batteryLevel = 'failed to get battery level: ${e.message}';
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery Level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('BatteryLevel: $_batteryLevel'),
          ],
        ),
      ),
    );
  }
}
