import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AppointmentsRecord extends FirestoreRecord {
  AppointmentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "service_ref" field.
  DocumentReference? _serviceRef;
  DocumentReference? get serviceRef => _serviceRef;
  bool hasServiceRef() => _serviceRef != null;

  // "user_name" field.
  String? _userName;
  String get userName => _userName ?? '';
  bool hasUserName() => _userName != null;

  // "service_name" field.
  String? _serviceName;
  String get serviceName => _serviceName ?? '';
  bool hasServiceName() => _serviceName != null;

  // "price_snapshot" field.
  double? _priceSnapshot;
  double get priceSnapshot => _priceSnapshot ?? 0.0;
  bool hasPriceSnapshot() => _priceSnapshot != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "time_slot" field.
  String? _timeSlot;
  String get timeSlot => _timeSlot ?? '';
  bool hasTimeSlot() => _timeSlot != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "date_key" field.
  String? _dateKey;
  String get dateKey => _dateKey ?? '';
  bool hasDateKey() => _dateKey != null;

  // "start_minute" field.
  int? _startMinute;
  int get startMinute => _startMinute ?? 0;
  bool hasStartMinute() => _startMinute != null;

  // "duration_minutes_snapshot" field.
  int? _durationMinutesSnapshot;
  int get durationMinutesSnapshot => _durationMinutesSnapshot ?? 0;
  bool hasDurationMinutesSnapshot() => _durationMinutesSnapshot != null;

  // "slot_ids" field.
  List<String>? _slotIds;
  List<String> get slotIds => _slotIds ?? const [];
  bool hasSlotIds() => _slotIds != null;

  void _initializeFields() {
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _serviceRef = snapshotData['service_ref'] as DocumentReference?;
    _userName = snapshotData['user_name'] as String?;
    _serviceName = snapshotData['service_name'] as String?;
    _priceSnapshot = castToType<double>(snapshotData['price_snapshot']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _timeSlot = snapshotData['time_slot'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _dateKey = snapshotData['date_key'] as String?;
    _startMinute = castToType<int>(snapshotData['start_minute']);
    _durationMinutesSnapshot =
        castToType<int>(snapshotData['duration_minutes_snapshot']);
    _slotIds = getDataList(snapshotData['slot_ids']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('appointments');

  static Stream<AppointmentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AppointmentsRecord.fromSnapshot(s));

  static Future<AppointmentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AppointmentsRecord.fromSnapshot(s));

  static AppointmentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AppointmentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AppointmentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AppointmentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AppointmentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AppointmentsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createAppointmentsRecordData({
  DocumentReference? userRef,
  DocumentReference? serviceRef,
  String? userName,
  String? serviceName,
  double? priceSnapshot,
  DateTime? createdAt,
  String? status,
  String? timeSlot,
  DateTime? date,
  String? dateKey,
  int? startMinute,
  int? durationMinutesSnapshot,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_ref': userRef,
      'service_ref': serviceRef,
      'user_name': userName,
      'service_name': serviceName,
      'price_snapshot': priceSnapshot,
      'created_at': createdAt,
      'status': status,
      'time_slot': timeSlot,
      'date': date,
      'date_key': dateKey,
      'start_minute': startMinute,
      'duration_minutes_snapshot': durationMinutesSnapshot,
    }.withoutNulls,
  );

  return firestoreData;
}

class AppointmentsRecordDocumentEquality
    implements Equality<AppointmentsRecord> {
  const AppointmentsRecordDocumentEquality();

  @override
  bool equals(AppointmentsRecord? e1, AppointmentsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userRef == e2?.userRef &&
        e1?.serviceRef == e2?.serviceRef &&
        e1?.userName == e2?.userName &&
        e1?.serviceName == e2?.serviceName &&
        e1?.priceSnapshot == e2?.priceSnapshot &&
        e1?.createdAt == e2?.createdAt &&
        e1?.status == e2?.status &&
        e1?.timeSlot == e2?.timeSlot &&
        e1?.date == e2?.date &&
        e1?.dateKey == e2?.dateKey &&
        e1?.startMinute == e2?.startMinute &&
        e1?.durationMinutesSnapshot == e2?.durationMinutesSnapshot &&
        listEquality.equals(e1?.slotIds, e2?.slotIds);
  }

  @override
  int hash(AppointmentsRecord? e) => const ListEquality().hash([
        e?.userRef,
        e?.serviceRef,
        e?.userName,
        e?.serviceName,
        e?.priceSnapshot,
        e?.createdAt,
        e?.status,
        e?.timeSlot,
        e?.date,
        e?.dateKey,
        e?.startMinute,
        e?.durationMinutesSnapshot,
        const ListEquality().hash(e?.slotIds)
      ]);

  @override
  bool isValidKey(Object? o) => o is AppointmentsRecord;
}
