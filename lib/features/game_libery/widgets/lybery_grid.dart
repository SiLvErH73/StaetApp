import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LyberiGrid extends StatelessWidget {
  const LyberiGrid({
    super.key,
    required this.Game,
    required this.img,
    required this.name,
  });

  final Game;
  final String img;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.of(context).pushNamed(
            '/GameInfo',
            arguments:
            (Game), // хуйня для переноса инфы на след страницу в с помощью didChange
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: NetworkImage(img))),
          child: Center(
            child: Text(name),
          ),
        ),
      ),
    );
  }
}