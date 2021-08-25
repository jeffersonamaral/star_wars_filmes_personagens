import 'package:flutter/material.dart';
import 'package:star_wars_filmes_personagens/util/route_generator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              title: Text('Lista de Filmes'),
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
            children: [
              Text('Filmes'),
              Text('Personagens'),
              Text('Favoritos'),
            ],
          ),
        )
    );
  }
}