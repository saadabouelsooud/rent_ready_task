import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'api.dart';

class HttpApi {
  static String serverPAth = 'https://org4e3bbde6.crm4.dynamics.com/api/data/v9.2/';
  static String getTokenServerPath = 'https://login.microsoftonline.com/f4a684ff-bcbf-4575-8ebb-042e9f62ca30/oauth2/v2.0/';



  static Future<Response?> request(String endPoint,bool isGetTokenApi,
      {body,
      required ProgressCallback onSendProgress,
      required Map<String, dynamic> headers,
      String type = RequestType.Get,
      required Map<String, dynamic> queryParameters,
      String contentType = Headers.jsonContentType,
      ResponseType responseType = ResponseType.json}) async {
    Response? response;
    HttpOverrides.global =  MyHttpOverrides();

    final dio = Dio(BaseOptions(
      baseUrl: isGetTokenApi? getTokenServerPath : serverPAth,
      connectTimeout: 50000,
      receiveTimeout: 50000,
    ));

    final options = Options(
        headers: headers,
        contentType: contentType,
        responseType: responseType,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        });

    log(body.toString());
    log(headers.toString());
    Logger().d(body.toString());
    Logger().d(headers);
    try {
      switch (type) {
        case RequestType.Get:
          {
            response = await dio.get(endPoint, queryParameters: queryParameters, options: options);
          }
          break;
        case RequestType.Post:
          {
            response = await dio.post(endPoint, queryParameters: queryParameters, onSendProgress: onSendProgress, data: body, options: options);
          }
          break;
        case RequestType.Put:
          {
            response = await dio.put(endPoint, queryParameters: queryParameters, data: body, options: options);
          }
          break;
        case RequestType.Delete:
          {
            response = await dio.delete(endPoint, queryParameters: queryParameters, data: body, options: options);
          }
          break;
        default:
          break;
      }
      log('$type $endPoint\n$headers\nstatusCode:${response!.statusCode}\n');
      log(response.toString());

      Logger().d('$type $endPoint\n$headers\nstatusCode:${response.statusCode}\n');
      Logger().d(response);
      return response;
    } catch (e) {
   log('🌐🌐ERROR in http $type for $endPoint:🌐🌐\n' + e.toString());

      Logger().e('🌐🌐ERROR in http $type for $endPoint:🌐🌐\n' + e.toString());
      return null;
    }
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print('ERROR[${err.response!.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}