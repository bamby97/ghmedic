import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ghmedic/enums/ViewState.dart';
import 'package:ghmedic/model/Empleado.dart';
import 'package:ghmedic/ui/screens/BaseView.dart';
import 'package:ghmedic/viewmodel/BaseModel.dart';
import 'package:ghmedic/viewmodel/EmpleadoViewModel.dart';
class AgregarEmpleadoScreen extends StatefulWidget{

  @override
  _AgregarEmpleadoScreenState createState() => _AgregarEmpleadoScreenState();
}

class _AgregarEmpleadoScreenState extends State<AgregarEmpleadoScreen> {
  TextEditingController _name = new TextEditingController();
  bool hombre=true;
  var departments= Map.of({
    1:"Recursos Humanos",
    2:"Sistemas",
    3:"Mercadotecnia",
    4:"Taller"});
  var paises= Map.of({
    1:"Mexico",
    2:"Estados Unidos"});
  var estados= Map.of({
    1:"Colima",
    2:"Jalisco",
    3:"Michoacan",
    4:"Sonora",
    5:"Queretaro",
    6:"California",
    7:"Florida",
    8:"Texas",
    9:"Arizona",
    10:"Nevada"});
  var selectedCountry="Mexico";
  var selectedState="Jalisco";
  String selectedDepartment="";
  bool aceptaDarAlta=false;
  var fechaIngreso;
  var sexo=0;

  void initState() {
    selectedDepartment=departments[1];
    selectedCountry=paises[1];
    selectedState=estados[1];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Card(
            child: Container(
              padding: EdgeInsets.all(13.0),
              child: BaseView<EmpleadoViewModel>(
                builder: (context,viewModel,child){
                  return Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Agregar Empleado",textAlign: TextAlign.center,),
                            Text("Nombre",textAlign: TextAlign.start,),
                            TextField(controller: _name,),
                            Text("Departamento",textAlign: TextAlign.start,),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: selectedDepartment,
                                onChanged: (value){
                                  setState(() {
                                    selectedDepartment=value;
                                  });
                                },
                                items: departments.values.map((e) => DropdownMenuItem(child: Text(e.toString()),value: e.toString(),)).toList(),
                              ),
                            ),
                            Text("Sexo",textAlign: TextAlign.start,),
                            Row(
                              children: [
                                Expanded(child: RadioListTile( value: 0,groupValue: sexo,title: Text("Femenino"),onChanged: (newValue) =>
                                    setState(() => sexo = newValue)),flex: 1,),
                                Expanded(child: RadioListTile( value: 1,groupValue: sexo,title: Text("Masculino"), onChanged: (newValue) =>
                                    setState(() => sexo = newValue)),
                                  flex: 1,
                                )
                              ],
                            ),
                            Text("Fecha ingreso",textAlign: TextAlign.start,),
                            InkWell(
                              child: Text(fechaIngreso??"Click aqui",textAlign: TextAlign.center,),
                              onTap: (){
                                DatePicker.showDatePicker(context,onConfirm: (date) {
                                  setState(() {
                                    var dia=date.day<10?"0"+date.day.toString():date.day.toString();
                                    var mes=date.month<10?"0"+date.month.toString():date.month.toString();
                                    fechaIngreso =
                                        "" + date.year.toString() + "-" +
                                            mes + "-" +
                                            dia;
                                  });
                                }
                                 );
                              }
                            ),
                            Text("Pais",textAlign: TextAlign.start,),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: selectedCountry,
                                onChanged: (value){
                                  setState(() {
                                    if(selectedCountry!=value){
                                      if(value=="Mexico") {
                                        selectedState =
                                            estados.values.firstWhere((
                                                element) =>
                                            element == "Queretaro");
                                      }else{
                                        selectedState =
                                            estados.values.firstWhere((
                                                element) =>
                                            element == "Nevada");
                                      }
                                    }
                                    selectedCountry=value;
                                  });
                                },
                                items: paises.values.map((e) => DropdownMenuItem(child: Text(e.toString()),value: e.toString(),)).toList(),
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: selectedState,
                                onChanged: (value){
                                  setState(() {
                                    selectedState=value;
                                  });
                                },
                                items: selectedCountry == "Mexico" ?
                                estados.values.take(5)
                                    .map((e) => DropdownMenuItem(child: Text(e.toString()),value: e.toString(),)).toList()
                                    :
                                estados.values.skip(5)
                                    .map((e) => DropdownMenuItem(child: Text(e.toString()),value: e.toString(),)).toList()
                                ,
                              ),
                            ),
                            Row(
                              children: [
                                Text("acepta dar de alta a empleado"),
                                Checkbox(value: aceptaDarAlta, onChanged: (value){
                                  setState(() {
                                    aceptaDarAlta=value;
                                  });
                                })
                              ],
                            ),
                            ElevatedButton(
                                onPressed: ()async{
                                  if(aceptaDarAlta!=false) {
                                    await viewModel.uploadEmpleado(
                                        new Empleado(
                                          nombre: _name.text,
                                          departamento: getKeyFromValue(
                                              departments, selectedDepartment).toString(),
                                          sexo: sexo.toString(),
                                          fechaIngreso: fechaIngreso,
                                          pais: getKeyFromValue(
                                              paises, selectedCountry).toString(),
                                          estado: getKeyFromValue(
                                              estados, selectedState).toString(),
                                        )
                                    );
                                  }else{
                                    viewModel.errorMessage="Acepta dar de alta !!!";
                                    viewModel.setState(ViewState.Error);
                                  }
                                  //Navigator.pushNamed(context, "/home");
                                },
                                child: Text("Agregar Empleado")),
                            handleResponse(context, viewModel)
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
        ),
      ),
    );
  }

  getKeyFromValue(Map map,String v){
    var keyFound;
    map.forEach((key, value) {
      if(value==v){
        keyFound=key;
      }
    });
    return keyFound;
  }

  handleResponse(BuildContext context, BaseModel model) {
    switch (model.state) {
      case ViewState.Loading:
        return Container(
          child: Container(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
        );
        break;
      case ViewState.Idle:
        return Container();
        break;
      case ViewState.Error:
        return Text(model.errorMessage);
        break;
      case ViewState.Success:
        return Text(model.successMessage);
        break;
    }
  }
}