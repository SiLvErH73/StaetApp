import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp/repositories/Steam/model/models.dart';

class GameInfo extends StatefulWidget {
  const GameInfo({super.key});

  @override
  State<GameInfo> createState() => _GameInfoState();
}

class _GameInfoState extends State<GameInfo> {
  String? gameName;
  String? gameImg;
  String? MyText;




  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null) {
      log('Хде блять');
      return;
    }
    if (args is! Game) {
      log('Хде блять строка');
      return;
    }
    gameName = args.name;
    gameImg = args.img;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gameName ?? '---'),
      ),
      body:
      SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🎮 Обложка и название
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    gameImg!,
                    width: 100,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    gameName!,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // 🏷️ Теги
            Wrap(
              spacing: 8,
              children: [
                _buildTag('#RPG'),
                _buildTag('#Экшн'),
                _buildTag('#Сюжет'),
                _buildTag('#...'),
              ],
            ),

            SizedBox(height: 24),

            // 🖥️ Платформы
            Text(
              'Платформы',
              style: TextStyle(color: Colors.white70),
            ),
            Row(
              children: [
                Image.network('https://steamuserimages-a.akamaihd.net/ugc/1750231457016742765/234BCCA1FCE231306BA731CE1C55A6255F0268B2/?imw=512&amp;imh=512&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true', width: 32),
                SizedBox(width: 8),
                Image.network('https://steamuserimages-a.akamaihd.net/ugc/1750231457016742765/234BCCA1FCE231306BA731CE1C55A6255F0268B2/?imw=512&amp;imh=512&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true', width: 32),
              ],
            ),

            Divider(height: 32, color: Colors.white24),

            // 🟢 Онлайн
            Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 10),
                SizedBox(width: 6),
                Text('Онлайн', style: TextStyle(color: Colors.white)),
              ],
            ),

            SizedBox(height: 16),

            // 👤 Список игроков
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 51,
              itemBuilder: (context, index) {
                return _buildUserTile(index);
              },
            ),
          ],
        ),
      ),



      // ➕ Кнопка добавить
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Привет 👋", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    const SizedBox(height: 8),
                    TextField(
                      onChanged: (String value){
                        MyText = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Оставьте свою заявку",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        print (MyText);
                        Navigator.pop(context);
                        FirebaseFirestore.instance.collection('test').add({'test_massage': MyText});
                      },
                      child: Text("Закрыть"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }


  Widget _buildTag(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.grey[800],
      labelStyle: TextStyle(color: Colors.white),
    );
  }

  Widget _buildUserTile(int index) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.grey),
      title: Text('Имя $index', style: TextStyle(color: Colors.white)),
      subtitle: Text(
        'Привет ищу напарника побродить по лесу',
        style: TextStyle(color: Colors.white70),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(Icons.expand_more, color: Colors.white54),
    );
  }
}