// import 'dart:convert';
//
//
// import 'package:dio/dio.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:matcher/matcher.dart';
// import 'package:rent_ready_task/core/network/api/http_api.dart';
// import 'package:rent_ready_task/feature/data/datasources/account_remote_datasource.dart';
//
//
// class MockHttpClient extends Mock implements HttpApi {}
//
// void main() {
//   late AccountRemoteDataSourceImpl dataSource;
//   late MockHttpClient mockHttpClient;
//   final Dio tdio = Dio();
//   late HttpApi tapi;
//
//   setUp(() {
//     mockHttpClient = MockHttpClient();
//     dataSource = AccountRemoteDataSourceImpl();
//     tdio.httpClientAdapter = mockHttpClient as HttpClientAdapter;
//     tapi = HttpApi.test(dio: tdio);
//   });
//
//   group('Get method', () {
//     test('canbe used to get responses for any url', () async {
//       final responsepayload = jsonEncode({"response_code": "1000"});
//       final httpResponse = ResponseBody.fromString(
//         responsepayload,
//         200,
//         headers: {
//           Headers.contentTypeHeader: [Headers.jsonContentType],
//         },
//       );
//
//       when(mockHttpClient.dio.fetch(any))
//           .thenAnswer((_) async => httpResponse);
//
//       final response = await tapi.dio.get("/any url");
//       final expected = {"response_code": "1000"};
//
//       expect(response, equals(expected));
//     });
//   });
//
//   group('Post Method', () {
//     test('canbe used to get responses for any requests with body', () async {
//       final responsepayload = jsonEncode({"response_code": "1000"});
//       final httpResponse =
//       ResponseBody.fromString(responsepayload, 200, headers: {
//         Headers.contentTypeHeader: [Headers.jsonContentType]
//       });
//
//       when(mockHttpClient.dio.fetch(any, any, any))
//           .thenAnswer((_) async => httpResponse);
//
//       final response = await tapi.dio.post("/any url", data: {"body": "body"});
//       final expected = {"response_code": "1000"};
//
//       expect(response, equals(expected));
//     });
//   });
// }
