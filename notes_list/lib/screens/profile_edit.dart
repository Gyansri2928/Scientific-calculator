import 'package:flutter/material.dart';
import 'package:notes_list/screens/user/user.dart';
import 'package:notes_list/screens/user/userdata.dart';
import 'package:notes_list/widgets/appbarwidget.dart';
import 'package:notes_list/widgets/profilewidget.dart';
import 'package:notes_list/widgets/textfieldwidget.dart';
class EditProfilePage extends StatefulWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;
  const EditProfilePage({
    Key? key,
  required this.imagePath,
   this.isEdit=false,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserData.myUser;
  @override
  Widget build(BuildContext context)=> Scaffold(
    appBar: buildAppBar(context),
    body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      children: [
        ProfileWidget(
          imagePath: user.imagePath,
            isEdit: true,
            onClicked: ()async{},
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldWidget(
          label: 'Full Name',
          text: user.name,
          onChanged: (name){},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
            label: 'Email',
            text: user.email,
            onChanged: (email){},
        ),
      ],
    ),
  );
  }

