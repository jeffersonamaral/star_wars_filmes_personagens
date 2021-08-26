import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:star_wars_filmes_personagens/model/people_model.dart';
import 'package:star_wars_filmes_personagens/util/constants.dart';

class PeopleRepository {

  const PeopleRepository();

  Future<List<PeopleModel>> findAll() async {
    var response = await http.get(Uri.parse(apiPeopleUrl));

    if (response.statusCode == 200) {
      List<PeopleModel> tempPeople = [];

      var jsonResponse = json.decode(response.body);

      for (Map<String, dynamic> mapMovie in jsonResponse['results']) {
        tempPeople.add(PeopleModel.fromMap(mapMovie));
      }

      return tempPeople;
    } else {
      throw(response);
    }
  }

}