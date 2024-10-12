import 'dart:convert';
import 'package:http/http.dart' as http;

import '../mappers/mapper.dart';
import '../models/suno_song.dart';

class SunoApi {
  final baseAPI = 'studio-api.prod.suno.com';

  Future<List<SunoSong>> getSongList(String songId) async {
    final List<String> songIds = [];
    final List<String> songStack = [];
    final List<SunoSong> listOfSongs = [];
    songStack.add(songId);

    do {
      final songToGrab = songStack.removeLast();
      final results =
          await http.get(Uri.https(baseAPI, '/api/clip/$songToGrab'));

      if (results.statusCode != 200) {
        continue;
      }

      final sunoSong =
          responseToSunoSong(jsonDecode(results.body) as Map<String, dynamic>);

      listOfSongs.add(sunoSong);
      songIds.add(sunoSong.id);

      for (final songId in sunoSong.songIds) {
        if (!songIds.contains(songId.replaceAll('m_', ''))) {
          songStack.add(songId.replaceAll('m_', ''));
        }
      }
    } while (songStack.isNotEmpty);

    listOfSongs.sort((a, b) => a.created.compareTo(b.created));

    return listOfSongs;
  }
}
