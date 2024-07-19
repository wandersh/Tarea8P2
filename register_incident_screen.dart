import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterIncidentScreen extends StatefulWidget {
  @override
  _RegisterIncidentScreenState createState() => _RegisterIncidentScreenState();
}

class _RegisterIncidentScreenState extends State<RegisterIncidentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title, _description;
  DateTime _date = DateTime.now();
  String _imagePath;
  String _audioPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Título'),
                  onSaved: (value) => _title = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor ingrese un título';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descripción'),
                  onSaved: (value) => _description = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor ingrese una descripción';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Text('Fecha: ${DateFormat('dd/MM/yyyy').format(_date)}'),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: _selectDate,
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                _buildImagePicker(),
                SizedBox(height: 16.0),
                _buildAudioRecorder(),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date)
      setState(() {
        _date = picked;
      });
  }

  Widget _buildImagePicker() {
    return Row(
      children: [
        _imagePath == null
            ? Text('No se ha seleccionado ninguna imagen')
            : Image.file(File(_imagePath), width: 100, height: 100),
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: _pickImage,
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    // Implementación para seleccionar imagen
  }

  Widget _buildAudioRecorder() {
    return Row(
      children: [
        _audioPath == null
            ? Text('No se ha grabado ningún audio')
            : Icon(Icons.audiotrack),
        IconButton(
          icon: Icon(Icons.mic),
          onPressed: _recordAudio,
        ),
      ],
    );
  }

  Future<void> _recordAudio() async {
    // Implementación para grabar audio
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Guardar la incidencia en la base de datos
    }
  }
}
