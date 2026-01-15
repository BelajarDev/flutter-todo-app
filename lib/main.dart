// main.dart
import 'package:flutter/material.dart';
import 'todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Primary color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade700,
          primary: Colors.blue.shade700,
          secondary: Colors.orange.shade600,
          tertiary: Colors.green.shade600,
          brightness: Brightness.light,
        ),

        // AppBar theme
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: Colors.grey.shade700),
        ),

        // Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),

        // Text field theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),

        // Card theme - menggunakan CardThemeData
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          margin: EdgeInsets.zero,
        ),

        // List tile theme
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tileColor: Colors.white,
        ),

        // Floating action button theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Use Material 3
        useMaterial3: false, // Nonaktifkan Material 3 untuk kompatibilitas
        // Font
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade800,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.grey.shade800),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          bodySmall: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),

        // Scaffold background color
        scaffoldBackgroundColor: Colors.grey.shade50,

        // Divider theme
        dividerTheme: DividerThemeData(
          color: Colors.grey.shade200,
          thickness: 1,
          space: 0,
        ),

        // Chip theme
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey.shade100,
          selectedColor: Colors.blue.shade100,
          checkmarkColor: Colors.blue.shade700,
          labelStyle: TextStyle(color: Colors.grey.shade700),
          secondaryLabelStyle: TextStyle(color: Colors.blue.shade700),
          brightness: Brightness.light,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: StadiumBorder(side: BorderSide.none),
        ),
      ),
      home: TodoPage(),
    );
  }
}
