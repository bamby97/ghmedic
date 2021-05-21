

import 'package:chopper/chopper.dart';

part 'EmpleadoApiService.chopper.dart';

@ChopperApi(baseUrl: "http://erpghmedic.com.mx/flutter/")
abstract class EmpleadoApiService extends ChopperService{

  static EmpleadoApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      services: [
        // The generated implementation
        _$EmpleadoApiService(),
      ],
      // Converts data to &amp; from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$EmpleadoApiService(client);
  }

  @Get()
  Future<Response> getAllEmpleados();

  @Get()
  Future<Response> getEmpleado(@Query("id") id);

  @Get()
  Future<Response> authEmpleado(@Query("usuario") usuario, @Query("password") password);

  @Post()
  Future<Response> uploadEmpleado(@Body() empleado);

  @Delete()
  Future<Response> deleteEmpleado(@Body() id);

  @Put()
  Future<Response> updateEmpleado(@Body() empleado);
}