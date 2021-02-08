import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifestack/app/home/models/quote.dart';
import 'package:lifestack/services/auth.dart';
import 'package:meta/meta.dart';
import 'package:lifestack/app/home/models/entry.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:lifestack/services/api_path.dart';
import 'package:lifestack/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Future<void> deleteJob(Job job);
  Future<void> incrementJob(String jobId);
  Future<void> toggleVisibleJob(Job job);

  Future<void> incrementTask(Entry entry);
  Future<void> toggleVisibleTask(Entry entry);
  Future<void> startAnimation(Entry entry) ;

  Stream<List<Entry>> entryStream();

  Future<void> resetAnimationTasks(uid);
  Future<void> resetTasks(uid);
  Future<List<DocumentSnapshot>> getQuotes();

  Stream<List<Job>> jobsStream();
  Stream<Job> jobStream({@required String jobId});

  Stream<List<Quote>> quotesStream();
  Stream<List<Entry>> tasksStream();
  Stream<List<Job>> categoriesStream();

  Future<void> setEntry(Entry entry);
  Future<void> deleteEntry(Entry entry);
  Stream<List<Entry>> entriesStream({Job job});
  Stream<List<Entry>> tasks2Stream({Job job});
  Stream<List<Job>> jobCountStream({Entry entry});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

      

  @override
  Future<void> deleteJob(Job job) async {
    // delete where entry.jobId == job.jobId
    final allEntries = await entriesStream(job: job).first;
    for (Entry entry in allEntries) {
      if (entry.jobId == job.id) {
        await deleteEntry(entry);
      }
    }
    // delete job
    await _service.deleteData(path: APIPath.job(uid, job.id));
  }

  Future<void> resetTasks(uid) async {
    CollectionReference collectionReference = Firestore.instance.collection(APIPath.entries(uid)); // getDocuments();
    QuerySnapshot colRef = await collectionReference.getDocuments();

    colRef.documents.forEach((element) {element.reference.updateData({"visible": true}); });

  }

  Future<void> resetAnimationTasks(uid) async {
    CollectionReference collectionReference = Firestore.instance.collection(APIPath.entries(uid)); // getDocuments();
    QuerySnapshot colRef = await collectionReference.getDocuments();

    colRef.documents.forEach((element) {element.reference.updateData({"runAnimation": false}); });

  }


  // method to call motivational quote from fb, but doesnt work.. needs to be .fromMap and quote object
  Future<List<DocumentSnapshot>> getQuotes() async {
    CollectionReference collectionReference = Firestore.instance.collection(APIPath.quotes()); 
    QuerySnapshot colRef = await collectionReference.getDocuments();
    List<DocumentSnapshot> quotesList = colRef.documents.toList();
    
    print(quotesList[0].data);
    return quotesList;

    // colRef.documents.forEach((element) {element.reference.updateData({"visible": true}); });

  }

  Future<void> incrementJob(String jobId) async {
    await _service.incrementData(path: APIPath.job(uid, jobId));
  }

  Future<void> incrementTask(Entry entry) async {
    await _service.incrementData(path: APIPath.entry(uid, entry.id));
  }

  Future<void> toggleVisibleJob(Job job) async {
    await _service.toggleVisibleData(path: APIPath.job(uid, job.id));
  }

  Future<void> toggleVisibleTask(Entry entry) async {
    await _service.toggleVisibleData(path: APIPath.entry(uid, entry.id));
  }

  Future<void> startAnimation(Entry entry) async {
    await _service.runAnimation(path: APIPath.entry(uid, entry.id));
  }

  @override
  Stream<Job> jobStream({@required String jobId}) => _service.documentStream(
        path: APIPath.job(uid, jobId),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  @override
  Stream<List<Entry>> entryStream() => _service.collectionStream(
        path: APIPath.entries(uid),
        builder: (data, documentId) => Entry.fromMap(data, documentId),
      );

  

  Stream<List<Entry>> tasksStream() => _service.collectionStream(
        path: APIPath.tasks(),
        builder: (data, documentId) => Entry.fromMap(data, documentId),
      );
  
  Stream<List<Job>> categoriesStream() => _service.collectionStream(
        path: APIPath.categories(),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  @override
  Stream<List<Quote>> quotesStream() => _service.collectionStream(
        path: APIPath.quotes(),
        builder: (data, documentId) => Quote.fromMap(data, documentId),
      );

  @override
  Future<void> setEntry(Entry entry) async => await _service.setData(
        path: APIPath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  @override
  Future<void> deleteEntry(Entry entry) async =>
      await _service.deleteData(path: APIPath.entry(uid, entry.id));

  @override
  Stream<List<Entry>> entriesStream({Job job}) =>
      _service.collectionStream<Entry>(
        path: APIPath.entries(uid),
        queryBuilder: job != null
            ? (query) => query.where('category', isEqualTo: job.category)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );

  @override
  Stream<List<Job>> jobCountStream({Entry entry}) =>
      _service.collectionStream<Job>(
        path: APIPath.jobs(uid),
        queryBuilder: entry != null
            ? (query) => query.where('category', isEqualTo: entry.category)
            : null,
        builder: (data, documentID) => Job.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );

  

  @override
  Stream<List<Entry>> tasks2Stream({Job job}) =>
      _service.collectionStream<Entry>(
        path: APIPath.tasks(),
        queryBuilder: job != null
            ? (query) => query.where('category', isEqualTo: job.category)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
        
      );
}
