import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "initials" field.
  String? _initials;
  String get initials => _initials ?? '';
  bool hasInitials() => _initials != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "familyId" field.
  String? _familyId;
  String get familyId => _familyId ?? '';
  bool hasFamilyId() => _familyId != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _initials = snapshotData['initials'] as String?;
    _role = snapshotData['role'] as String?;
    _status = snapshotData['status'] as String?;
    _familyId = snapshotData['familyId'] as String?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: '(default)')
      .collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? name,
  String? initials,
  String? role,
  String? status,
  String? familyId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'initials': initials,
      'role': role,
      'status': status,
      'familyId': familyId,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.initials == e2?.initials &&
        e1?.role == e2?.role &&
        e1?.status == e2?.status &&
        e1?.familyId == e2?.familyId;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality()
      .hash([e?.name, e?.initials, e?.role, e?.status, e?.familyId]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
