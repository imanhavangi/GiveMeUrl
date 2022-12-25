import 'package:dio/dio.dart';

class Services {
  // base url
  static const String BASE_URL = "https://givemedomain.xyz/api/get-link";

  // get link
  static Future<Link> createUserLogin(
      String phone_email, String username) async {
    final response = await Dio().post(
      '$BASE_URL?phone_email=$phone_email&username=$username',
      data: {
        'phone_email': phone_email,
        'username': username,
      },
      options: Options(
        headers: {
          // 'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return Link.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }
}

class Link {
  final String link;
  final String status;
  final String message;

  Link({required this.link, required this.status, required this.message});

  factory Link.fromJson(Map<String, dynamic> json, int statusCode) {
    if (json['status'] == 'success') {
      return Link(
        link: json['link'],
        status: json['status'],
        message: '',
      );
    } else {
      return Link(
        link: '',
        status: json['status'],
        message: json['message'],
      );
    }
  }
}
