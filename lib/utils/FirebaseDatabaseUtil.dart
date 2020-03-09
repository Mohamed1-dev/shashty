//import 'dart:async';
//
//import 'package:firebase_database/firebase_database.dart';
//
//class FirebaseDatabaseUtil {
//  DatabaseReference _counterRef;
//  DatabaseReference _userRef;
//  StreamSubscription<Event> _counterSubscription;
//  StreamSubscription<Event> _messagesSubscription;
//  FirebaseDatabase database = new FirebaseDatabase();
//  int _counter;
//  DatabaseError error;
//
//  static final FirebaseDatabaseUtil _instance =
//      new FirebaseDatabaseUtil.internal();
//
//  FirebaseDatabaseUtil.internal();
//
//  factory FirebaseDatabaseUtil() {
//    return _instance;
//  }
//
//  void initState() {
//    // Demonstrates configuring to the database using a file
//    _counterRef = FirebaseDatabase.instance.reference().child('counter');
//    // Demonstrates configuring the database directly
//
//    _userRef = database.reference().child('users');
//
//    database.setPersistenceEnabled(true);
//    database.setPersistenceCacheSizeBytes(10000000);
//    _counterRef.keepSynced(true);
//
//    _counterSubscription = _counterRef.onValue.listen((Event event) {
//      error = null;
//      _counter = event.snapshot.value ?? 0;
//    }, onError: (Object o) {
//      error = o;
//    });
//  }
//
//  DatabaseError getError() {
//    return error;
//  }
//
//  DatabaseReference getUser() {
//    return _userRef;
//  }
//
//  void dispose() {
////    _messagesSubscription.cancel();
////    _counterSubscription.cancel();
//  }
//}
