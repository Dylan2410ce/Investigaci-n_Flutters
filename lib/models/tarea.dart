class Tarea {
  final String titulo;
  final String curso;
  final String descripcion;
  bool completada;

  Tarea({
    required this.titulo,
    required this.curso,
    required this.descripcion,
    this.completada = false,
  });
}