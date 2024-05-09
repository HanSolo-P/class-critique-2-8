import 'package:class_critique_app/exceptions/user_exception.dart';
import 'package:class_critique_app/operations/auth_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

const usersCollection = 'users';

void main() {
  group('Save User', () {
    const _email = 'classcritique@gmail.com';
    const _uid = '519f80f7-02d9-4858-b468-f4403bc069ad';
    const _fullName = 'classcritique';
    const _universityName = 'CSU Chico';
    const _password = 'classcritique';

    final _mockUser = MockUser(
      uid: _uid,
      email: _email,
      displayName: _fullName,
    );

    final _mockAuth = MockFirebaseAuth(signedIn: true ,mockUser: _mockUser);
    
    final firestore = FakeFirebaseFirestore();

    late AuthService userAPI;

    setUp(() {
      userAPI = AuthService(auth: _mockAuth, database: firestore);
    });

    tearDown(() {});

    test('checkUserExistsInFirestore - False', () async {
      final result = await userAPI.checkUserExistsInFirestore(_email);
      expect(result, false);
    });

    test('saveUser', () async {
      try {
        final message =
            await userAPI.saveUser(_email, _fullName, _universityName);
        expect(message, 'User data saved successfully.');
      } on UserSaveException catch (e) {
        print('Test Case: User Save Exception: ${e.message}');
      } catch (e) {
        print(e);
      }
    });

    test('checkUserExistsInFirestore - True', () async {
      final result = await userAPI.checkUserExistsInFirestore(_email);
      expect(result, true);
    });
  });
}
