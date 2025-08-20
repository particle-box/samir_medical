import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionState {
  final bool isLoggedIn;
  final String? userId;

  const SessionState({
    this.isLoggedIn = false,
    this.userId,
  });
}

class SessionController extends StateNotifier<SessionState> {
  SessionController() : super(const SessionState());

  void setLoggedIn(String userId) {
    state = SessionState(isLoggedIn: true, userId: userId);
  }

  void logout() {
    state = const SessionState();
  }
}

final sessionControllerProvider =
    StateNotifierProvider<SessionController, SessionState>(
  (ref) => SessionController(),
);
