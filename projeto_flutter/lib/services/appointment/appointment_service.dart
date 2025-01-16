import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveAppointment({
    required String userId,
    required String psychologistId,
    required DateTime dateTime,
  }) async {
    try {
      final currentTime = DateTime.now();

      final timeDifference = dateTime.difference(currentTime);

      if (timeDifference.inMinutes < 29 && currentTime.isBefore(dateTime)) {
        throw Exception(
            "Você não pode marcar uma consulta nos próximos 30 minutos.");
      }

      final startLimit = dateTime.subtract(const Duration(minutes: 29));
      final endLimit = dateTime.add(const Duration(minutes: 29));

      QuerySnapshot snapshot = await _firestore
          .collection('appointments')
          .where('psychologist_id', isEqualTo: psychologistId)
          .where('date', isGreaterThanOrEqualTo: startLimit.toIso8601String())
          .where('date', isLessThanOrEqualTo: endLimit.toIso8601String())
          .get();

      if (snapshot.docs.isNotEmpty) {
        throw Exception(
            "O psicólogo já tem uma consulta nesse horário ou nos próximos 30 minutos.");
      }

      await _firestore.collection('appointments').add({
        'user_id': userId,
        'psychologist_id': psychologistId,
        'date': dateTime.toIso8601String(),
        'status': 'pending',
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Erro ao salvar consulta: $e");
    }
  }
}
