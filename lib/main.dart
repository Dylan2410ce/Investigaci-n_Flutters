import 'package:flutter/material.dart';
import 'screens/lista_tareas_screen.dart';

// Punto de entrada: es lo primero que ejecuta Dart al iniciar la app
void main() {
  runApp(const GestorTareasApp());
}

class GestorTareasApp extends StatelessWidget {
  const GestorTareasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tareas UCR',
      // Tema global: define colores base y estilo de la barra superior
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1D4ED8), // Azul principal
          surface: const Color(0xFFF1F5F9),   // Fondo gris muy suave
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1D4ED8),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      // Pantalla principal que se carga al abrir la aplicación
      home: const ListaTareasScreen(),
    );
  }
}
