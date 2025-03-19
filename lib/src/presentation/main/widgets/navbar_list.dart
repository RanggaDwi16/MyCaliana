import 'package:flutter/material.dart';
import 'package:my_caliana/src/presentation/home/pages/home_page.dart';
import 'package:my_caliana/src/presentation/profile/pages/profile_page.dart';

List<IconData> iconList = [Icons.home_outlined, Icons.person_outline_rounded];
List<String> labelList = ["Beranda", "Profil"];
List<Widget> listFrame = [
  const HomePage(),
  const ProfilePage(),
];
