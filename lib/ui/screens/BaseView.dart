import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ghmedic/service/ServiceLocator.dart';
import 'package:ghmedic/viewmodel/BaseModel.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewmodel, Widget child) builder;
  final Function(T) onInitView;
  BaseView({this.builder, this.onInitView});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();



}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>>{

  T viewmodel = locator<T>();

  @override
  void initState() {
      if(widget.onInitView!=null){
        widget.onInitView(viewmodel);
      }
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => viewmodel,
        child: Consumer<T>(
          builder: widget.builder,));
  }

  @override
  void dispose() {
    //viewmodel.dispose();
    super.dispose();
  }
}