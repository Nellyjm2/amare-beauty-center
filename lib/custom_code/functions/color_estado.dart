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

Color colorEstado(String? estado) {
  final e = (estado ?? '').trim().toLowerCase();
  if (e == 'confirmada') return const Color(0xFF60A5FA);
  if (e == 'pendiente') return const Color(0xFFD4AF37);
  if (e == 'completada') return const Color(0xFF4ADE80);
  if (e == 'cancelada') return const Color(0xFFF87171);
  return const Color(0xFFE0E0E0);
}
