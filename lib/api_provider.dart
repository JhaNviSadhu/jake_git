import 'package:dio/dio.dart';
import 'package:jake_git/env.dart';

final Dio dio = Dio();

Dio? _dio;

class APIProvider {
  APIProvider() {
    final BaseOptions dioOptions = BaseOptions()..baseUrl = env.baseurl;
    dioOptions.responseType = ResponseType.plain;
    dioOptions.connectTimeout = 60 * 1000;
    dioOptions.receiveTimeout = 60 * 1000;

    // dioOptions.headers = <String, dynamic>{
    //   if (getBoolAsync(IS_LOGGED_IN))
    //     'Authorization':
    //         'Bearer ${getStringAsync(TOKEN)}', //aGenralBloc?.authToken?.value ?? '',
    //   // 'cache-control': 'no-cache',
    //   // 'Accept': 'application/json'
    // };

    _dio = Dio(dioOptions);
    dio.interceptors.add(InterceptorsWrapper(
        onError: (DioError error, ErrorInterceptorHandler handler) async {
      if (error.response?.statusCode == 401) {
        print('Status Code ==== ${error.response?.statusCode}');
        // _settingsBloC.onLogout(context);
        // String token = getStringAsync(NOTIFICATION_TOKEN);
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // await preferences.clear();
        // Authenticate().launch(context, isNewTask: true);
        // setValue(NOTIFICATION_TOKEN, token);
      }
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> getAPICall(String url) async {
    try {
      print(_dio?.options.headers);
      final Response<dynamic> response = await _dio!.get(url);
      throwIfNoSuccess(response);
      return response;
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.connectTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    }
  }

  Future<Response<dynamic>> getAPICallWithQueryParam(
      String url, dynamic data) async {
    final Response<dynamic> response =
        await _dio!.get(url, queryParameters: data as Map<String, dynamic>);
    throwIfNoSuccess(response);
    return response;
  }

  Future<Response<dynamic>> postAPICall(String url, dynamic data) async {
    final Response<dynamic> response = await _dio!.post(url, data: data);
    throwIfNoSuccess(response);
    return response;
  }

  Future<Response<dynamic>> formDataPostAPICall(
      String url, dynamic data) async {
    final Response<dynamic> response = await _dio!.post(url,
        data: data,
        options: Options(
          contentType: 'multipart/form-data',
        ));
    throwIfNoSuccess(response);
    return response;
  }

  Future<Response<dynamic>> deleteAPICall(String url) async {
    final Response<dynamic> response = await _dio!.delete(url);
    throwIfNoSuccess(response);
    return response;
  }

  Future<Response<dynamic>> putAPICall(String url, dynamic data) async {
    final Response<dynamic> response = await _dio!.put(url, data: data);
    throwIfNoSuccess(response);
    return response;
  }

  void throwIfNoSuccess(Response<dynamic> response) {
    if (response.statusCode != null) {
      if (response.statusCode! < 200 || response.statusCode! > 299) {
        throw HttpException(response);
      }
    }
  }
}

class HttpException implements Exception {
  HttpException(this.response);
  Response<dynamic> response;
}
