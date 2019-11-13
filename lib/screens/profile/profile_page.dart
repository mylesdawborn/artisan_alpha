import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: CircularProfileAvatar(
                'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4',
                cacheImage: true,
                radius: 100.0,
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text('Name Placeholder', style: TextStyle(fontSize: 30.0),),
            )
          ],
        ),
    );
  }
}
