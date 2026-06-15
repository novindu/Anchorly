import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SignaturesRecord extends FirestoreRecord {
  SignaturesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "label" field.
  String? _label;
  String get label => _label ?? '';
  bool hasLabel() => _label != null;

  // "dateAdded" field.
  String? _dateAdded;
  String get dateAdded => _dateAdded ?? '';
  bool hasDateAdded() => _dateAdded != null;

  // "imagePath" field.
  String? _imagePath;
  String get imagePath => _imagePath ?? '';
  bool hasImagePath() => _imagePath != null;

  void _initializeFields() {
    _label = snapshotData['label'] as String?;
    _dateAdded = snapshotData['dateAdded'] as String?;
    _imagePath = snapshotData['imagePath'] as String?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: '(default)')
      .collection('signatures');

  static Stream<SignaturesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SignaturesRecord.fromSnapshot(s));

  static Future<SignaturesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SignaturesRecord.fromSnapshot(s));

  static SignaturesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SignaturesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SignaturesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SignaturesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SignaturesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SignaturesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSignaturesRecordData({
  String? label,
  String? dateAdded,
  String? imagePath,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'label': label,
      'dateAdded': dateAdded,
      'imagePath': imagePath,
    }.withoutNulls,
  );

  return firestoreData;
}

class SignaturesRecordDocumentEquality implements Equality<SignaturesRecord> {
  const SignaturesRecordDocumentEquality();

  @override
  bool equals(SignaturesRecord? e1, SignaturesRecord? e2) {
    return e1?.label == e2?.label &&
        e1?.dateAdded == e2?.dateAdded &&
        e1?.imagePath == e2?.imagePath;
  }

  @override
  int hash(SignaturesRecord? e) =>
      const ListEquality().hash([e?.label, e?.dateAdded, e?.imagePath]);

  @override
  bool isValidKey(Object? o) => o is SignaturesRecord;
}
