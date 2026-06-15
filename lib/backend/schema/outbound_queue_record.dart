import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OutboundQueueRecord extends FirestoreRecord {
  OutboundQueueRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "documentName" field.
  String? _documentName;
  String get documentName => _documentName ?? '';
  bool hasDocumentName() => _documentName != null;

  // "senderId" field.
  String? _senderId;
  String get senderId => _senderId ?? '';
  bool hasSenderId() => _senderId != null;

  // "recipientId" field.
  String? _recipientId;
  String get recipientId => _recipientId ?? '';
  bool hasRecipientId() => _recipientId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "aiAnalysisNote" field.
  String? _aiAnalysisNote;
  String get aiAnalysisNote => _aiAnalysisNote ?? '';
  bool hasAiAnalysisNote() => _aiAnalysisNote != null;

  // "warningFlag" field.
  bool? _warningFlag;
  bool get warningFlag => _warningFlag ?? false;
  bool hasWarningFlag() => _warningFlag != null;

  void _initializeFields() {
    _documentName = snapshotData['documentName'] as String?;
    _senderId = snapshotData['senderId'] as String?;
    _recipientId = snapshotData['recipientId'] as String?;
    _status = snapshotData['status'] as String?;
    _aiAnalysisNote = snapshotData['aiAnalysisNote'] as String?;
    _warningFlag = snapshotData['warningFlag'] as bool?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: '(default)')
      .collection('outbound_queue');

  static Stream<OutboundQueueRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OutboundQueueRecord.fromSnapshot(s));

  static Future<OutboundQueueRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OutboundQueueRecord.fromSnapshot(s));

  static OutboundQueueRecord fromSnapshot(DocumentSnapshot snapshot) =>
      OutboundQueueRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OutboundQueueRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OutboundQueueRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OutboundQueueRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OutboundQueueRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOutboundQueueRecordData({
  String? documentName,
  String? senderId,
  String? recipientId,
  String? status,
  String? aiAnalysisNote,
  bool? warningFlag,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'documentName': documentName,
      'senderId': senderId,
      'recipientId': recipientId,
      'status': status,
      'aiAnalysisNote': aiAnalysisNote,
      'warningFlag': warningFlag,
    }.withoutNulls,
  );

  return firestoreData;
}

class OutboundQueueRecordDocumentEquality
    implements Equality<OutboundQueueRecord> {
  const OutboundQueueRecordDocumentEquality();

  @override
  bool equals(OutboundQueueRecord? e1, OutboundQueueRecord? e2) {
    return e1?.documentName == e2?.documentName &&
        e1?.senderId == e2?.senderId &&
        e1?.recipientId == e2?.recipientId &&
        e1?.status == e2?.status &&
        e1?.aiAnalysisNote == e2?.aiAnalysisNote &&
        e1?.warningFlag == e2?.warningFlag;
  }

  @override
  int hash(OutboundQueueRecord? e) => const ListEquality().hash([
        e?.documentName,
        e?.senderId,
        e?.recipientId,
        e?.status,
        e?.aiAnalysisNote,
        e?.warningFlag
      ]);

  @override
  bool isValidKey(Object? o) => o is OutboundQueueRecord;
}
