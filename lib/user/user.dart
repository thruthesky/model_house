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
  DateTime updatedAt;

  CollectionReference col = FirebaseFirestore.instance.collection('users');
  DocumentReference get doc => col.doc(uid);

  User({
    required this.uid,
    this.name,
    this.gender,
    required this.updatedAt,
  });

  /// Create a user with the given [uid].
  ///
  /// This is a factory constructor that will be used to create a user with the
  /// given [uid]. Be sure that the other fields are  empty(or null) even if
  /// they are not empty(or null) in the database.
  ///
  /// Use this when you need to use the method of the user model class. And do
  /// not use the fields of the user model class.
  ///
  ///
  /// uid 로 부터 사용자 객체 생성
  ///
  /// 주로, uid 값만 알고 있는 경우, 해당 uid 를 바탕으로 User 클래스 함수를 사용하고자 할 때
  /// 사용한다.
  factory User.fromUid(String uid) {
    return User(
      uid: uid,
      updatedAt: DateTime.now(),
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

    return User.fromJson(data, snapshot.id);
  }

  factory User.fromJson(Map<String, dynamic> json, String uid) {
    return User(
      uid: uid,
      name: json['name'],
      gender: json['gender'],
      updatedAt: json['updatedAt'] is Timestamp
          ? (json['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
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
  }) {
    throw HouseException(code.house.notForUse, 'User.create is not for use.');
  }

  Future update() async {
    await doc.set({'name': name}, SetOptions(merge: true));
  }

  /// 로그인 할 때, 'updatedAt' 을 업데이트
  ///
  /// 특히, 사용자의 문서를 listen 하기전에 문서가 미리 존재해야하는데, listen 하기 전에
  /// 이 함수를 이용해서, 문서가 존재하는 것을 보장한다.
  ///
  /// Updates "updatedAt" field on user's auth state changes (logs in).
  ///
  /// This is because the listener will not listen if the document does not
  /// eixsts, and this makes sure the document to be exist.
  ///
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
