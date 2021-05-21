
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ghmedic/enums/ViewState.dart';
import 'package:ghmedic/model/Empleado.dart';
import 'package:ghmedic/repo/EmpleadoRepository.dart';
import 'package:ghmedic/service/ServiceLocator.dart';
import 'package:ghmedic/viewmodel/BaseModel.dart';

class EmpleadoViewModel extends BaseModel{
  EmpleadoRepository empleadoRepository= locator<EmpleadoRepository>();
  List<Empleado> listaEmpleados;

  Future<List<Empleado>> getAllEmpleados()async{
    List<Empleado> emplados=null;
    try{
     emplados=await empleadoRepository.getAllEmpleados();
    }on Exception catch(e){
      errorMessage=e.toString();
      setState(ViewState.Error);
    }
    listaEmpleados=emplados;
    setState(ViewState.Success);
    return emplados;
  }

  Future<Empleado> getEmpleado(String id)async{
    Empleado empleado;
    setState(ViewState.Loading);
    try {
      empleado = await empleadoRepository.getEmpleado(id);
    }on Exception catch(e){
      errorMessage=e.toString();
      setState(ViewState.Error);
    }
    return empleado;
  }

  Future<bool> uploadEmpleado(Empleado empleado)async{
    bool uploaded=false;
    setState(ViewState.Loading);
    try {
      uploaded=await empleadoRepository.uploadEmpleado(empleado);
    }on Exception catch(e){
      errorMessage=e.toString();
      setState(ViewState.Error);
    }
    if(uploaded==true){
      successMessage="Empleado Agregado";
      setState(ViewState.Success);
    }
    return uploaded;
  }

  Future<bool> deleteEmpleado(String id)async{
    bool deleted=false;
    setState(ViewState.Loading);
    try {
      deleted=await empleadoRepository.deleteEmpleado(id);
    }on Exception catch(e){
      errorMessage=e.toString();
      setState(ViewState.Error);
    }
    return deleted;
  }

  Future<bool> updateEmpleado(Empleado empleado)async{
    bool updated=false;
    try{
    updated=await empleadoRepository.updateEmpleado(empleado);
    }on Exception catch(e){
      errorMessage=e.toString();
      setState(ViewState.Error);
    }
    successMessage="Empleado actualizado!!";
    setState(ViewState.Success);
    return updated;
  }
}