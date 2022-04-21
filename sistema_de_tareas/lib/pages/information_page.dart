///Pagina para mostrar todos los detalles de un registro

import 'package:flutter/material.dart';
import 'package:sistema_de_tareas/models/models.dart';
import 'package:sistema_de_tareas/pages/pages.dart';
import 'package:sistema_de_tareas/services/services.dart';
import 'package:sistema_de_tareas/widgets/widgets.dart';

class InformacionTareaPage extends StatelessWidget {
  const InformacionTareaPage(
      {Key? key, required this.tarea, required this.service})
      : super(key: key);
  final Tareas tarea;
  final TareaService service;
  @override
  Widget build(BuildContext context) {
    return _DetallesTarea(
      provider: service,
    );
  }
}

class _DetallesTarea extends StatelessWidget {
  const _DetallesTarea({
    Key? key,
    required this.provider,
  }) : super(key: key);
  final TareaService provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles'),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
        itemCount: provider.datosPorId.length,
        itemBuilder: (BuildContext context, int index) {
          return provider.datosPorId.isEmpty
              ? const CircularProgressIndicator()
              : _Card(
                  tarea: provider.datosPorId[index],
                  provider: provider,
                );
        },
      )),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.tarea,
    required this.provider,
  }) : super(key: key);
  final Tareas tarea;
  final TareaService provider;

  @override
  Widget build(BuildContext context) {
    //final tarea = ;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              CustomCard(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.numbers),
                  title: const Text('Titulo'),
                  subtitle: Text(tarea.title),
                ),
              ),
              CustomCard(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: const Text('Completada'),
                  subtitle: Text(tarea.isCompleted.toString()),
                ),
              ),
              CustomCard(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: const Text('Fecha'),
                  subtitle: Text(tarea.dueDate.toString()),
                ),
              ),
              CustomCard(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: const Text('Comentarios'),
                  subtitle: Text(tarea.comments ?? ''),
                ),
              ),
              CustomCard(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: const Text('Descripción'),
                  subtitle: Text(tarea.description ?? ''),
                ),
              ),
              CustomCard(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: const Text('Tags'),
                  subtitle: Text(tarea.tags ?? ''),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgregarTareaPage(
                                  tarea: provider.datosPorId[0],
                                  service: provider,
                                  tipo: 'Editar tarea',
                                )));
                  },
                  child: const Text(
                    'Editar tarea',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
