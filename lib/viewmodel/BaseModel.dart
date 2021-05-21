import 'package:flutter/foundation.dart';
import 'package:ghmedic/enums/ViewState.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  String errorMessage;
  String successMessage;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}