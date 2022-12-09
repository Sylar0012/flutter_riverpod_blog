import 'dart:convert';

import 'package:blog/core/http_connector.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final userApiRepository = Provider<UserApiRepository>((ref) {
  return UserApiRepository(ref);
});

class UserApiRepository {
  UserApiRepository(this._ref);
  Ref _ref;

  Future<ResponseDto> join(JoinReqDto joinReqDto) async {
    // 1. joinReqDto로 넘긴 파일을 Json타입으로 바꿈.
    String requestBody = jsonEncode(joinReqDto.toJson());

    // 2. 서버로 post 요청
    Response response = await _ref.read(httpConnector).post("/join", requestBody);

    // 3. 문자열 -> Map
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    // 4. Map -> Dart Class
    ResponseDto responseDto = ResponseDto.fromJson(responseMap);
    return responseDto; // ResponseDto 응답
  }

  Future<ResponseDto> login(LoginReqDto loginReqDto) async {
    // 1. joinReqDto로 넘긴 파일을 Json타입으로 바꿈.
    String requestBody = jsonEncode(loginReqDto.toJson());

    // 2. 서버로 post 요청
    Response response = await _ref.read(httpConnector).post("/login", requestBody);

    String jwtToken = response.headers["authorization"].toString();

    // 3. 문자열 -> Map
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    // 4. Map -> Dart Class
    ResponseDto responseDto = ResponseDto.fromJson(responseMap);
    return responseDto; // ResponseDto 응답
  }
}
