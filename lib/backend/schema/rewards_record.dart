import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RewardsRecord extends FirestoreRecord {
  RewardsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  bool hasCode() => _code != null;

  // "discount_percent" field.
  int? _discountPercent;
  int get discountPercent => _discountPercent ?? 0;
  bool hasDiscountPercent() => _discountPercent != null;

  // "points_cost" field.
  int? _pointsCost;
  int get pointsCost => _pointsCost ?? 0;
  bool hasPointsCost() => _pointsCost != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _code = snapshotData['code'] as String?;
    _discountPercent = castToType<int>(snapshotData['discount_percent']);
    _pointsCost = castToType<int>(snapshotData['points_cost']);
    _isActive = snapshotData['is_active'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('rewards');

  static Stream<RewardsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RewardsRecord.fromSnapshot(s));

  static Future<RewardsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RewardsRecord.fromSnapshot(s));

  static RewardsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RewardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RewardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RewardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RewardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RewardsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createRewardsRecordData({
  String? title,
  String? code,
  int? discountPercent,
  int? pointsCost,
  bool? isActive,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'code': code,
      'discount_percent': discountPercent,
      'points_cost': pointsCost,
      'is_active': isActive,
    }.withoutNulls,
  );

  return firestoreData;
}

class RewardsRecordDocumentEquality implements Equality<RewardsRecord> {
  const RewardsRecordDocumentEquality();

  @override
  bool equals(RewardsRecord? e1, RewardsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.code == e2?.code &&
        e1?.discountPercent == e2?.discountPercent &&
        e1?.pointsCost == e2?.pointsCost &&
        e1?.isActive == e2?.isActive;
  }

  @override
  int hash(RewardsRecord? e) => const ListEquality().hash(
      [e?.title, e?.code, e?.discountPercent, e?.pointsCost, e?.isActive]);

  @override
  bool isValidKey(Object? o) => o is RewardsRecord;
}
