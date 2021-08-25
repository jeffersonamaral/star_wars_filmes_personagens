import 'package:flutter/material.dart';
import 'package:star_wars_filmes_personagens/util/route_generator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Lista de Filmes'),
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, kToolbarHeight),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
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
                        // FIXME Implementar
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
              )
          )
      ),
      body: Center(),
    );
  }
}