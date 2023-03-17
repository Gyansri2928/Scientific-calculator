import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:notes_list/screens/profile_edit.dart';
import 'package:notes_list/screens/user/user.dart';
import 'package:notes_list/screens/user/userdata.dart';
import 'package:notes_list/widgets/buttonwidget.dart';
import 'package:notes_list/widgets/profilewidget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context)=>Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.white,),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.shield_moon,color: Colors.white,),
                onPressed: (){},

            )
          ],

        ),
        backgroundColor: Colors.black,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath:user.imagePath,
              onClicked: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>EditProfilePage(imagePath: user.imagePath, onClicked: (){})),
                );
              },
              isEdit: false,
            ),
            const SizedBox(
              height: 25,
            ),
            buildName(user),
            const SizedBox(
              height: 250,
            ),
            Positioned(
                bottom: 12,
                right: 120,
                child: Center(child: buildLogoutbutton())),
          ],
        ),
      ),
      ),
    );
  }
  Widget buildName(User user)=>Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,color: Colors.white),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );
  Widget buildLogoutbutton()=> ButtonWidget(
    text: 'LogOut',
    onClicked: (){},
  );
}
