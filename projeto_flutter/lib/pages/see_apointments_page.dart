import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeeAppointmentsPage extends StatefulWidget {
  const SeeAppointmentsPage({super.key});

  @override
  _SeeAppointmentsPageState createState() => _SeeAppointmentsPageState();
}

class _SeeAppointmentsPageState extends State<SeeAppointmentsPage> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _appointments = [];
  final Map<String, String> _userNames = {};

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('appointments')
            .where('psychologist_id', isEqualTo: userId)
            .get();

        final List<Map<String, dynamic>> loadedAppointments =
            snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'user_id': data['user_id'],
            'psychologist_id': data['psychologist_id'],
            'date': DateTime.parse(data['date']),
            'status': data['status'],
            'created_at': data['created_at'],
            'id': doc.id,
          };
        }).toList();

        for (var appointment in loadedAppointments) {
          final userId = appointment['user_id'];
          await _fetchUserName(userId);
        }

        setState(() {
          _appointments = loadedAppointments;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar consultas: $e")),
      );
    }
  }

  Future<void> _fetchUserName(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final userName = userData['name'] ?? 'Nome não encontrado';
        setState(() {
          _userNames[userId] = userName;
        });
      }
    } catch (e) {
      setState(() {
        _userNames[userId] = 'Erro ao carregar nome';
      });
    }
  }

  Future<void> _markAsCompleted(String appointmentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .update({'status': 'Terminada'});

      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .delete();

      setState(() {
        _appointments
            .removeWhere((appointment) => appointment['id'] == appointmentId);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao atualizar status: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultas Agendadas"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _appointments.isEmpty
              ? const Center(child: Text("Nenhuma consulta agendada."))
              : ListView.builder(
                  itemCount: _appointments.length,
                  itemBuilder: (ctx, index) {
                    final appointment = _appointments[index];
                    final date = appointment['date'] as DateTime;
                    final userId = appointment['user_id'] as String;
                    final status = appointment['status'] as String;
                    final userName = _userNames[userId] ?? 'Carregando nome...';
                    final appointmentId = appointment['id'] as String;

                    return ListTile(
                      title: Text("Consulta com o utilizador: $userName"),
                      subtitle:
                          Text("Data: ${date.toLocal()} - Status: $status"),
                      trailing: status == 'Terminada'
                          ? const Icon(Icons.check, color: Colors.green)
                          : IconButton(
                              icon: const Icon(Icons.check),
                              onPressed: () => _markAsCompleted(appointmentId),
                            ),
                      onTap: () {},
                    );
                  },
                ),
    );
  }
}
