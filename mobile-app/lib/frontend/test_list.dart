import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:mobile_app/frontend/strings.dart';
import 'package:mobile_app/frontend/tests/audio_test.dart';
import 'package:mobile_app/frontend/tests/gps_test.dart';

class TestList extends StatelessWidget {
  TestList({Key? key}) : super(key: key);

  final Map<String, Widget Function()> _allTests = {
    "flutter_sound": () => AudioTest(),
    "geolocator": () => GpsTest()
  };

  Widget _itemBuilder(BuildContext context, int index) {
    String key = _allTests.keys.toList()[index];
    if (_allTests[key] == null) return SizedBox.shrink();
    return ListTile(
      title: Text(key),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _allTests[key]!(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(test_list),
        ),
        body: Scrollbar(
          child: ListView.builder(
            itemBuilder: _itemBuilder,
            itemCount: _allTests.length,
          ),
        ));
  }
}
