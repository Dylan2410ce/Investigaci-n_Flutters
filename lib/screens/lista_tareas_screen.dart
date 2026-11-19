import 'package:flutter/material.dart';
import '../models/tarea.dart';
import 'agregar_tarea_screen.dart';

class ListaTareasScreen extends StatefulWidget {
  const ListaTareasScreen({super.key});

  @override
  State<ListaTareasScreen> createState() => _ListaTareasScreenState();
}

class _ListaTareasScreenState extends State<ListaTareasScreen> {
  // Lista local con datos de ejemplo para que la pantalla no inicie vacía
  final List<Tarea> _tareas = [
    Tarea(
      titulo: 'Demo práctica en Flutter',
      curso: 'Desarrollo de Software IV',
      descripcion: 'Crear app con dos vistas, formulario validado y listado.',
      prioridad: 'Alta',
    ),
    Tarea(
      titulo: 'Normalización de tablas',
      curso: 'Bases de Datos',
      descripcion: 'Aplicar hasta tercera forma normal al modelo relacional.',
      prioridad: 'Media',
      completada: true,
    ),
  ];

  // Abre la segunda pantalla y espera a que devuelva la nueva tarea creada
  Future<void> _irAgregarTarea() async {
    final nuevaTarea = await Navigator.push<Tarea>(
      context,
      MaterialPageRoute(builder: (context) => const AgregarTareaScreen()),
    );

<<<<<<< HEAD
=======
    if (!mounted) return;

>>>>>>> ff69815c75a38bf491fea1309ffd1b0e333d3881
    // Si el usuario guardó datos válidos (no se devolvió con la flecha atrás)
    if (nuevaTarea != null) {
      setState(() {
        _tareas.insert(0, nuevaTarea); // Agrega la tarea al inicio de la lista
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Agregada: ${nuevaTarea.titulo}'),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Marca o desmarca una tarea como completada y actualiza la pantalla
  void _cambiarEstado(Tarea tarea, bool? valor) {
    setState(() {
      tarea.completada = valor ?? false;
    });
  }

  // Elimina una tarea de la lista según su posición
  void _eliminarTarea(int index) {
    final eliminada = _tareas[index].titulo;
    setState(() {
      _tareas.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Se eliminó "$eliminada"'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Devuelve un color distinto según el nivel de prioridad de la tarea
  Color _colorPrioridad(String prioridad) {
    if (prioridad == 'Alta') return Colors.red.shade700;
    if (prioridad == 'Media') return Colors.orange.shade800;
    return Colors.green.shade700;
  }

  @override
  Widget build(BuildContext context) {
    // Calcula cuántas tareas están listas para mostrarlo en el resumen
    final completadas = _tareas.where((t) => t.completada).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Tareas Académicas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Tarjeta superior de resumen con degradado azul
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1D4ED8), Color(0xFF3B82F6)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Resumen del semestre',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$completadas de ${_tareas.length} completadas',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.task_alt, color: Colors.white, size: 40),
              ],
            ),
          ),

          // Cuerpo principal: mensaje si está vacío o lista dinámica de tarjetas
          Expanded(
            child: _tareas.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          'No tienes tareas pendientes',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _tareas.length,
                    itemBuilder: (context, index) {
                      final tarea = _tareas[index];
                      final colorTag = _colorPrioridad(tarea.prioridad);

                      return Card(
                        color: Colors.white,
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Checkbox para marcar como lista
                              Checkbox(
                                value: tarea.completada,
                                onChanged: (valor) => _cambiarEstado(tarea, valor),
                              ),
                              // Información central de la tarea
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Etiquetas de curso y prioridad
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorTag.withAlpha(30),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            tarea.prioridad,
                                            style: TextStyle(
                                              color: colorTag,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            tarea.curso,
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    // Título de la tarea
                                    Text(
                                      tarea.titulo,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: tarea.completada
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Descripción
                                    Text(
                                      tarea.descripcion,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Botón para borrar
                              IconButton(
                                icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
                                onPressed: () => _eliminarTarea(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      // Botón flotante para ir al formulario
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _irAgregarTarea,
        backgroundColor: const Color(0xFF1D4ED8),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Tarea'),
      ),
    );
  }
}
