abstract class SettingsState {}

class ChangeCheckState extends SettingsState {
  bool first = false;
  bool second = false;
  bool third = false;

  ChangeCheckState(bool first, bool second, bool third) {
    this.first = first;
    this.second = second;
    this.third = third;
  }
}

class OpenFirstOnboardingState extends SettingsState {}
class OpenSecondOnboardingState extends SettingsState {}
class OpenThirdOnboardingState extends SettingsState {}
