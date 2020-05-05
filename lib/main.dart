import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/home_screen.dart';
import './provider/farmacias_provider.dart';

Future<void> main() async {
  await DotEnv().load('keys.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: FarmaciasProvider(),
      child: MaterialApp(
        title: 'Farmacias Argentina',
        home: HomeScreen(),
      ),
    );
  }
}
