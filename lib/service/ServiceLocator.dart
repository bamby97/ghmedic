
import 'package:get_it/get_it.dart';
import 'package:ghmedic/data/dao/EmpleadoDAO.dart';
import 'package:ghmedic/repo/AuthRepository.dart';
import 'package:ghmedic/repo/EmpleadoRepository.dart';
import 'package:ghmedic/service/EmpleadoApiService.dart';
import 'package:ghmedic/viewmodel/AuthViewModel.dart';
import 'package:ghmedic/viewmodel/EmpleadoViewModel.dart';

GetIt locator= GetIt.instance;

void setUpLocator(){
  locator.registerLazySingleton(() => EmpleadoApiService.create());
  locator.registerLazySingleton(() => EmpleadoRepository());
  locator.registerLazySingleton(() => EmpledoDAO());

  locator.registerFactory(() => AuthViewModel());
  locator.registerFactory(() => EmpleadoViewModel());
}