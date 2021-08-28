import 'dart:math';

import 'package:flutter/material.dart';
import 'package:star_wars_filmes_personagens/model/favorite_model.dart';
import 'package:star_wars_filmes_personagens/util/types.dart';

class FavoratableListView extends StatefulWidget {

  List<FavoriteModel>? _data;

  List<FavoriteModel>? _favorites;

  late FavoriteCallback _favoriteCallback;

  FavoratableListView(this._data, this._favorites, { required FavoriteCallback onFavorite }) {
    this._favoriteCallback = onFavorite;

    this._data?.forEach((element) {
      if (this._favorites!.any((e) => e.name == element.name)) {
        element.favorite = true;
      }
    });
  }

  @override
  _FavoratableListViewState createState() => _FavoratableListViewState();

}

class _FavoratableListViewState extends State<FavoratableListView> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        itemCount: widget._data?.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: ListTile(
              title: Center(
                child: Text(
                  widget._data![index].name,
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  setState(() {
                    widget._favoriteCallback(widget._data![index]);
                    widget._data![index].favorite = !widget._data![index].favorite;
                  });
                },
                child: widget._data![index].favorite == true
                    ? Icon(Icons.favorite, color: Colors.red,)
                    : Icon(Icons.favorite_border, color: Colors.black,),
              ),
            ),
          );
        }
    );
  }

}