import 'package:flutter/material.dart';
import 'package:star_wars_filmes_personagens/view/widget/avatar_editing.dart';
import 'package:star_wars_filmes_personagens/view/widget/home.dart';
import 'package:star_wars_filmes_personagens/view/widget/official_site.dart';

class RouteGenerator {

  static const home = '/';

  static const officialSite = '/officialSite';

  static const avatarEditing = '/avatarEditing';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            builder: (BuildContext context) {
              return Home();
            }
        );

        break;

      case officialSite:
        return MaterialPageRoute(
            builder: (BuildContext context) {
              return OfficialSite();
            }
        );

        break;

      case avatarEditing:
        return MaterialPageRoute(
            builder: (BuildContext context) {
              return AvatarEditing();
            }
        );

        break;

      default:
        throw Exception('Invalid Route: ${settings.name}');
    }
  }
}