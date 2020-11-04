class BackendService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));

    return List.generate(3, (index) {
      return {'name': query + index.toString()};
    });
  }
}

class CitiesService {
  static List<String> getSuggestions(String query, var suggestion) {
    List<String> matches = List();
    var list = suggestion;
    matches.addAll(list);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
