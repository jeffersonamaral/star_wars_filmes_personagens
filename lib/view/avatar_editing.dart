import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';

import 'widget/alternative_fluttermoji_customizer.dart';

class AvatarEditing extends StatefulWidget {

  AvatarEditing() {

  }

  @override
  _AvatarEditingState createState() => _AvatarEditingState();
}

class _AvatarEditingState extends State<AvatarEditing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Edição de Avatar'),
            bottom: PreferredSize(
                preferredSize: Size(double.infinity, kToolbarHeight),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
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
                        onTap: () => Navigator.of(context).pop(),
                        child: FluttermojiCircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 25,
                        ),
                      )
                    ],
                  ),
                )
            )
        ),
        body: Center(
            child: Column(
              children: [
                FluttermojiCircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: min(MediaQuery.of(context).size.height * .1 , 100),
                ),
                AlternativeFluttermojiCustomizer(
                  outerTitleText: 'Editar:',
                )
              ],
            )
        )
    );
  }
}