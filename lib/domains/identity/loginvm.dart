import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:woong_front/domains/identity/identity.dart';
import 'package:woong_front/domains/identity/loginrepo.dart';

class LoginVM extends ChangeNotifier {
  LoginRepo repo;

  Identity userIdentity;

  LoginVM({required this.repo}) : userIdentity = Identity.empty();

  Future<void> authorize() async {
    try {
      if (!userIdentity.isEmpty()) {
        userIdentity =
            await repo.validate(userIdentity.tid, userIdentity.idToken);
        return;
      }

      userIdentity = await repo.authorize();
    } catch (e) {
      userIdentity = Identity.empty();
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> validate() async {
    try {
      if (!userIdentity.isEmpty()) {
        userIdentity =
            await repo.validate(userIdentity.tid, userIdentity.idToken);
        return;
      }

      userIdentity = await repo.authorize();
    } catch (e) {
      userIdentity = Identity.empty();
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  bool isAuthorized() {
    return !userIdentity.isEmpty();
  }
}
