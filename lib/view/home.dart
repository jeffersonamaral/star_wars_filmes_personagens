import 'package:async/async.dart';
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

class _HomeState extends State<Home> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  late TabController _tabController;

  String _title = 'Lista de Filmes';

  List<FilmModel> _films = [];

  List<PeopleModel> _people = [];

  FilmController _filmController = FilmController();

  PeopleController _peopleController = PeopleController();

  FavoriteController _favoriteController = FavoriteController(FavoriteRepository());

  List<FavoriteModel> _favorites = [];

  final AsyncMemoizer _memoizerFilm = AsyncMemoizer();

  final AsyncMemoizer _memoizerPeople = AsyncMemoizer();

  @override
  bool get wantKeepAlive => true;

  Future<dynamic> _loadFilms() async {
    return _memoizerFilm.runOnce(() {
      return _filmController.loadFilms();
    });
  }

  Future<dynamic> _loadPeople() async {
    _films.clear();

    return _memoizerPeople.runOnce(() {
      return _peopleController.loadPeople();
    });
  }

  void _loadFavorites() async {
    _favorites.clear();

    _favorites = await _favoriteController.findAll();
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

    _loadFavorites();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
          FutureBuilder<dynamic>(
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
          FutureBuilder<dynamic>(
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