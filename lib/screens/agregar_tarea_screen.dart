import 'package:flutter/material.dart';
import '../models/tarea.dart';

class AgregarTareaScreen extends StatefulWidget {
  const AgregarTareaScreen({super.key});

  @override
  State<AgregarTareaScreen> createState() => _AgregarTareaScreenState();
}

class _AgregarTareaScreenState extends State<AgregarTareaScreen> {
  // Llave global para identificar y validar el formulario
  final _formKey = GlobalKey<FormState>();

  // Controladores para capturar el texto de los campos
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  String? _cursoSeleccionado;

  final List<String> _cursos = [
    'Desarrollo de Software IV',
    'Bases de Datos',
    'Ingeniería de Software',
    'Redes y Comunicaciones',
  ];

  void _guardarFormulario() {
    // Ejecuta las validaciones de los 3 campos
    if (_formKey.currentState!.validate()) {
      final nuevaTarea = Tarea(
        titulo: _tituloController.text.trim(),
        curso: _cursoSeleccionado!,
        descripcion: _descripcionController.text.trim(),
      );

      // Cierra esta pantalla y devuelve la nueva tarea a la pantalla anterior
      Navigator.pop(context, nuevaTarea);
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // CAMPO 1: Título
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título de la tarea',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'El título es obligatorio';
                  }
                  if (valor.trim().length < 3) {
                    return 'Debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // CAMPO 2: Selección de Curso
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Curso asociado',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                hint: const Text('Seleccione un curso'),
                items: _cursos.map((curso) {
                  return DropdownMenuItem(
                    value: curso,
                    child: Text(curso),
                  );
                }).toList(),
                onChanged: (valor) {
                  setState(() {
                    _cursoSeleccionado = valor;
                  });
                },
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Debe seleccionar un curso';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // CAMPO 3: Descripción
              TextFormField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción o entregable',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Ingrese una breve descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Botón de envío
              FilledButton.icon(
                onPressed: _guardarFormulario,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}