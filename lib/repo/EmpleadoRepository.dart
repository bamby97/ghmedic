
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:ghmedic/data/dao/EmpleadoDAO.dart';
import 'package:ghmedic/model/Empleado.dart';
import 'package:ghmedic/service/EmpleadoApiService.dart';
import 'package:ghmedic/service/ServiceLocator.dart';

class EmpleadoRepository{
  EmpleadoApiService apiService= locator<EmpleadoApiService>();
  EmpledoDAO empledoDAO = locator<EmpledoDAO>();

  Future<List<Empleado>> getAllEmpleados()async{
    List<Empleado> list;
    try {
      Response response = await apiService.getAllEmpleados();
      List parsedList = response.body;
      log(parsedList.join("*****"));
      list = parsedList.map((val) {
        var result = val.cast<String, dynamic>();
        return Empleado.fromJson(result);
      }).toList();
      log(list[1].nombre);
      List<Map<String,dynamic>> daoList=parsedList.map((e) => e.cast<String, dynamic>() as Map<String,dynamic>).toList();
      empledoDAO.insertBatch(daoList);
    }on TimeoutException catch(e){
      List peristedList=await empledoDAO.queryAllRows();
      list = peristedList.map((val) {
        var result = val.cast<String, dynamic>();
        return Empleado.fromJson(result);
      }).toList();
    }
    return list;
  }

  Future<Empleado> getEmpleado(String id)async{
    Empleado empleado;
    try {
      Response response = await apiService.getEmpleado(id);
      empleado=Empleado.fromJson(response.body);
    }on TimeoutException catch(e){
      var map =await empledoDAO.querySingleRows(id);
      empleado=Empleado.fromJson(map);
    }
    return empleado;
  }

  Future<bool> authEmpleado(String usuario, String password)async{
    Response response=await apiService.authEmpleado(usuario, password);
    return response.body.toString()=='1'?true:false;
  }

  Future<bool> uploadEmpleado(Empleado empleado)async{
    var id=await apiService.uploadEmpleado(empleado.toJsonWithNoId());
    empleado.pKEmpleado=id.body.toString();
    await empledoDAO.insert(empleado.toDAOJson());
    return id!=null?true:false;
  }

  Future<bool> deleteEmpleado(String id)async{
    var isDeleted;
    var response =await apiService.deleteEmpleado(id);
    if(response.body.toString()=="1") {
       isDeleted = await empledoDAO.delete(id);
    }
    return isDeleted==1?true:false;
  }

  Future<bool> updateEmpleado(Empleado empleado)async{
    var isUpdated;
    var response=await apiService.updateEmpleado(empleado.toJson());
    if(response.body.toString()=="1") {
      isUpdated = await empledoDAO.update(empleado.toJson());
    }
    return isUpdated==1?true:false;
  }


}