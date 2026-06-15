import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FamilyGroupsRecord extends FirestoreRecord {
  FamilyGroupsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "groupName" field.
  String? _groupName;
  String get groupName => _groupName ?? '';
  bool hasGroupName() => _groupName != null;

  // "multiAdultApproval" field.
  bool? _multiAdultApproval;
  bool get multiAdultApproval => _multiAdultApproval ?? false;
  bool hasMultiAdultApproval() => _multiAdultApproval != null;

  // "auditAccess" field.
  bool? _auditAccess;
  bool get auditAccess => _auditAccess ?? false;
  bool hasAuditAccess() => _auditAccess != null;

  // "signatureSharing" field.
  bool? _signatureSharing;
  bool get signatureSharing => _signatureSharing ?? false;
  bool hasSignatureSharing() => _signatureSharing != null;

  void _initializeFields() {
    _groupName = snapshotData['groupName'] as String?;
    _multiAdultApproval = snapshotData['multiAdultApproval'] as bool?;
    _auditAccess = snapshotData['auditAccess'] as bool?;
    _signatureSharing = snapshotData['signatureSharing'] as bool?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: '(default)')
      .collection('family_groups');

  static Stream<FamilyGroupsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FamilyGroupsRecord.fromSnapshot(s));

  static Future<FamilyGroupsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FamilyGroupsRecord.fromSnapshot(s));

  static FamilyGroupsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FamilyGroupsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FamilyGroupsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FamilyGroupsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FamilyGroupsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FamilyGroupsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFamilyGroupsRecordData({
  String? groupName,
  bool? multiAdultApproval,
  bool? auditAccess,
  bool? signatureSharing,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'groupName': groupName,
      'multiAdultApproval': multiAdultApproval,
      'auditAccess': auditAccess,
      'signatureSharing': signatureSharing,
    }.withoutNulls,
  );

  return firestoreData;
}

class FamilyGroupsRecordDocumentEquality
    implements Equality<FamilyGroupsRecord> {
  const FamilyGroupsRecordDocumentEquality();

  @override
  bool equals(FamilyGroupsRecord? e1, FamilyGroupsRecord? e2) {
    return e1?.groupName == e2?.groupName &&
        e1?.multiAdultApproval == e2?.multiAdultApproval &&
        e1?.auditAccess == e2?.auditAccess &&
        e1?.signatureSharing == e2?.signatureSharing;
  }

  @override
  int hash(FamilyGroupsRecord? e) => const ListEquality().hash([
        e?.groupName,
        e?.multiAdultApproval,
        e?.auditAccess,
        e?.signatureSharing
      ]);

  @override
  bool isValidKey(Object? o) => o is FamilyGroupsRecord;
}
