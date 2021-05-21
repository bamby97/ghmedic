
import 'package:flutter/material.dart';
import 'package:ghmedic/ui/screens/AgregarEmpleadoScreen.dart';
import 'package:ghmedic/ui/screens/EmpleadoScreen.dart';
import 'package:ghmedic/ui/screens/HomeScreen.dart';
import 'package:ghmedic/ui/screens/LoginScreen.dart';

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/home':
        return MaterialPageRoute(builder: (_)=> HomeScreen());
        break;
      case '/agregarEmpleado':
        return MaterialPageRoute(builder: (_)=> AgregarEmpleadoScreen());
        break;
      case '/login':
        return MaterialPageRoute(builder: (_)=>LoginScreen());
        break;
      default:
        return MaterialPageRoute(builder: (_)=> Scaffold(
          body: Center(
            child: Text("No hay ruta definid a ${settings.name}"),
          ),
        ));
    }
  }
}