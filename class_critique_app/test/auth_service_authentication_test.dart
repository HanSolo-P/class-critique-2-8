import 'package:class_critique_app/exceptions/user_exception.dart';
import 'package:class_critique_app/operations/auth_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

const usersCollection = 'users';

void main() {
  group('AuthService - Login Signup', () {
    const _email = 'classcritique@gmail.com';
    const _uid = '519f80f7-02d9-4858-b468-f4403bc069ad';
    const _displayName = 'classcritique';
    const _universityName = 'CSU Chico';
    const _password = 'classcritique';

    final _mockUser = MockUser(
      uid: _uid,
      email: _email,
      displayName: _displayName,
    );

    final _mockAuth = MockFirebaseAuth(mockUser: _mockUser);
    final firestore = FakeFirebaseFirestore();

    late AuthService userAPI;

    setUp(() {
      userAPI = AuthService(auth: _mockAuth, database: firestore);
    });

    tearDown(() {});

    test('createAccount', () async {
      final userCredential = await userAPI.createAccount(
          _email, _password, _displayName, _universityName);
      expect(userCredential?.user?.email, _mockUser.email);
    });

    test('loginUser', () async {
      final userCredential = await userAPI.loginUser(_email, _password);
      expect(userCredential?.user?.email, _mockUser.email);
    });
  });
}
