import 'package:flutter/material.dart';
import 'package:ghmedic/enums/ViewState.dart';
import 'package:ghmedic/model/Empleado.dart';
import 'package:ghmedic/ui/screens/BaseView.dart';
import 'package:ghmedic/ui/screens/EmpleadoScreen.dart';
import 'package:ghmedic/viewmodel/BaseModel.dart';
import 'package:ghmedic/viewmodel/EmpleadoViewModel.dart';
class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

  @override
  void initState() {

    super.initState();
  }

  getData(EmpleadoViewModel viewModel){
    viewModel.getAllEmpleados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("Empleados",style: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
          fontSize: 24)),
        actions: [
          IconButton(icon: Icon(Icons.add,color: Colors.blue,), onPressed: (){
            Navigator.pushNamed(context, "/agregarEmpleado");
            setState(() {
            });
          })
        ],
      ),
      body: Center(
        child: Container(

            child: BaseView<EmpleadoViewModel>(
              onInitView: getData,
              builder: (context,viewmodel,child){
                return Column(
                  children: [

                    handleResponse(context, viewmodel)

                  ],
                );//buildGrid(model),
              },
            )
        ),
      ),
    );

  }

  handleResponse(BuildContext context, EmpleadoViewModel model) {
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
        return Expanded(
            child: buildGrid(model.listaEmpleados)
        );
        break;
    }
  }

  Widget buildGrid(List<Empleado>empleados){
    return GridView.builder(
        itemCount: empleados.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:  2 ),
        itemBuilder: (context, index) {
          return new Card(
              margin: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              elevation: 10.0,
              child: GestureDetector(
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Nombre:"),
                        Text(empleados[index].nombre??"N/A", style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 10)),
                        Text("Departamento:"),
                        Text(departments[int.parse(empleados[index].departamento)]??"N/A", style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 10)),
                        Text("Sexo:"),
                        Text(empleados[index].sexo=="1"?"Masculino":"Femenino", style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 10)),
                        Text("Fecha de ingreso:"),
                        Text(empleados[index].fechaIngreso??"N/A", style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 10)),
                        Text("Pais:"),
                        Text(paises[int.parse(empleados[index].pais)]??"N/A", style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 10)),
                        Text("Estado:"),
                        Text(estados[int.parse(empleados[index].estado)]??"N/A", style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 10)),
                      ]
                  ),
                ),
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>EmpleadoScreen(empleado:empleados[index]))),
              )
          );
        });
  }
}