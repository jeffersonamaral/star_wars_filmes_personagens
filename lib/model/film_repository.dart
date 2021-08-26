import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:star_wars_filmes_personagens/util/constants.dart';

import 'film_model.dart';

class FilmRepository {

  const FilmRepository();

  Future<List<FilmModel>> findAll() async {
    var response = await http.get(Uri.parse(apiFilmsUrl));

    if (response.statusCode == 200) {
      List<FilmModel> tempFilms = [];

      var jsonResponse = json.decode(response.body);

      for (Map<String, dynamic> mapMovie in jsonResponse['results']) {
        tempFilms.add(FilmModel.fromMap(mapMovie));
      }

      return tempFilms;
    } else {
      throw(response);
    }
  }

}