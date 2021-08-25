import 'package:flutter/material.dart';

class AvatarEditing extends StatefulWidget {
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
                        onPressed: null,
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
      body: Center(
        child: Text('Avatar'),
      )
    );
  }
}