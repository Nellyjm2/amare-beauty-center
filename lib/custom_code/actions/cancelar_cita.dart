// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/auth/firebase_auth/auth_util.dart';

/// HU-18: cancela una cita del usuario autenticado usando una transaccion de
/// Firestore
Future<String> cancelarCita(DocumentReference citaRef) async {
  final usuario = currentUserReference;
  if (usuario == null) return 'Debes iniciar sesión para cancelar la cita.';
  try {
    return await FirebaseFirestore.instance.runTransaction<String>((tx) async {
      final snap = await tx.get(citaRef);
      if (!snap.exists) return 'La cita no existe.';
      final data = snap.data() as Map<String, dynamic>;
      if (data['user_ref'] != usuario)
        return 'No puedes cancelar una cita de otro usuario.';
      final fecha = (data['date'] as Timestamp?)?.toDate();
      final estado = (data['status'] ?? '').toString().trim().toLowerCase();
      if (estado != 'confirmada' && estado != 'pendiente')
        return 'Esta cita ya no puede cancelarse.';
      final partes = (data['time_slot'] ?? '').toString().split(':');
      final h = partes.length >= 2 ? (int.tryParse(partes[0].trim()) ?? 0) : 0;
      final m = partes.length >= 2 ? (int.tryParse(partes[1].trim()) ?? 0) : 0;
      final local = fecha?.toLocal();
      if (local == null ||
          !DateTime(local.year, local.month, local.day, h, m)
              .isAfter(DateTime.now()))
        return 'Esta cita ya no puede cancelarse.';
      tx.update(citaRef, {'status': 'Cancelada'});
      return 'Cita cancelada correctamente. El horario quedó disponible.';
    });
  } catch (e) {
    return 'No se pudo cancelar la cita. Intenta de nuevo.';
  }
}
