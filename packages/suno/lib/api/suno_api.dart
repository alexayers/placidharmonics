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

      // User hard deleted song :-(
      if (results.statusCode != 200) {
        continue;
      }

      final sunoSong =
          responseToSunoSong(jsonDecode(results.body) as Map<String, dynamic>);

      listOfSongs.add(sunoSong);
      songIds.add(sunoSong.id);

      // Add cover clip id to the stack
      if (sunoSong.coverClipId != null) {
        songStack.add(sunoSong.coverClipId!);
      }

      for (final songId in sunoSong.songIds) {
        // Songs that are uploaded have m_ prefix for some reason
        if (!songIds.contains(songId.replaceAll('m_', ''))) {
          songStack.add(songId.replaceAll('m_', ''));
        }
      }
    } while (songStack.isNotEmpty);

    listOfSongs.sort((a, b) => a.created.compareTo(b.created));

    return listOfSongs;
  }
}
