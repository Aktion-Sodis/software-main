import 'package:flutter/material.dart';
import 'package:mobile_app/services/hive_db_helper.dart';

class HiveDBInitializer extends StatefulWidget {
  const HiveDBInitializer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<HiveDBInitializer> createState() => _HiveDBInitializerState();
}

class _HiveDBInitializerState extends State<HiveDBInitializer>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addObserver(this);
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.removeObserver(this);
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await HiveDBHelper.instance.init();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await HiveDBHelper.instance.close();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
