import 'package:flutter/material.dart';
import 'register_incident_screen.dart';
import 'incident_list_screen.dart';
import 'about_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea 8 - Asignación P2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMenuButton(context, 'Registrar Incidencia', RegisterIncidentScreen()),
            _buildMenuButton(context, 'Ver Incidencias', IncidentListScreen()),
            _buildMenuButton(context, 'Acerca de', AboutScreen()),
            _buildMenuButton(context, 'Configuración de Seguridad', SettingsScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, Widget screen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Text(text),
    );
  }
}
