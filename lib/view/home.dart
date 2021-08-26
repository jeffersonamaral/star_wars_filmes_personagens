import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:star_wars_filmes_personagens/model/film.dart';
import 'package:star_wars_filmes_personagens/model/people.dart';
import 'package:star_wars_filmes_personagens/util/constants.dart';
import 'package:star_wars_filmes_personagens/util/route_generator.dart';
import 'package:star_wars_filmes_personagens/view/widget/favoratable_list_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  String _title = 'Lista de Filmes';

  bool _loadingFilms = false;

  bool _loadingPeople = false;

  List<Film> _films = [];

  List<People> _people = [];

  void _loadMovies() async {
    setState(() {
      _loadingFilms = true;
    });

    _films.clear();

    var response = await http.get(Uri.parse(apiFilmsUrl));

    if (response.statusCode == 200) {
      List<Film> tempFilms = [];

      var jsonResponse = json.decode(response.body);

      for (Map<String, dynamic> mapMovie in jsonResponse['results']) {
        tempFilms.add(Film.fromMap(mapMovie));
      }

      setState(() {
        _films = tempFilms;
        _loadingFilms = false;
      });
    } else {
      _showRequestErrorMessage(response);

      setState(() {
        _films = [];
        _loadingFilms = false;
      });
    }
  }

  void _loadPeople() async {
    setState(() {
      _loadingPeople = true;
    });

    _people.clear();

    var response = await http.get(Uri.parse(apiPeopleUrl));

    if (response.statusCode == 200) {
      List<People> tempPeople = [];

      var jsonResponse = json.decode(response.body);

      for (Map<String, dynamic> mapPeople in jsonResponse['results']) {
        tempPeople.add(People.fromMap(mapPeople));
      }

      setState(() {
        _people = tempPeople;
        _loadingPeople = false;
      });
    } else {
      _showRequestErrorMessage(response);

      setState(() {
        _people = [];
        _loadingPeople = false;
      });
    }
  }

  void _showRequestErrorMessage(var response) {
    Fluttertoast.showToast(
        msg: 'Falha na requisição: ${response.statusCode}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER
    );
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        length: 3,
        vsync: this
    )..addListener(() {
      setState(() {
        switch (_tabController.index) {
          case 0:
            _title = 'Lista de Filmes';
            break;
          case 1:
            _title = 'Lista de Personagens';
            break;
          case 2:
            _title = 'Lista de Favoritos';
            break;
        }
      });
    });

    _loadMovies();
    _loadPeople();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_title),
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, kToolbarHeight * 2),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child:
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(RouteGenerator.officialSite);
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: .5
                                          )
                                      )
                                  )
                              ),
                              child: Text('Site Oficial',
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              )
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(RouteGenerator.avatarEditing);
                            },
                            child: CircleAvatar(
                              radius: 25,
                              child: Image.asset('assets/images/no_avatar.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        ],
                      ),
                      TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(text: 'Filmes',),
                          Tab(text: 'Personagens',),
                          Tab(text: 'Favoritos',),
                        ],
                      )
                    ],
                  )
              )
          )
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _loadingFilms == true ? Center(
            child: CircularProgressIndicator(),
          ) : FavoratableListView(_films),
          _loadingPeople == true ? Center(
            child: CircularProgressIndicator(),
          ) : FavoratableListView(_people),
          FavoratableListView([]),
        ],
      ),
    );
  }
}