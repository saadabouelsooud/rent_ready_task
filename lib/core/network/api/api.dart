import 'dart:convert';


class RequestType {
  static const String Get = 'get';
  static const String Post = 'post';
  static const String Put = 'put';
  static const String Delete = 'delete';
}

class Header {
  static const String authorization = "Authorization";
}

class EndPoint {
  static const String accounts = 'accounts';
  static const String getToken = 'token';
}

class Constants
{
  static const String grantType = "client_credentials";
  static const String clientSecret = "P7y8Q~ZUxrJf9mIsJ-Xn06LiWDcOxF3YYD7qCdgG";
  static const String clientId = "eacd616a-5850-4328-b027-40dc674b8883";
  static const String scope = "https://org4e3bbde6.crm4.dynamics.com/.default";
}
