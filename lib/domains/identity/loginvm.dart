import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:woong_front/commons/exceptions/token_exceptions.dart';
import 'package:woong_front/domains/identity/token.dart';
import 'package:woong_front/domains/identity/token_port.dart';
import 'package:woong_front/domains/identity/token_repo.dart';
import 'package:woong_front/domains/user/user.dart';
import 'package:woong_front/domains/user/user_port.dart';

class LoginVM extends ChangeNotifier {
  // LoginHttp repo;
  AuthService googleAuthService;
  TokenRepo tokenRepo;
  UserService userService;

  bool? isAuthorized;
  User? user;

  LoginVM(
      {required this.googleAuthService,
      required this.tokenRepo,
      required this.userService}) {
    isAuthorized = false;
    user = User.empty();
  }

  Future<Token> _googleAuth() async {
    // var authRequestID = await googleAuthService.retrieveAuthRequestID();
    // googleAuthService.launchAuth(authRequestID);
    // return await googleAuthService.waitForToken(authRequestID);
    await googleAuthService.launchAuthorization();
    return Future<Token>.value();
  }

  Future<void> authorize() async {
    try {
      // var identity = await tokenRepo.read();
      // if (!identity.isEmpty()) {
      //   identity = await repo.validate(identity);
      //   return;
      // }

      var newIdentity = await _googleAuth();
      tokenRepo.create(newIdentity);
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  // Future<void> validate() async {
  //   try {
  //     var identity = await tokenRepo.read();
  //     if (!identity.isEmpty()) {
  //       identity = await repo.validate(identity);
  //       return;
  //     }

  //     var newIdentity = await repo.authorize();
  //     tokenRepo.create(newIdentity);
  //   } catch (e) {
  //     rethrow;
  //   } finally {
  //     notifyListeners();
  //   }
  // }

  Future<void> findAccount() async {
    try {
      user = await userService.findUserAccount();
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> checkAuthorized() async {
    try {
      var identity = await tokenRepo.read();
      isAuthorized = !identity.isEmpty();
    } on TokenExpiredException {
      isAuthorized = false;
    } catch (e) {
      isAuthorized = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await tokenRepo.delete();
      user = User.empty();
      isAuthorized = false;
    } catch (e) {
      isAuthorized = false;
    } finally {
      notifyListeners();
    }
  }
}
