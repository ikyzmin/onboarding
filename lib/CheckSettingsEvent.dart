abstract class SettingsEvent {

}

class InitEvent extends SettingsEvent {}

abstract class CheckEvent extends SettingsEvent{
  bool enable = false;

  CheckEvent(bool enabled) {
    enable = enabled;
  }
}

class FirstCheckEvent extends CheckEvent {
  FirstCheckEvent(bool enabled) : super(enabled);
}

class SecondCheckEvent extends CheckEvent {
  SecondCheckEvent(bool enabled) : super(enabled);
}

class ThirdCheckEvent extends CheckEvent {
  ThirdCheckEvent(bool enabled) : super(enabled);
}

