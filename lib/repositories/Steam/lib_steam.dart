// я блять со склерозом, поэтому
// тут я делаю запрос API из стим, а в паке model хранятся модель, в которую всё переносится, чтобы понимать какие данные я забираю


import 'package:dio/dio.dart';
import 'Steam.dart';



class LibSteam implements AbstractLibSteam {

  LibSteam({required this.dio});
  final Dio dio;

  @override
  Future<List<Game>> getLibSteam() async {
    final String ID_max =  '76561198357677759';
    final String ID_pesha ='76561198373854059';
    final String ID_ily =  '73635462374000000';
    final response = await dio.get(
        'https://api.steampowered.com/IPlayerService/GetOwnedGames/v1/?key=4A19707EC7EB91387C90016800567358&steamid=${ID_max}ID&include_appinfo=1&format=json'
    );



    final games = response.data['response']['games'] as List;

    return games.map((game) {
      return Game(
        name: game['name'],
        img: 'https://cdn.akamai.steamstatic.com/steam/apps/${game['appid']}/library_600x900.jpg',

      );
    }).toList();
  }
}
