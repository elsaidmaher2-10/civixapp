enum AppRole {
  citizen("citizen"),
  worker("worker"),
  unknown("unknown");
  final String value;
  const AppRole(this.value);
  static AppRole fromString(String? value) {
    return AppRole.values.firstWhere(
      (e) => e.value == value?.toLowerCase(),
      orElse: () => AppRole.unknown,
    );
  }
}