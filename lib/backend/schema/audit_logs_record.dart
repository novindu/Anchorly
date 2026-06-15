import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AuditLogsRecord extends FirestoreRecord {
  AuditLogsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "actionType" field.
  String? _actionType;
  String get actionType => _actionType ?? '';
  bool hasActionType() => _actionType != null;

  // "actorName" field.
  String? _actorName;
  String get actorName => _actorName ?? '';
  bool hasActorName() => _actorName != null;

  // "timestamp" field.
  String? _timestamp;
  String get timestamp => _timestamp ?? '';
  bool hasTimestamp() => _timestamp != null;

  // "detailIcon" field.
  String? _detailIcon;
  String get detailIcon => _detailIcon ?? '';
  bool hasDetailIcon() => _detailIcon != null;

  // "detailText" field.
  String? _detailText;
  String get detailText => _detailText ?? '';
  bool hasDetailText() => _detailText != null;

  void _initializeFields() {
    _actionType = snapshotData['actionType'] as String?;
    _actorName = snapshotData['actorName'] as String?;
    _timestamp = snapshotData['timestamp'] as String?;
    _detailIcon = snapshotData['detailIcon'] as String?;
    _detailText = snapshotData['detailText'] as String?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: '(default)')
      .collection('audit_logs');

  static Stream<AuditLogsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AuditLogsRecord.fromSnapshot(s));

  static Future<AuditLogsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AuditLogsRecord.fromSnapshot(s));

  static AuditLogsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AuditLogsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AuditLogsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AuditLogsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AuditLogsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AuditLogsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAuditLogsRecordData({
  String? actionType,
  String? actorName,
  String? timestamp,
  String? detailIcon,
  String? detailText,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'actionType': actionType,
      'actorName': actorName,
      'timestamp': timestamp,
      'detailIcon': detailIcon,
      'detailText': detailText,
    }.withoutNulls,
  );

  return firestoreData;
}

class AuditLogsRecordDocumentEquality implements Equality<AuditLogsRecord> {
  const AuditLogsRecordDocumentEquality();

  @override
  bool equals(AuditLogsRecord? e1, AuditLogsRecord? e2) {
    return e1?.actionType == e2?.actionType &&
        e1?.actorName == e2?.actorName &&
        e1?.timestamp == e2?.timestamp &&
        e1?.detailIcon == e2?.detailIcon &&
        e1?.detailText == e2?.detailText;
  }

  @override
  int hash(AuditLogsRecord? e) => const ListEquality().hash([
        e?.actionType,
        e?.actorName,
        e?.timestamp,
        e?.detailIcon,
        e?.detailText
      ]);

  @override
  bool isValidKey(Object? o) => o is AuditLogsRecord;
}
