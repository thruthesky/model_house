import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_cache/memory_cache.dart';
import 'package:model_house/model_house.dart';

/// User model
///
/// This is the user model class that will be used to manage the user's data.
///
/// [private] is the private field that will be used to store the user's data.
class User {
  String uid;
  String? name;
  String? gender;

  CollectionReference col = FirebaseFirestore.instance.collection('users');
  DocumentReference get doc => col.doc(uid);

  User({
    required this.uid,
    this.name,
    this.gender,
  });

  /// Create a user with the given [uid].
  ///
  /// This is a factory constructor that will be used to create a user with the
  /// given [uid]. Be sure that the other fields are  empty(or null) even if
  /// they are not empty(or null) in the database.
  ///
  /// Use this when you need to use the method of the user model class. And do
  /// not use the fields of the user model class.
  factory User.fromUid(String uid) {
    return User(
      uid: uid,
    );
  }

  factory User.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    if (snapshot.exists == false) {
      throw HouseException('User.fromSnapshot', 'Document does not exist.');
    }
    final Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      throw HouseException('User.fromSnapshot', 'Document is null.');
    }

    return User(
      uid: snapshot.id,
      name: data['name'],
      gender: data['gender'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['gender'] = gender;
    return data;
  }

  Future<User?> get(String uid) async {
    User? user = MemoryCache.instance.read<User?>(uid);
    if (user != null) {
      return user;
    }
    final DocumentSnapshot snapshot = await col.doc(uid).get();
    if (snapshot.exists) {
      user = User.fromSnapshot(snapshot);
      MemoryCache.instance.create(uid, user);
      return user;
    }

    /// It overrides the exisiting cache
    MemoryCache.instance.create<User?>(uid, user);
    return user;
  }

  /// Deprecated
  ///
  /// Don't use create method. It's not for creating a user.
  ///
  /// Use update method instead to create user data.
  @Deprecated('This is not for use.')
  static create({
    required String uid,
  }) {}

  Future update() async {
    await doc.set({'name': name}, SetOptions(merge: true));
  }

  Future updateOnAuthStateChange() async {
    await doc.set(
      {
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}
