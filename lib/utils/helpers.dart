int? getIntFromString(String? string) {
  if (string == null) return null;

  return double.tryParse(
    string.replaceAll(
      RegExp(r'[^0-9\.]'),
      '',
    ),
  )?.toInt();
}
