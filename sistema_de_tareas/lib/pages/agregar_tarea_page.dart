///Pagina para agregar una nueva tarea o para editarla

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sistema_de_tareas/models/models.dart';
import 'package:sistema_de_tareas/services/services.dart';
import 'package:sistema_de_tareas/theme/app_themes.dart';
import 'package:sistema_de_tareas/widgets/widgets.dart';

class AgregarTareaPage extends StatelessWidget {
  final Tareas tarea;
  final TareaService service;
  final String tipo;
  const AgregarTareaPage({
    Key? key,
    required this.tarea,
    required this.service,
    required this.tipo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormService(tarea),
      child: Center(
        child: _TareaForm(
          servicioAdd: service,
          tipo: tipo,
        ),
      ),
    );
  }
}

class _TareaForm extends StatelessWidget {
  final String tipo;
  final TareaService servicioAdd;
  const _TareaForm({
    Key? key,
    required this.tipo,
    required this.servicioAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tareaForm = Provider.of<FormService>(context);
    final tarea = tareaForm.tarea;
    final format = DateFormat("yyyy-MM-dd");
    return Scaffold(
      appBar: AppBar(
        title: Text(tipo),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: tareaForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CustomInputField(
                    initialValue: tarea.title,
                    onChanged: (value) => tarea.title = value,
                    hintText: 'Titulo de la tarea',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El titulo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  SwitchListTile.adaptive(
                    activeColor: AppThemes.primary,
                    title: const Text('¿Completada?'),
                    value: tarea.isCompleted == 1 ? true : false,
                    onChanged: tareaForm.updateAvailability,
                  ),
                  const SizedBox(height: 15),
                  DateTimeField(
                    // initialValue: tarea.dueDate == null ? null : tarea.dueDate,
                    onChanged: (value) {
                      String formatoFecha = format.format(value!);
                      tarea.dueDate = formatoFecha;
                    },
                    decoration: InputDecoration(
                        labelText: 'Fecha (${format.pattern})'),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          locale: const Locale("es"),
                          firstDate: DateTime(1940),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2030));
                      if (date != null) {
                        return date;
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    onChanged: (value) => tarea.comments = value,
                    initialValue: tarea.comments,
                    hintText: 'Comentario',
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    onChanged: (value) => tarea.description = value,
                    initialValue: tarea.description,
                    hintText: 'Descripción',
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    onChanged: (value) => tarea.tags = value,
                    initialValue: tarea.tags,
                    hintText: 'Tag',
                  ),
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                      child: ElevatedButton(
                        child: Text(tipo),
                        onPressed: () async {
                          if (!tareaForm.isValidForm()) return;
                          if (tipo == 'Agregar tarea') {
                            await servicioAdd.crearTarea(tareaForm.tarea);
                            Navigator.pop(context);
                          }
                          if (tipo == 'Editar tarea') {
                            await servicioAdd.editarTarea(
                                tarea.id.toString(), tarea);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
