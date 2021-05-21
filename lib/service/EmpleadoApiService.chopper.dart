// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmpleadoApiService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$EmpleadoApiService extends EmpleadoApiService {
  _$EmpleadoApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = EmpleadoApiService;

  @override
  Future<Response<dynamic>> getAllEmpleados() {
    final $url = 'http://erpghmedic.com.mx/flutter/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getEmpleado(dynamic id) {
    final $url = 'http://erpghmedic.com.mx/flutter/';
    final $params = <String, dynamic>{'id': id};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> authEmpleado(dynamic usuario, dynamic password) {
    final $url = 'http://erpghmedic.com.mx/flutter/';
    final $params = <String, dynamic>{'usuario': usuario, 'password': password};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> uploadEmpleado(dynamic empleado) {
    final $url = 'http://erpghmedic.com.mx/flutter/';
    final $body = empleado;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteEmpleado(dynamic id) {
    final $url = 'http://erpghmedic.com.mx/flutter/';
    final $body = id;
    final $request = Request('DELETE', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateEmpleado(dynamic empleado) {
    final $url = 'http://erpghmedic.com.mx/flutter/';
    final $body = empleado;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
