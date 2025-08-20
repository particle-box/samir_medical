import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState {
  final bool highContrast;

  const SettingsState({this.highContrast = false});
}

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController() : super(const SettingsState());

  void toggleContrast() {
    state = SettingsState(highContrast: !state.highContrast);
  }
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>(
  (ref) => SettingsController(),
);
