import 'package:blog/domain/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * StateNotifierProvider : 어떤버튼을 눌렸을때 이 버튼이 눌린경우 화면이 재빌드 되어야 할때 ( ex) 로그아웃 ) 사용함.
 * 즉, 화면의 부분을 리로드 할때 ( ajax ) 같이 사용할 수 있다.
 * 웹 소켓을 사용한다? StreamProvider
 */

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(ref)..initJwtToken();
});

class AuthProvider {
  AuthProvider(this._ref);
  Ref _ref;
  String? jwtToken;
  bool isLogin = false;
  User? user;

  Future<void> initJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceJwtToken = prefs.getString("jwtToken");
    Logger().d("토큰 저장됨?");
    if (deviceJwtToken != null) {
      Logger().d("토큰이 있음");
      Logger().d("${deviceJwtToken}");
      isLogin = true;
      jwtToken = deviceJwtToken;
      // 통신코드로 user 초기화
      // http://ip주소:8080/userData (Get, header:token )
    }
  }
}
