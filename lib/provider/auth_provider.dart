import 'package:blog/domain/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * StateNotifierProvider : 어떤버튼을 눌렸을때 이 버튼이 눌린경우 화면이 재빌드 되어야 할때 ( ex) 로그아웃 ) 사용함.
 * 즉, 화면의 부분을 리로드 할때 ( ajax ) 같이 사용할 수 있다.
 * 웹 소켓을 사용한다? StreamProvider
 */

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider();
});

class AuthProvider {
  String? jwtToken;
  bool isLogin = false;
  User? user;
}
