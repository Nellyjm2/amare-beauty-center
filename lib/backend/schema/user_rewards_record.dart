import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserRewardsRecord extends FirestoreRecord {
  UserRewardsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "reward_ref" field.
  DocumentReference? _rewardRef;
  DocumentReference? get rewardRef => _rewardRef;
  bool hasRewardRef() => _rewardRef != null;

  // "promo_code" field.
  String? _promoCode;
  String get promoCode => _promoCode ?? '';
  bool hasPromoCode() => _promoCode != null;

  // "is_used" field.
  bool? _isUsed;
  bool get isUsed => _isUsed ?? false;
  bool hasIsUsed() => _isUsed != null;

  // "redeemed_at" field.
  DateTime? _redeemedAt;
  DateTime? get redeemedAt => _redeemedAt;
  bool hasRedeemedAt() => _redeemedAt != null;

  void _initializeFields() {
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _rewardRef = snapshotData['reward_ref'] as DocumentReference?;
    _promoCode = snapshotData['promo_code'] as String?;
    _isUsed = snapshotData['is_used'] as bool?;
    _redeemedAt = snapshotData['redeemed_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_rewards');

  static Stream<UserRewardsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserRewardsRecord.fromSnapshot(s));

  static Future<UserRewardsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserRewardsRecord.fromSnapshot(s));

  static UserRewardsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserRewardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserRewardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserRewardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserRewardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserRewardsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createUserRewardsRecordData({
  DocumentReference? userRef,
  DocumentReference? rewardRef,
  String? promoCode,
  bool? isUsed,
  DateTime? redeemedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_ref': userRef,
      'reward_ref': rewardRef,
      'promo_code': promoCode,
      'is_used': isUsed,
      'redeemed_at': redeemedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserRewardsRecordDocumentEquality implements Equality<UserRewardsRecord> {
  const UserRewardsRecordDocumentEquality();

  @override
  bool equals(UserRewardsRecord? e1, UserRewardsRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.rewardRef == e2?.rewardRef &&
        e1?.promoCode == e2?.promoCode &&
        e1?.isUsed == e2?.isUsed &&
        e1?.redeemedAt == e2?.redeemedAt;
  }

  @override
  int hash(UserRewardsRecord? e) => const ListEquality()
      .hash([e?.userRef, e?.rewardRef, e?.promoCode, e?.isUsed, e?.redeemedAt]);

  @override
  bool isValidKey(Object? o) => o is UserRewardsRecord;
}
