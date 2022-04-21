///Conexion a la API y consultas a la PI

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_de_tareas/models/models.dart';

class TareaService extends ChangeNotifier {
  static const String _baseUrl = 'ecsdevapi.nextline.mx';
  final List<Tareas> tareas = [];
  final List<Tareas> datosPorId = [Tareas(title: '', isCompleted: 0)];
  final _url = Uri.https(_baseUrl, 'vdev/tasks-challenge/tasks');
  static const String _token =
      'e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
  final Map<String, String> _header = {
    "Content-type": "application/json",
    'Accept': 'application/json',
    "Authorization": "Bearer $_token"
  };

  TareaService() {
    _listarTareas();
  }

  //Listar todas las tareas
  Future<void> _listarTareas() async {
    final resp = await http.get(_url, headers: _header);
    final List<dynamic> datos = json.decode(resp.body);
    for (var element in datos) {
      final tempVariable = Tareas.fromJson(element);
      tareas.add(tempVariable);
      notifyListeners();
    }
  }

  //Crear una nueva tarea
  Future<void> crearTarea(Tareas tareaAdd) async {
    final resp = await http.post(
      _url,
      headers: _header,
      body: json.encode(tareaAdd),
    );
    final Map<String, dynamic> datos = json.decode(resp.body);
    Tareas nuevaTarea = Tareas(
      id: datos['task']['id'],
      title: datos['task']['title'],
      isCompleted: datos['task']['is_completed'],
      dueDate: datos['task']['due_date'],
    );
    if (resp.statusCode == 201 || resp.statusCode == 200) {
      tareas.add(nuevaTarea);
      notifyListeners();
    }
  }

  //ELiminar una tarea por id
  Future<void> eliminarTarea(Tareas tareaAdd) async {
    int? idElimiar = tareaAdd.id;
    final url = Uri.https(_baseUrl, 'vdev/tasks-challenge/tasks/$idElimiar');
    final resp = await http.delete(url, headers: _header);
    if (resp.statusCode == 201 || resp.statusCode == 200) {
      for (int i = 0; i < tareas.length; i++) {
        if (idElimiar == tareas[i].id) {
          tareas.remove(tareas[i]);
        }
      }
      notifyListeners();
    }
  }

  //Consultar un registro por id
  Future<void> consultaPorId(String id) async {
    if (id.isNotEmpty) {
      final url = Uri.https(_baseUrl, 'vdev/tasks-challenge/tasks/$id');
      final resp = await http.get(url, headers: _header);
      final List<dynamic> datos = json.decode(resp.body);
      for (var element in datos) {
        if (resp.statusCode == 201 || resp.statusCode == 200) {
          final tempVariable = Tareas.fromJson(element);
          datosPorId[0] = tempVariable;
        }
      }
      notifyListeners();
    }
  }

  //Editar tarea por id
  Future<void> editarTarea(String id, Tareas tareaAdd) async {
    final url = Uri.https(_baseUrl, 'vdev/tasks-challenge/tasks/$id');
    final resp =
        await http.put(url, headers: _header, body: json.encode(tareaAdd));
    if (resp.statusCode == 201 || resp.statusCode == 200) {
      for (int i = 0; i < tareas.length; i++) {
        if (tareaAdd.id == tareas[i].id) {
          tareas[i] = tareaAdd;
        }
      }
      notifyListeners();
    }
  }
}
