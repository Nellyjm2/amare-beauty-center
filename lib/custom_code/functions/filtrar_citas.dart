import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import '/flutter_flow/ff_builtin_enums.dart';
import '/auth/firebase_auth/auth_util.dart';

List<AppointmentsRecord> filtrarCitas(
  List<AppointmentsRecord>? citas,
  bool proximas,
) {
  String k(AppointmentsRecord c) =>
      (c.date?.toIso8601String().substring(0, 10) ?? '') + ' ' + c.timeSlot;
  bool prox(AppointmentsRecord c) =>
      ['confirmada', 'pendiente'].contains(c.status.trim().toLowerCase()) &&
      c.date != null &&
      DateTime(
              c.date!.toLocal().year,
              c.date!.toLocal().month,
              c.date!.toLocal().day,
              int.tryParse(c.timeSlot.split(':').first.trim()) ?? 0,
              c.timeSlot.contains(':')
                  ? (int.tryParse(c.timeSlot.split(':')[1].trim()) ?? 0)
                  : 0)
          .isAfter(DateTime.now());
  final lista = (citas ?? []).where((c) => prox(c) == proximas).toList();
  lista.sort((a, b) => proximas ? k(a).compareTo(k(b)) : k(b).compareTo(k(a)));
  return lista;
}
