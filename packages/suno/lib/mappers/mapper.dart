import '../models/suno_artist.dart';
import '../models/suno_song.dart';

SunoSong responseToSunoSong(Map<String, dynamic> songMap) {
  final List<String> songList = [];
  String prompt = '';
  String type = '';
  String tags = '';
  String title = '';
  double duration = 0;
  String coverClipId = '';

  if (!songMap.containsKey('title') || songMap['title'] == null) {
    title = songMap['prompt'] as String;
  } else {
    title = songMap['title'] as String;
  }

  if (!songMap.containsKey('metadata')) {
    throw Exception('Song metadata not found');
  }

  final metadata = songMap['metadata'] as Map<String, dynamic>;

  if (metadata.containsKey('concat_history')) {
    final concatHistory = metadata['concat_history'] as List<dynamic>;
    for (final entry in concatHistory) {
      songList.add(entry['id'] as String);
    }
  }

  if (metadata.containsKey('prompt')) {
    prompt = metadata['prompt'] as String;
  }

  if (metadata.containsKey('type')) {
    type = metadata['type'] as String;
  }

  if (metadata.containsKey('tags')) {
    tags = metadata['tags'] as String;
  }

  if (metadata.containsKey('duration')) {
    duration = metadata['duration'] as double;
  }

  if (metadata.containsKey('cover_clip_id')) {
    coverClipId = metadata['cover_clip_id'] as String;
  }

  return SunoSong(
    title: title,
    image:
        songMap.containsKey('image_url') ? songMap['image_url'] as String : '',
    type: type,
    artistId: songMap['user_id'] as String,
    artistName: songMap['handle'] as String,
    avatarImageUrl: songMap.containsKey('avatar_image_url')
        ? songMap['avatar_image_url'] as String
        : '',
    tags: tags,
    duration: duration,
    id: songMap.containsKey('id') ? songMap['id'] as String : '',
    prompt: prompt,
    songIds: songList,
    created: songMap.containsKey('created_at')
        ? songMap['created_at'] as String
        : '',
    playCount:
        songMap.containsKey('play_count') ? songMap['play_count'] as int : 0,
    upvoteCount: songMap.containsKey('upvote_count')
        ? songMap['upvote_count'] as int
        : 0,
    coverClipId: coverClipId != '' ? coverClipId : null,
  );
}

SunoArtist responseToSunoArtist(Map<String, dynamic> artistMap) {
  return SunoArtist(
    id: artistMap['id'] as String,
    displayName: artistMap['display_name'] as String,
    handle: artistMap['handle'] as String,
    avatarImageUrl: artistMap['avatar_image_url'] as String,
  );
}
