
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:star_wars_filmes_personagens/controller/favorite_controller.dart';
import 'package:star_wars_filmes_personagens/controller/film_controller.dart';
import 'package:star_wars_filmes_personagens/controller/people_controller.dart';
import 'package:star_wars_filmes_personagens/model/favorite_model.dart';
import 'package:star_wars_filmes_personagens/model/favorite_repository.dart';
import 'package:star_wars_filmes_personagens/model/film_model.dart';
import 'package:star_wars_filmes_personagens/model/people_model.dart';
import 'package:star_wars_filmes_personagens/util/route_generator.dart';
import 'package:star_wars_filmes_personagens/view/widget/favoratable_list_view.dart';
import 'package:star_wars_filmes_personagens/view/widget/favoraties_list_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  String _title = 'Lista de Filmes';

  List<FilmModel> _films = [];

  List<PeopleModel> _people = [];

  FilmController _filmController = FilmController();

  PeopleController _peopleController = PeopleController();

  FavoriteController _favoriteController = FavoriteController(FavoriteRepository());

  List<FavoriteModel> _favorites = [];

  Future<List<FilmModel>> _loadFilms() async {
    _films.clear();

    return _filmController.loadFilms();
  }

  Future<List<PeopleModel>> _loadPeople() async {
    _people.clear();

    return _peopleController.loadPeople();
  }

  void _loadFavorites() async {
    _favorites.clear();

    _favoriteController.findAll().then((value) => null);
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
                  child: Column(
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
                              child: FluttermojiCircleAvatar(
                                backgroundColor: Colors.grey[200],
                                radius: 25,
                              )
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
          FutureBuilder<List<FilmModel>>(
              future: _loadFilms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none
                    || snapshot.connectionState == ConnectionState.active
                    || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Ocorreu um erro: ${snapshot.error}'),
                      );
                    } else {
                      List<FilmModel> films = snapshot.data!;

                      films.forEach((element) {
                        if (_favorites.contains(element)) {
                          element.favorite = true;
                        }
                      });

                      return FavoratableListView(snapshot.data, _favorites, onFavorite: (model) {
                        if (model.favorite) {
                          _favoriteController.delete(model);
                        } else {
                          _favoriteController.save(model);
                        }
                      });
                    }
                  } else {
                    return Center(
                      child: Text('Nenhum dado foi encontrado.'),
                    );
                  }
                }
              }
          ),
          FutureBuilder<List<PeopleModel>>(
              future: _loadPeople(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none
                    || snapshot.connectionState == ConnectionState.active
                    || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Ocorreu um erro: ${snapshot.error}'),
                      );
                    } else {
                      List<PeopleModel> films = snapshot.data!;

                      films.forEach((element) {
                        if (_favorites.contains(element)) {
                          element.favorite = true;
                        }
                      });

                      return FavoratableListView(snapshot.data, _favorites, onFavorite: (model) {
                        if (model.favorite) {
                          _favoriteController.delete(model);
                        } else {
                          _favoriteController.save(model);
                        }
                      });
                    }
                  } else {
                    return Center(
                      child: Text('Nenhum dado foi encontrado.'),
                    );
                  }
                }
              }
          ),
          FutureBuilder<List<FavoriteModel>>(
              future: _favoriteController.findAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none
                    || snapshot.connectionState == ConnectionState.active
                    || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Ocorreu um erro: ${snapshot.error}'),
                      );
                    } else {
                      if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Text('Nenhum dado foi encontrado.'),
                        );
                      } else {
                        _favorites = snapshot.data!;

                        return FavoratiesListView(snapshot.data);
                      }
                    }
                  } else {
                    return Center(
                      child: Text('Nenhum dado foi encontrado.'),
                    );
                  }
                }
              }
          ),
        ],
      ),
    );
  }

}