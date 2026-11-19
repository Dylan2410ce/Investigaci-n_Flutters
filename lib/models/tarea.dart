// Modelo que representa la estructura de una tarea en la aplicación
class Tarea {
  String titulo;
  String curso;
  String descripcion;
  String prioridad; // Puede ser: 'Alta', 'Media' o 'Baja'
  bool completada;

  Tarea({
    required this.titulo,
    required this.curso,
    required this.descripcion,
    this.prioridad = 'Media',
    this.completada = false,
  });
}
