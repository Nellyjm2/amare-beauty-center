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

/// HU-16/HU-18: true si la cita es futura y su estado es Confirmada o
/// Pendiente
bool esCitaProxima(
  DateTime? fecha,
  String? horario,
  String? estado,
) {
  if (fecha == null) {
    return false;
  }
  final est = (estado ?? '').trim().toLowerCase();
  if (est != 'confirmada' && est != 'pendiente') return false;
  final partes = (horario ?? '').split(':');
  final h = partes.length >= 2 ? (int.tryParse(partes[0].trim()) ?? 0) : 0;
  final m = partes.length >= 2 ? (int.tryParse(partes[1].trim()) ?? 0) : 0;
  final local = fecha.toLocal();
  final inicio = DateTime(local.year, local.month, local.day, h, m);
  return inicio.isAfter(DateTime.now());
}
