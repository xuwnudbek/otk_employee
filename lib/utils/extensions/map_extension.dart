extension MapExtension on Map? {
  bool get isEmptyOrNull => (this ?? {}).isEmpty;
  bool get isNotEmptyOrNull => (this ?? {}).isNotEmpty;
}
