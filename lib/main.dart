import 'package:flutter/material.dart';
import 'screens/medicamento/lista.dart';

void main() => runApp(const MedTrackerApp());

class MedTrackerApp extends StatelessWidget {
  const MedTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedTracker',
      home: const ListaMedicamentos(),

      // Configuração de tema do app
      theme: ThemeData(
        // Ativa o estilo Material 3, mais atual e com suporte aos widgets modernos
        useMaterial3: true,

        // Paleta de cores com tom azul-médico (teal)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),

        // Define a cor principal do aplicativo
        primaryColor: Colors.teal.shade800,

        // Tema para a AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade800, // Fundo da AppBar
          foregroundColor: Colors.white,          // Texto e ícones na AppBar
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Tema para botões elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade700, // Cor de fundo do botão
            foregroundColor: Colors.white,          // Cor do texto/ícones no botão
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),

        // Tema para o FloatingActionButton (FAB)
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal.shade700, // Cor do botão flutuante
          foregroundColor: Colors.white,          // Cor do ícone
        ),

        // Tema para campos de texto (TextField)
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(), // Borda padrão nos campos
        ),
      ),
    );
  }
} // main