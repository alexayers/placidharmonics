class SunoSong {
  SunoSong({
    required this.title,
    required this.type,
    required this.tags,
    required this.artistId,
    required this.avatarImageUrl,
    required this.artistName,
    required this.image,
    required this.id,
    required this.duration,
    required this.songIds,
    required this.prompt,
    required this.created,
    required this.playCount,
    required this.upvoteCount,
  });
  String title;
  String type;
  String tags;
  String id;
  double duration;
  List<String> songIds = [];
  String artistId;
  String artistName;
  String avatarImageUrl;
  String prompt;
  String created;
  String image;
  int playCount;
  int upvoteCount;
}
