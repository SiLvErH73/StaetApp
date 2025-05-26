import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mvp/repositories/Steam/Steam.dart';

import '../../../repositories/Steam/lib_steam.dart';
import '../../../repositories/Steam/model/models.dart';
import '../widgets/lybery_grid.dart';

class MHP extends StatefulWidget {
  const MHP({super.key});

  @override
  State<MHP> createState() => _MHPState();
}

class _MHPState extends State<MHP> {
  List<Game>? _GameList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3d3d3d),
      appBar: AppBar(
        backgroundColor: Color(0xFF282828),
        leading: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white70,
        ),
        title: Text("mvp"),
      ),
      body: (_GameList == null)
          ? SizedBox()
          : GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 6 / 9,
          ),
          itemCount: _GameList!.length,
          itemBuilder: (context, index) {
            final Game = _GameList![index];
            final name = Game.name;
            final img = Game.img;

            return LyberiGrid(Game: Game, img: img, name: name);
          }),
      floatingActionButton: RawMaterialButton(
        onPressed: () async {
          _GameList = await GetIt.I<AbstractLibSteam>().getLibSteam();
          setState(() {});
        },
        constraints: BoxConstraints.loose(Size(80, 80)),
        fillColor: Color(0xFF515FFF),
        shape: CircleBorder(),
        child: Center(
          child: Text("Добавить \n библиотеку"),
        ),
      ),
    );
  }
}


