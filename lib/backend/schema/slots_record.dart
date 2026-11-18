import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SlotsRecord extends FirestoreRecord {
  SlotsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date_key" field.
  String? _dateKey;
  String get dateKey => _dateKey ?? '';
  bool hasDateKey() => _dateKey != null;

  // "start_minute" field.
  int? _startMinute;
  int get startMinute => _startMinute ?? 0;
  bool hasStartMinute() => _startMinute != null;

  // "is_enabled" field.
  bool? _isEnabled;
  bool get isEnabled => _isEnabled ?? false;
  bool hasIsEnabled() => _isEnabled != null;

  // "appointment_ref" field.
  DocumentReference? _appointmentRef;
  DocumentReference? get appointmentRef => _appointmentRef;
  bool hasAppointmentRef() => _appointmentRef != null;

  void _initializeFields() {
    _dateKey = snapshotData['date_key'] as String?;
    _startMinute = castToType<int>(snapshotData['start_minute']);
    _isEnabled = snapshotData['is_enabled'] as bool?;
    _appointmentRef = snapshotData['appointment_ref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('slots');

  static Stream<SlotsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SlotsRecord.fromSnapshot(s));

  static Future<SlotsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SlotsRecord.fromSnapshot(s));

  static SlotsRecord fromSnapshot(DocumentSnapshot snapshot) => SlotsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SlotsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SlotsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SlotsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SlotsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createSlotsRecordData({
  String? dateKey,
  int? startMinute,
  bool? isEnabled,
  DocumentReference? appointmentRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date_key': dateKey,
      'start_minute': startMinute,
      'is_enabled': isEnabled,
      'appointment_ref': appointmentRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class SlotsRecordDocumentEquality implements Equality<SlotsRecord> {
  const SlotsRecordDocumentEquality();

  @override
  bool equals(SlotsRecord? e1, SlotsRecord? e2) {
    return e1?.dateKey == e2?.dateKey &&
        e1?.startMinute == e2?.startMinute &&
        e1?.isEnabled == e2?.isEnabled &&
        e1?.appointmentRef == e2?.appointmentRef;
  }

  @override
  int hash(SlotsRecord? e) => const ListEquality()
      .hash([e?.dateKey, e?.startMinute, e?.isEnabled, e?.appointmentRef]);

  @override
  bool isValidKey(Object? o) => o is SlotsRecord;
}
