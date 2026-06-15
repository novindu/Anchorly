import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TasksRecord extends FirestoreRecord {
  TasksRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "subtitle" field.
  String? _subtitle;
  String get subtitle => _subtitle ?? '';
  bool hasSubtitle() => _subtitle != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "assignedTo" field.
  String? _assignedTo;
  String get assignedTo => _assignedTo ?? '';
  bool hasAssignedTo() => _assignedTo != null;

  // "recipientId" field.
  String? _recipientId;
  String get recipientId => _recipientId ?? '';
  bool hasRecipientId() => _recipientId != null;

  // "checklist" field.
  List<dynamic>? _checklist;
  List<dynamic> get checklist => _checklist ?? const [];
  bool hasChecklist() => _checklist != null;

  // "aiEnabled" field.
  bool? _aiEnabled;
  bool get aiEnabled => _aiEnabled ?? false;
  bool hasAiEnabled() => _aiEnabled != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _subtitle = snapshotData['subtitle'] as String?;
    _status = snapshotData['status'] as String?;
    _assignedTo = snapshotData['assignedTo'] as String?;
    _recipientId = snapshotData['recipientId'] as String?;
    _checklist = getDataList(snapshotData['checklist']);
    _aiEnabled = snapshotData['aiEnabled'] as bool?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: '(default)')
      .collection('tasks');

  static Stream<TasksRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TasksRecord.fromSnapshot(s));

  static Future<TasksRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TasksRecord.fromSnapshot(s));

  static TasksRecord fromSnapshot(DocumentSnapshot snapshot) => TasksRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TasksRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TasksRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TasksRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TasksRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTasksRecordData({
  String? title,
  String? subtitle,
  String? status,
  String? assignedTo,
  String? recipientId,
  bool? aiEnabled,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'subtitle': subtitle,
      'status': status,
      'assignedTo': assignedTo,
      'recipientId': recipientId,
      'aiEnabled': aiEnabled,
    }.withoutNulls,
  );

  return firestoreData;
}

class TasksRecordDocumentEquality implements Equality<TasksRecord> {
  const TasksRecordDocumentEquality();

  @override
  bool equals(TasksRecord? e1, TasksRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.subtitle == e2?.subtitle &&
        e1?.status == e2?.status &&
        e1?.assignedTo == e2?.assignedTo &&
        e1?.recipientId == e2?.recipientId &&
        listEquality.equals(e1?.checklist, e2?.checklist) &&
        e1?.aiEnabled == e2?.aiEnabled;
  }

  @override
  int hash(TasksRecord? e) => const ListEquality().hash([
        e?.title,
        e?.subtitle,
        e?.status,
        e?.assignedTo,
        e?.recipientId,
        e?.checklist,
        e?.aiEnabled
      ]);

  @override
  bool isValidKey(Object? o) => o is TasksRecord;
}
