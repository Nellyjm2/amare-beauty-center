import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ServicesRecord extends FirestoreRecord {
  ServicesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "duration_minutes" field.
  int? _durationMinutes;
  int get durationMinutes => _durationMinutes ?? 0;
  bool hasDurationMinutes() => _durationMinutes != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "is_featured" field.
  bool? _isFeatured;
  bool get isFeatured => _isFeatured ?? false;
  bool hasIsFeatured() => _isFeatured != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _category = snapshotData['category'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _durationMinutes = castToType<int>(snapshotData['duration_minutes']);
    _imageUrl = snapshotData['image_url'] as String?;
    _isFeatured = snapshotData['is_featured'] as bool?;
    _isActive = snapshotData['is_active'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('services');

  static Stream<ServicesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ServicesRecord.fromSnapshot(s));

  static Future<ServicesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ServicesRecord.fromSnapshot(s));

  static ServicesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ServicesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ServicesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ServicesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ServicesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ServicesRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createServicesRecordData({
  String? name,
  String? description,
  String? category,
  double? price,
  DateTime? createdAt,
  int? durationMinutes,
  String? imageUrl,
  bool? isFeatured,
  bool? isActive,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'created_at': createdAt,
      'duration_minutes': durationMinutes,
      'image_url': imageUrl,
      'is_featured': isFeatured,
      'is_active': isActive,
    }.withoutNulls,
  );

  return firestoreData;
}

class ServicesRecordDocumentEquality implements Equality<ServicesRecord> {
  const ServicesRecordDocumentEquality();

  @override
  bool equals(ServicesRecord? e1, ServicesRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.category == e2?.category &&
        e1?.price == e2?.price &&
        e1?.createdAt == e2?.createdAt &&
        e1?.durationMinutes == e2?.durationMinutes &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.isFeatured == e2?.isFeatured &&
        e1?.isActive == e2?.isActive;
  }

  @override
  int hash(ServicesRecord? e) => const ListEquality().hash([
        e?.name,
        e?.description,
        e?.category,
        e?.price,
        e?.createdAt,
        e?.durationMinutes,
        e?.imageUrl,
        e?.isFeatured,
        e?.isActive
      ]);

  @override
  bool isValidKey(Object? o) => o is ServicesRecord;
}
