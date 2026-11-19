import 'package:flutter/material.dart';
import '../models/tarea.dart';

class AgregarTareaScreen extends StatefulWidget {
  const AgregarTareaScreen({super.key});

  @override
  State<AgregarTareaScreen> createState() => _AgregarTareaScreenState();
}

class _AgregarTareaScreenState extends State<AgregarTareaScreen> {
  // Llave que permite validar todos los campos del formulario al mismo tiempo
  final _formKey = GlobalKey<FormState>();

  // Controladores para leer lo que el usuario escribe en los campos de texto
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  String? _cursoSeleccionado;
  String _prioridadSeleccionada = 'Media';

  final List<String> _cursos = [
    'Desarrollo de Software IV',
    'Bases de Datos',
    'Ingeniería de Software',
    'Redes y Comunicaciones',
  ];

  final List<String> _prioridades = ['Alta', 'Media', 'Baja'];

  // Valida el formulario y devuelve el objeto Tarea a la pantalla anterior
  void _guardarTarea() {
    if (_formKey.currentState!.validate()) {
      final tareaCreada = Tarea(
        titulo: _tituloController.text.trim(),
        curso: _cursoSeleccionado!,
        descripcion: _descripcionController.text.trim(),
        prioridad: _prioridadSeleccionada,
      );

      // Cierra esta vista y envía la tarea de regreso
      Navigator.pop(context, tareaCreada);
    }
  }

  // Libera la memoria de los controladores cuando se cierra esta pantalla
  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  // Estilo reutilizable para que los 3 campos del formulario se vean uniformes
  InputDecoration _estiloCampo(String etiqueta, IconData icono) {
    return InputDecoration(
      labelText: etiqueta,
      prefixIcon: Icon(icono),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Nueva Tarea'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CAMPO 1: Título
              TextFormField(
                controller: _tituloController,
                decoration: _estiloCampo('Título de la tarea', Icons.edit_note),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Por favor escribe un título';
                  }
                  if (valor.trim().length < 3) {
                    return 'El título debe tener al menos 3 letras';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // CAMPO 2: Curso (Lista desplegable)
              DropdownButtonFormField<String>(
                decoration: _estiloCampo('Curso', Icons.school_outlined),
                hint: const Text('Selecciona una materia'),
                items: _cursos.map((curso) {
                  return DropdownMenuItem(value: curso, child: Text(curso));
                }).toList(),
                onChanged: (valor) {
                  setState(() => _cursoSeleccionado = valor);
                },
                validator: (valor) {
                  if (valor == null) return 'Debes elegir un curso';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // CAMPO 3: Descripción
              TextFormField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: _estiloCampo('Descripción breve', Icons.description_outlined),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Agrega una descripción de la tarea';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Selector visual de prioridad mediante chips
              const Text(
                'Nivel de prioridad:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 8),
              Row(
                children: _prioridades.map((nivel) {
                  final estaSeleccionado = _prioridadSeleccionada == nivel;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(nivel),
                      selected: estaSeleccionado,
                      onSelected: (_) {
                        setState(() => _prioridadSeleccionada = nivel);
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 28),

              // Botón principal de guardado
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  onPressed: _guardarTarea,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1D4ED8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.check),
                  label: const Text(
                    'Guardar Tarea',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}