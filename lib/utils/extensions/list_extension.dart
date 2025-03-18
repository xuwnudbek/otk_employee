extension ListExtension on List {
  List qaysiki(List keys, value) {
    return where((element) {
      return keys.any((key) {
        final fieldValue = element[key].toString().trim().toLowerCase();

        final fieldText = fieldValue.toString();
        final searchText = value.toString().toLowerCase();

        return fieldText.startsWith(searchText) ||
            fieldText.contains(searchText) ||
            fieldText.endsWith(searchText);
      });
    }).toList();
  }
}
