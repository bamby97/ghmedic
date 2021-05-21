import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ghmedic/enums/ViewState.dart';
import 'package:ghmedic/ui/screens/BaseView.dart';
import 'package:ghmedic/viewmodel/AuthViewModel.dart';
import 'package:ghmedic/viewmodel/BaseModel.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _username = new TextEditingController();
  TextEditingController _pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: BaseView<AuthViewModel>(
                builder: (context,viewModel,child){
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Login"),
                      TextField(controller: _username,),
                      TextField(controller: _pass,obscureText: true,),
                      ElevatedButton(
                          onPressed: ()async{
                            if(await viewModel.login(_username.text, _pass.text)){
                              Navigator.pushNamed(context, "/home");
                            }

                          },
                          child: Text("Enter")),
                      handleResponse(context,viewModel)
                    ],
                  );
                },
              ),
            )
          ),
        )
      ),
    );
  }

  @override
  void dispose() {
    _username.dispose();
    _pass.dispose();
  }

  handleResponse(BuildContext context, BaseModel model) {
    switch(model.state){
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
    }

  }
}