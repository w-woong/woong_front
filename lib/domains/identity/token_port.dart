import 'package:woong_front/domains/identity/token.dart';

abstract class TokenRefreshService {
  Future<Token> refresh(Token token);
}

abstract class AuthService {
  Future<String> retrieveAuthRequestID();
  Future<Token> waitForToken(String authRequestID);
  Future<void> launchAuth(String authRequestID);
}
