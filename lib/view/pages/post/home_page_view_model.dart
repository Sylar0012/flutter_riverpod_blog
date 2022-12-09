import 'package:blog/core/routers.dart';
import 'package:blog/domain/post/post.dart';
import 'package:blog/main.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageViewModel = StateNotifierProvider<HomePageViewModel, List<Post>>((ref) {
  AuthProvider ap = ref.read(authProvider);
  return HomePageViewModel([], ap)..initViewModel();
});

class HomePageViewModel extends StateNotifier<List<Post>> {
  AuthProvider ap;
  HomePageViewModel(super.state, this.ap);

  void initViewModel() {
    if (ap.isLogin) {
      // repository 접근해서 값 받아온 후 state에 저장.
      Navigator.pushNamed(navigatorKey.currentContext!, Routers.home);
    } else {
      // 로그인 페이지로 이동
      Navigator.pushNamed(navigatorKey.currentContext!, Routers.loginForm);
    }
  }
}

/**
 * home_page_view_model
 *  1. 홈페이지에 진입했을때 열림.
 *  2. AuthProvider ap = ref.read(authProvider); 로 읽음
 *    -> 로그인 했는지 안했는지 파악.
 *
 *
 *  토큰이 존재하면 데이터 뿌리고 없으면 로그인페이지로 보내야함. 여기에 비즈니스 로직을 적은 이유
 *
 */
