class EnumValues<T> {
  const EnumValues(this.map);
  final Map<String, T> map;

  Map<T, String> get reverse {
    return map.map((k, v) => MapEntry(v, k));
  }
}
