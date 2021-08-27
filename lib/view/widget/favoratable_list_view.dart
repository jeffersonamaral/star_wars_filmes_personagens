import 'dart:math';

import 'package:flutter/material.dart';
import 'package:star_wars_filmes_personagens/model/abstract_model.dart';

class FavoratableListView extends StatelessWidget {

  List<AbstractModel> _data;

  GestureTapCallback? _onFavorite;

  FavoratableListView(this._data, { GestureTapCallback? onFavorite }) {
    this._onFavorite = onFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
            ),
            child: ListTile(
              title: Center(
                child: Text(
                  _data[index].label,
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
              ),
              trailing: InkWell(
                onTap: _onFavorite,
                child: Icon(Icons.favorite, color: Colors.red,),
              ),
            ),
          );
        }
    );
  }

}