import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/appointment/appointment_service.dart';

class ScheduleAppointmentPage extends StatefulWidget {
  const ScheduleAppointmentPage({super.key});

  @override
  _ScheduleAppointmentPageState createState() =>
      _ScheduleAppointmentPageState();
}

class _ScheduleAppointmentPageState extends State<ScheduleAppointmentPage> {
  String? _selectedPsychologist;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<Map<String, String>> _psychologists = [];
  bool _isLoading = true;
  final AppointmentService _appointmentService = AppointmentService();

  @override
  void initState() {
    super.initState();
    _fetchPsychologists();
  }

  Future<void> _fetchPsychologists() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('role', isEqualTo: 'Psicólogo')
          .get();

      final List<Map<String, String>> loadedPsychologists =
          snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'name': (data['name'] ?? 'Nome não disponível').toString(),
        };
      }).toList();

      setState(() {
        _psychologists = loadedPsychologists;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  void _submitAppointment() async {
    if (_selectedPsychologist != null &&
        _selectedDate != null &&
        _selectedTime != null) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final DateTime appointmentDate = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      try {
        await _appointmentService.saveAppointment(
          userId: userId,
          psychologistId: _selectedPsychologist!,
          dateTime: appointmentDate,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Consulta marcada com sucesso!")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Marcar Consulta")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Marca uma consulta de apoio!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedPsychologist,
                    hint: Text(
                      "Escolha um psicólogo",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedPsychologist = value;
                      });
                    },
                    items: _psychologists.map((psychologist) {
                      return DropdownMenuItem(
                        value: psychologist['id'],
                        child: Text(
                          psychologist['name']!,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickDate,
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    child: Text(
                      _selectedDate == null
                          ? "Escolha uma data"
                          : "Data: ${_selectedDate!.toLocal()}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickTime,
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    child: Text(
                      _selectedTime == null
                          ? "Escolha uma hora"
                          : "Hora: ${_selectedTime!.format(context)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _submitAppointment,
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    child: const Text(
                      "Confirmar Consulta",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
