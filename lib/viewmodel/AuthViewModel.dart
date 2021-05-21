

import 'package:ghmedic/enums/ViewState.dart';
import 'package:ghmedic/repo/AuthRepository.dart';
import 'package:ghmedic/repo/EmpleadoRepository.dart';
import 'package:ghmedic/service/ServiceLocator.dart';
import 'package:ghmedic/viewmodel/BaseModel.dart';

class AuthViewModel extends BaseModel{
    EmpleadoRepository empleadoRepository= locator<EmpleadoRepository>();

    Future<bool> login(String usuario, String password)async{
      bool authenticated=false;
      setState(ViewState.Loading);
      try {
        authenticated = await empleadoRepository.authEmpleado(usuario, password);
        if (!authenticated) {
          errorMessage="Datos invalidos";
          setState(ViewState.Error);
        }else{
          AuthRepository.login();
        }
      }on Exception catch(e) {
        errorMessage=e.toString();
        setState(ViewState.Error);
      }
      return authenticated;
    }

    Future<bool> isLoggedIn() async{
      return await AuthRepository.isLoggedIn();
    }
}