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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
// ...

Future<String> reservarCita(
  String dateKey,
  String timeStr,
  DocumentReference servicioRef,
  DocumentReference usuarioRef,
  String nombreUsuario,
) async {
  final db = FirebaseFirestore.instance;
  const int blockMinutes = 30;

  // 1. Verificar que el usuario inicio sesion.
  final usuario = FirebaseAuth.instance.currentUser;

  if (usuario == null) {
    return 'ERROR_USUARIO';
  }

  // En este proyecto se asume que el documento
  // users tiene como ID el UID de Firebase Auth.
  if (usuarioRef.id != usuario.uid) {
    return 'ERROR_USUARIO';
  }

  // 2. Validar la fecha seleccionada.
  final formatoFecha = RegExp(r'^\d{4}-\d{2}-\d{2}$');

  if (!formatoFecha.hasMatch(dateKey)) {
    return 'FECHA_INVALIDA';
  }

  final fecha = DateTime.tryParse(
    '${dateKey}T12:00:00Z',
  );

  if (fecha == null) {
    return 'FECHA_INVALIDA';
  }

  String dosDigitos(int numero) {
    return numero.toString().padLeft(2, '0');
  }

  final fechaValidada = '${fecha.year}-'
      '${dosDigitos(fecha.month)}-'
      '${dosDigitos(fecha.day)}';

  if (fechaValidada != dateKey) {
    return 'FECHA_INVALIDA';
  }

  // 3. Validar formato de la hora HH:mm.
  final formatoHora = RegExp(
    r'^([01]\d|2[0-3]):(00|30)$',
  );

  if (!formatoHora.hasMatch(timeStr)) {
    return 'HORA_INVALIDA';
  }

  final partesHora = timeStr.split(':');

  final startMinute = int.parse(partesHora[0]) * 60 + int.parse(partesHora[1]);

  // 4. Obtener la fecha y hora de Costa Rica.
  final ahoraCR = DateTime.now().toUtc().subtract(const Duration(hours: 6));

  final hoy = '${ahoraCR.year}-'
      '${dosDigitos(ahoraCR.month)}-'
      '${dosDigitos(ahoraCR.day)}';

  final minutoActual = ahoraCR.hour * 60 + ahoraCR.minute;

  // No permitir horarios pasados.
  if (dateKey.compareTo(hoy) < 0 ||
      (dateKey == hoy && startMinute <= minutoActual)) {
    return 'HORARIO_PASADO';
  }

  // 5. Crear una referencia para la nueva cita.
  final citaRef = db.collection('appointments').doc();

  try {
    // 6. Iniciar transaccion de Firestore.
    return await db.runTransaction<String>(
      (transaction) async {
        // Consultar el servicio seleccionado.
        final servicioDoc = await transaction.get(servicioRef);

        if (!servicioDoc.exists) {
          throw StateError('SERVICIO_INVALIDO');
        }

        final servicio = servicioDoc.data();

        if (servicio is! Map<String, dynamic>) {
          throw StateError('SERVICIO_INVALIDO');
        }

        if (servicio['is_active'] != true) {
          throw StateError('SERVICIO_INVALIDO');
        }

        // Obtener duracion del servicio.
        final duracion = servicio['duration_minutes'];

        if (duracion is! int || duracion <= 0 || duracion % blockMinutes != 0) {
          throw StateError('DURACION_INVALIDA');
        }

        if (startMinute + duracion > 1440) {
          throw StateError('HORARIO_INVALIDO');
        }

        // Calcular bloques necesarios.
        final cantidadBloques = duracion ~/ blockMinutes;

        final referencias = <DocumentReference>[];
        final documentos = <DocumentSnapshot>[];
        final slotIds = <String>[];

        // 7. Leer todos los bloques necesarios.
        for (int i = 0; i < cantidadBloques; i++) {
          final minuto = startMinute + (i * blockMinutes);

          final slotId = '${dateKey}_$minuto';

          final referencia = db.collection('slots').doc(slotId);

          final documento = await transaction.get(referencia);

          referencias.add(referencia);
          documentos.add(documento);
          slotIds.add(slotId);
        }

        // 8. Comprobar que TODOS esten libres.
        for (int i = 0; i < documentos.length; i++) {
          final documento = documentos[i];

          if (!documento.exists) {
            throw StateError('OCUPADO');
          }

          final slot = documento.data();

          if (slot is! Map<String, dynamic>) {
            throw StateError('OCUPADO');
          }

          final minutoEsperado = startMinute + (i * blockMinutes);

          if (slot['is_enabled'] != true ||
              slot['appointment_ref'] != null ||
              slot['date_key'] != dateKey ||
              slot['start_minute'] != minutoEsperado) {
            throw StateError('OCUPADO');
          }
        }

        // 9. Preparar la fecha de la cita.
        // 06:00 UTC = 00:00 en Costa Rica.
        final fechaCita = DateTime.utc(
          fecha.year,
          fecha.month,
          fecha.day,
          6,
        );

        // 10. Registrar la cita.
        transaction.set(citaRef, {
          'user_ref': usuarioRef,
          'service_ref': servicioRef,
          'user_name': nombreUsuario,
          'service_name': servicio['name'] ?? '',
          'price_snapshot': servicio['price'] ?? 0,
          'date': Timestamp.fromDate(fechaCita),
          'time_slot': timeStr,
          'status': 'pendiente',
          'created_at': FieldValue.serverTimestamp(),

          // Campos adicionales para controlar horarios.
          'date_key': dateKey,
          'start_minute': startMinute,
          'duration_minutes_snapshot': duracion,
          'slot_ids': slotIds,
        });

        // 11. Bloquear todos los horarios usados.
        for (final referencia in referencias) {
          transaction.update(referencia, {
            'appointment_ref': citaRef,
          });
        }

        // 12. Devolver el identificador de la cita.
        return 'OK:${citaRef.id}';
      },
    );
  } on FirebaseException catch (error) {
    // Manejar errores de Firebase.
    if (error.code == 'permission-denied') {
      return 'SIN_PERMISOS';
    }

    if (error.code == 'unavailable') {
      return 'SIN_CONEXION';
    }

    return 'ERROR_FIRESTORE:${error.code}';
  } on StateError catch (error) {
    return error.message.toString();
  } catch (error) {
    return 'ERROR_RESERVA';
  }
}
