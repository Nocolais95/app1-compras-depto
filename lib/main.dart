import 'package:ferchus_y_maxi/providers/ambiente_form_provider.dart';
import 'package:ferchus_y_maxi/providers/artefacto_form_provider.dart';
import 'package:ferchus_y_maxi/services/ambiente_service.dart';
import 'package:flutter/material.dart';
import 'package:ferchus_y_maxi/screen/screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  // final selectedId;

  // const AppState({Key? key, this.selectedId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AmbientesServices(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      title: 'Comprar App',
      routes: {
        'home': (_) => HomeScreen(),
        'ambiente': (_) => AmbienteScreen(),
        'nuevo ambiente': (_) => NuevoAmbienteScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.lightBlue,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
