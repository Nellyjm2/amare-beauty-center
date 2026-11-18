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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> consultarHorariosDisponibles(
  String dateKey,
  DocumentReference servicioRef,
) async {
  final db = FirebaseFirestore.instance;
  const blockMinutes = 30;

  // Fecha y hora de Costa Rica (UTC-6).
  final ahoraCR = DateTime.now().toUtc().subtract(const Duration(hours: 6));

  String dosDigitos(int n) => n.toString().padLeft(2, '0');

  final hoy =
      '${ahoraCR.year}-${dosDigitos(ahoraCR.month)}-${dosDigitos(ahoraCR.day)}';

  final minutoActual = ahoraCR.hour * 60 + ahoraCR.minute;

  // Validar fecha.
  final fecha = DateTime.tryParse('${dateKey}T12:00:00Z');

  if (fecha == null ||
      '${fecha.year}-${dosDigitos(fecha.month)}-${dosDigitos(fecha.day)}' !=
          dateKey) {
    return [];
  }

  if (dateKey.compareTo(hoy) < 0) {
    return [];
  }

  // Obtener informacion del servicio.
  final servicioDoc = await servicioRef.get();

  if (!servicioDoc.exists) {
    return [];
  }

  final servicio = servicioDoc.data() as Map<String, dynamic>?;

  if (servicio == null || servicio['is_active'] != true) {
    return [];
  }

  final duracion = servicio['duration_minutes'];

  if (duracion is! int || duracion <= 0 || duracion % blockMinutes != 0) {
    return [];
  }

  final bloquesNecesarios = duracion ~/ blockMinutes;

  // Obtener los bloques del dia seleccionado.
  final resultado =
      await db.collection('slots').where('date_key', isEqualTo: dateKey).get();

  final bloquesLibres = <int>{};

  for (final documento in resultado.docs) {
    final slot = documento.data();
    final minuto = slot['start_minute'];

    if (minuto is! int) {
      continue;
    }

    if (minuto < 0 || minuto >= 1440 || minuto % blockMinutes != 0) {
      continue;
    }

    final idEsperado = '${dateKey}_$minuto';

    if (documento.id == idEsperado &&
        slot['is_enabled'] == true &&
        slot['appointment_ref'] == null) {
      bloquesLibres.add(minuto);
    }
  }

  final disponibles = <String>[];
  final inicios = bloquesLibres.toList()..sort();

  // Verificar que existan bloques consecutivos.
  for (final inicio in inicios) {
    if (inicio + duracion > 1440) {
      continue;
    }

    if (dateKey == hoy && inicio <= minutoActual) {
      continue;
    }

    bool todosLibres = true;

    for (int i = 0; i < bloquesNecesarios; i++) {
      final minuto = inicio + (i * blockMinutes);

      if (!bloquesLibres.contains(minuto)) {
        todosLibres = false;
        break;
      }
    }

    if (todosLibres) {
      final horas = dosDigitos(inicio ~/ 60);
      final minutos = dosDigitos(inicio % 60);

      disponibles.add('$horas:$minutos');
    }
  }

  return disponibles;
}
