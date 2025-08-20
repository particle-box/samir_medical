import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsController extends StateNotifier<bool> {
  NotificationsController() : super(false);

  void notifyOnce() {
    state = true;
  }
}

final notificationsControllerProvider =
    StateNotifierProvider<NotificationsController, bool>(
  (ref) => NotificationsController(),
);
