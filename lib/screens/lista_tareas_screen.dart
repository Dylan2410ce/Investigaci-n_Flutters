import 'package:flutter/material.dart';
import '../models/tarea.dart';
import 'agregar_tarea_screen.dart';

class ListaTareasScreen extends StatefulWidget {
  const ListaTareasScreen({super.key});

  @override
  State<ListaTareasScreen> createState() => _ListaTareasScreenState();
}

class _ListaTareasScreenState extends State<ListaTareasScreen> {
  // Datos iniciales locales en memoria
  final List<Tarea> _tareas = [
    Tarea(
      titulo: 'Investigación Flutter',
      curso: 'Desarrollo de Software IV',
      descripcion: 'Preparar demostración práctica con dos vistas y formulario.',
    ),
    Tarea(
      titulo: 'Diagrama Entidad-Relación',
      curso: 'Bases de Datos',
      descripcion: 'Normalizar tablas hasta tercera forma normal.',
      completada: true,
    ),
  ];

  // Navega a la segunda pantalla y espera el resultado
  Future<void> _navegarAgregarTarea() async {
    final tareaCreada = await Navigator.push<Tarea>(
      context,
      MaterialPageRoute(
        builder: (context) => const AgregarTareaScreen(),
      ),
    );

    // Si el usuario guardó una tarea válida, actualiza la lista y muestra alerta visual
    if (tareaCreada != null) {
      setState(() {
        _tareas.add(tareaCreada);
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tarea "${tareaCreada.titulo}" agregada con éxito'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _eliminarTarea(int index) {
    final tituloEliminado = _tareas[index].titulo;
    setState(() {
      _tareas.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tarea "$tituloEliminado" eliminada')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Tareas UCR'),
        centerTitle: true,
      ),
      body: _tareas.isEmpty
          ? const Center(
              child: Text('No hay tareas pendientes. ¡Agrega una nueva!'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _tareas.length,
              itemBuilder: (context, index) {
                final tarea = _tareas[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Checkbox(
                      value: tarea.completada,
                      onChanged: (valor) {
                        setState(() {
                          tarea.completada = valor ?? false;
                        });
                      },
                    ),
                    title: Text(
                      tarea.titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: tarea.completada
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text('${tarea.curso}\n${tarea.descripcion}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _eliminarTarea(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navegarAgregarTarea,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Tarea'),
      ),
    );
  }
}