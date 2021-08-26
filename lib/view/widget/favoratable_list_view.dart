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
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder: (_, index) => Divider(
          color: Colors.black,
        ),
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
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
              child: Icon(Random().nextBool() == true ? Icons.favorite : Icons.favorite_border),
            ),
          );
        }
    );
  }

}