class Empleado {
  String _pKEmpleado;
  String _nombre;
  String _departamento;
  String _sexo;
  String _fechaIngreso;
  String _pais;
  String _estado;

  Empleado(
      {String pKEmpleado,
        String nombre,
        String departamento,
        String sexo,
        String fechaIngreso,
        String pais,
        String estado}) {
    this._pKEmpleado = pKEmpleado;
    this._nombre = nombre;
    this._departamento = departamento;
    this._sexo = sexo;
    this._fechaIngreso = fechaIngreso;
    this._pais = pais;
    this._estado = estado;
  }



  String get pKEmpleado => _pKEmpleado;
  set pKEmpleado(String pKEmpleado) => _pKEmpleado = pKEmpleado;
  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;
  String get departamento => _departamento;
  set departamento(String departamento) => _departamento = departamento;
  String get sexo => _sexo;
  set sexo(String sexo) => _sexo = sexo;
  String get fechaIngreso => _fechaIngreso;
  set fechaIngreso(String fechaIngreso) => _fechaIngreso = fechaIngreso;
  String get pais => _pais;
  set pais(String pais) => _pais = pais;
  String get estado => _estado;
  set estado(String estado) => _estado = estado;

  Empleado.fromJson(Map<String, dynamic> json) {
    _pKEmpleado = json['PKEmpleado'];
    _nombre = json['Nombre'];
    _departamento = json['Departamento'];
    _sexo = json['Sexo'];
    _fechaIngreso = json['FechaIngreso'];
    _pais = json['Pais'];
    _estado = json['Estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._pKEmpleado;
    data['Nombre'] = this._nombre;
    data['Departamento'] = this._departamento;
    data['Sexo'] = this._sexo;
    data['FechaIngreso'] = this._fechaIngreso;
    data['Pais'] = this._pais;
    data['Estado'] = this._estado;
    return data;
  }

  Map<String, dynamic> toDAOJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PKEmpleado'] = this._pKEmpleado;
    data['Nombre'] = this._nombre;
    data['Departamento'] = this._departamento;
    data['Sexo'] = this._sexo;
    data['FechaIngreso'] = this._fechaIngreso;
    data['Pais'] = this._pais;
    data['Estado'] = this._estado;
    return data;
  }

  Map<String, dynamic> toJsonWithNoId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nombre'] = this._nombre;
    data['Departamento'] = this._departamento;
    data['Sexo'] = this._sexo;
    data['FechaIngreso'] = this._fechaIngreso;
    data['Pais'] = this._pais;
    data['Estado'] = this._estado;
    return data;
  }
}