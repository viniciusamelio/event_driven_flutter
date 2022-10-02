import 'package:event_driven_flutter/app.dart';
import 'package:event_driven_flutter/di.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  await DI.init();
  runApp(
    const App(),
  );
}
