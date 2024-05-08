import 'package:class_critique_app/operations/auth_service_testing.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthService', () {
    const _email = 'classcritique@gmail.com';
    const _uid = '519f80f7-02d9-4858-b468-f4403bc069ad';
    const _displayName = 'classcritique';
    const _password = 'classcritique';
    final _mockUser = MockUser(
      uid: _uid,
      email: _email,
      displayName: _displayName,
    );

    final _mockAuth = MockFirebaseAuth(mockUser: _mockUser);
    late AuthService userAPI;

    setUp(() {
      userAPI = AuthService(auth: _mockAuth);
    });

    tearDown(() {});

    test('createAccount - success', () async {
      final userCredential = await userAPI.createAccount(_email, _password);
      expect(userCredential?.user?.email, _mockUser.email);
    });

    test('loginUser', () async {
      final userCredential = await userAPI.loginUser(_email, _password);
      expect(userCredential?.user?.email, _mockUser.email);
    });

  });
}