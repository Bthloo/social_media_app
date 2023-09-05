import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socila_app/api/models/all%20comments%20response/CommentsResponse.dart';
import 'package:socila_app/api/models/create%20comment%20request/create_comment_request.dart';
import 'package:socila_app/api/models/create%20comment%20response/create_comment_response.dart';
import 'package:socila_app/api/models/profile%20response/ProfileResponse.dart';
import 'package:socila_app/api/models/register%20request/RegisterRequest.dart';

import 'models/all post response/PostsResponse.dart';
import 'models/create post request/CreatePostRequest.dart';
import 'models/create post response/CreatePostResponse.dart';
import 'models/login request/LoginRequest.dart';
import 'models/login response/LoginResponse.dart';
import 'models/post like response/CreateLikeResponse.dart';
import 'models/register response/RegisterResponse.dart';

class ApiManager {
  static const String baseUrl = 'social-app-api-655l.onrender.com';

  static Future<RegisterResponse> register(
      {required String name,
      required String email,
      required String password}) async {
    var uri = Uri.https(baseUrl, "signup");
    var requestBody =
        RegisterRequest(email: email, fullName: name, password: password);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));
    var registerResponse = RegisterResponse.fromJson(jsonDecode(response.body));
    print("fdfdfdfdfd${registerResponse.statusMessage}");
    return registerResponse;
  }

  static Future<LoginResponse> login(
      {required String email, required String password}) async {
    var uri = Uri.https(baseUrl, "login");
    var requestBody = LoginRequest(email: email, password: password);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));
    var loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
    print(loginResponse.statusMessage);
    return loginResponse;
  }

  static Future<PostsResponse> getAllPosts(String token) async {
    var uri = Uri.https(baseUrl, "posts");
    var response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    var postsResponse = PostsResponse.fromJson(jsonDecode(response.body));
    return postsResponse;
  }

  static Future<CommentsResponse> getAllComments(
      num postId, String token) async {
    var uri = Uri.https(baseUrl, "comments", {'postId': "$postId"});

    var response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    var postsResponse = CommentsResponse.fromJson(jsonDecode(response.body));
    return postsResponse;
  }

  static Future<CreateCommentResponse> createComment(
      num postId, String content, String token) async {
    var uri = Uri.https(baseUrl, "comments", {'postId': "$postId"});
    var requestBody = CreateCommentRequest(content: content);
    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(requestBody));
    var createCommentResponse =
        CreateCommentResponse.fromJson(jsonDecode(response.body));
    return createCommentResponse;
  }

  static Future<CreateLikeResponse> createLike(num postId, String token) async {
    var uri = Uri.https(baseUrl, "likes", {'postId': "$postId"});
    var response = await http.post(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    var createLikeResponse =
        CreateLikeResponse.fromJson(jsonDecode(response.body));
    return createLikeResponse;
  }

  static Future<CreatePostResponse> createPost(
      String content, String token) async {
    var uri = Uri.https(baseUrl, "posts");
    var requestBody = CreatePostRequest(content: content);
    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(requestBody));
    var createPostResponse =
        CreatePostResponse.fromJson(jsonDecode(response.body));
    return createPostResponse;
  }

  static Future<ProfileResponse> getProfile(int id) async {
    var uri = Uri.https(baseUrl, "profile/$id");

    var response = await http.get(uri, headers: {
      "Content-Type": "application/json",
    });
    var profileResponse = ProfileResponse.fromJson(jsonDecode(response.body));
    return profileResponse;
  }

  static Future<int> deletePost(
      {required num postId, required String token}) async {
    var uri = Uri.https(baseUrl, "posts", {'postId': "$postId"});
    var response = await http.delete(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    int statusCode = response.statusCode;
    //var deletePost = DeletePostResponse.fromJson(jsonDecode(response.body));
    print(statusCode);
    return statusCode;
  }
}
