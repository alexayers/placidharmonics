import 'dart:html';

import 'package:suno_api/api/suno_api.dart';
import 'package:suno_api/models/suno_song.dart';
import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';
import 'package:teenytinytwodee/utils/color_utils.dart';

class SongSegment {
  SongSegment({
    required this.id,
    required this.title,
    required this.artist,
    required this.type,
    required this.created,
    required this.tags,
    required this.prompt,
    required this.duration,
    required this.x,
    required this.y,
  });
  final String id;
  final String title;
  final String artist;
  final String type;
  final String created;
  final String tags;
  final String prompt;
  final double duration;
  final int x;
  final int y;
}

class HipsterScreen implements GameScreen {
  final _sunoAPI = SunoApi();
  final _logger = Logger();
  late List<SunoSong> _songList = [];
  final List<ImageElement> _coverImages = [];
  final List<ImageElement> _artistImages = [];
  final List<SongSegment> _songSegments = [];
  final _renderer = Renderer();
  int _currentSong = 0;
  final _blockSize = 16;
  late String? _songID;
  final Set<String> _artists = {};

  @override
  Future<void> init() async {
    final currentUrl = window.location.href;
    final uri = Uri.parse(currentUrl);

    if (!uri.queryParameters.containsKey('song')) {
      _songID = null;
      return;
    }

    _songID = uri.queryParameters['song'];
    _songList = await _sunoAPI.getSongList(_songID!);

    final Set<String> tags = {};

    const offsetY = 168;
    int offsetX = 200;

    for (final song in _songList) {
      _artistImages.add(ImageElement(src: song.avatarImageUrl));
      _coverImages.add(ImageElement(src: song.image));
      tags.addAll(song.tags.split(',').map((e) => e.trim()));

      _songSegments.add(
        SongSegment(
          id: song.id,
          title: song.title,
          artist: song.artistName,
          type: song.type,
          created: song.created,
          tags: song.tags,
          prompt: song.prompt,
          duration: song.duration,
          x: offsetX,
          y: offsetY,
        ),
      );

      offsetX += _blockSize;
      _artists.add(song.artistName);
    }
    _currentSong = _songList.length - 1;
  }

  @override
  void keyboard(int keyCode) {}

  @override
  void logicLoop() {}

  @override
  void mouseClick(int x, int y, MouseButton mouseButton) {
    for (int i = 0; i < _songList.length; i++) {
      if (x >= _songSegments[i].x &&
          x <= _songSegments[i].x + _blockSize &&
          y >= _songSegments[i].y &&
          y <= _songSegments[i].y + _blockSize) {
        // ignore: unsafe_html
        window.open(
          'https://www.suno.com/song/${_songList[i].id}',
          '_blank',
          'noopener,noreferrer',
        );
      }
    }
  }

  @override
  void mouseMove(int x, int y) {
    for (int i = 0; i < _songList.length; i++) {
      if (x >= _songSegments[i].x &&
          x <= _songSegments[i].x + _blockSize &&
          y >= _songSegments[i].y &&
          y <= _songSegments[i].y + _blockSize) {
        _currentSong = i;
      }
    }
  }

  @override
  void onEnter() {}

  @override
  void onExit() {}

  @override
  void renderLoop() {
    if (_songID == null) {
      _renderer.print(
        x: 170,
        y: 250,
        msg: 'Hipster: Meta Data Analysis',
        font: Font(
          size: 32,
          family: 'Arial',
          color: Color(
            red: 255,
            green: 255,
            blue: 255,
          ),
        ),
      );
      return;
    } else if (_songList.isEmpty && _songID != null) {
      _renderer.print(
        x: 170,
        y: 250,
        msg: 'Analyzing Data...',
        font: Font(
          size: 64,
          family: 'Arial',
          color: Color(
            red: 255,
            green: 255,
            blue: 255,
          ),
        ),
      );
      return;
    }

    _renderSegments();

    const offsetY = 50;

    try {
      _renderer.renderImage(
        image: _coverImages[_currentSong],
        x: 55,
        y: offsetY,
        width: 132,
        height: 132,
      );
    } catch (e) {}

    try {
      _renderer.renderImage(
        image: _artistImages[_currentSong],
        x: 55,
        y: offsetY + 150,
        width: 132,
        height: 132,
      );
    } catch (e) {}

    _renderSong();
    _renderSegmentCard();

    _renderLyrics();
    _renderTags();
  }

  void _renderTags() {
    final tagColors = [
      '#6aaed6',
      '#63a8d3',
      '#5aa2cf',
      '#519ccc',
      '#4997c9',
      '#4090c5',
      '#3989c1',
      '#3282be',
      '#2c7cba',
      '#2474b7',
      '#1e6db2',
      '#1966ad',
      '#1460a8',
      '#0e59a2',
      '#09529d',
      '#084b93',
      '#08458a',
      '#083d7f',
      '#083674',
      '#08306b',
    ];

    final tags = _songList[_currentSong]
        .tags
        .split(RegExp(r'[,\s;]+'))
        .map((e) => e.trim())
        .toList();

    int offsetY = 360;
    int offsetX = 50;

    for (int i = 0; i < tags.length; i++) {
      if (i > 0 && i % 10 == 0) {
        offsetX += 100;
        offsetY = 360;
      }

      _renderer.print(
        x: offsetX,
        y: offsetY,
        msg: tags[i],
        font: Font(
          size: 10,
          family: 'Arial',
          color: hexToColor(tagColors[i]),
        ),
      );

      offsetY += 15;
    }
  }

  void _renderLyrics() {
    int offsetY = 70;
    const offsetX = 55;
    final lyrics = _songList[_currentSong].prompt.split('\n');

    final DivElement lyricsDiv = querySelector('#lyrics')! as DivElement;
    lyricsDiv.children.clear();

    for (final line in lyrics) {
      final lineDiv = DivElement();

      if (line.isEmpty) {
        offsetY += 15;
        lineDiv.text = line;
        lyricsDiv.append(lineDiv);
        continue;
      }

      lineDiv.style
        ..position = 'absolute'
        ..top = '${offsetY}px'
        ..left = '${offsetX}px'
        ..fontFamily = 'Arial'
        ..fontSize = '12px';

      final regExp = RegExp(r'(\(.*?\))');
      final parts = line
          .splitMapJoin(
            regExp,
            onMatch: (m) => '|${m.group(0)}|',
            onNonMatch: (n) => n,
          )
          .split('|');

      for (final part in parts) {
        final partSpan = SpanElement();
        if (part.startsWith('(') && part.endsWith(')')) {
          partSpan.style.color = 'DeepSkyBlue';
        } else {
          partSpan.style.color = line.contains('[') ? 'HotPink' : 'white';
        }
        partSpan.text = part;
        lineDiv.append(partSpan);
      }

      lyricsDiv.append(lineDiv);

      offsetY += 15;
    }
  }

  void _renderSong() {
    const offsetX = 200;
    int offsetY = 70;

    _renderer.print(
      x: offsetX - 2,
      y: offsetY,
      msg: _songList.last.title.length > 40
          ? 'Title: ${_songList.last.title.substring(0, 40)}...'
          : 'Title: ${_songList.last.title}',
      font: Font(
        size: 13,
        family: 'Arial',
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );

    offsetY += 20;

    _renderer.print(
      x: offsetX,
      y: offsetY,
      msg: 'Artists: ${_artists.join(', ')}',
      font: Font(
        size: 12,
        family: 'Arial',
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );

    offsetY += 15;

    _renderer.print(
      x: offsetX,
      y: offsetY,
      msg:
          'Play Count: ${_songList.last.playCount} Likes: ${_songList.last.upvoteCount}',
      font: Font(
        size: 10,
        family: 'Arial',
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );

    final totalDuration = DateTime.parse(_songList.last.created)
        .difference(DateTime.parse(_songList.first.created));

    offsetY += 12;

    _renderer.print(
      x: offsetX,
      y: offsetY,
      msg: 'Creation Time: $totalDuration',
      font: Font(
        size: 10,
        family: 'vt323',
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );

    offsetY += 12;

    _renderer.print(
      x: offsetX,
      y: offsetY,
      msg: 'Total Segments: ${_songList.length}',
      font: Font(
        size: 10,
        family: 'vt323',
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );
  }

  void _renderSegmentCard() {
    int offsetY = 220;
    const offsetX = 200;

    _renderer.print(
      x: offsetX,
      y: offsetY,
      msg: 'Id: ${_songList[_currentSong].id}',
      font: Font(
        size: 12,
        family: 'Arial',
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );

    offsetY += 20;

    _renderer.print(
      x: offsetX,
      y: offsetY,
      msg: _songList[_currentSong].title.length > 40
          ? 'Title: ${_songList[_currentSong].title.substring(0, 40)}...'
          : 'Title: ${_songList[_currentSong].title}',
      font: Font(
        size: 12,
        family: 'Arial',
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );

    offsetY += 20;

    _renderer.print(
      x: offsetX,
      y: offsetY,
      msg: 'Artists: ${_songList[_currentSong].artistName}',
      font: Font(
        size: 12,
        family: 'Arial',
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );

    offsetY += 20;

    _renderer.print(
      x: offsetX,
      y: offsetY,
      msg: 'Type: ${_songList[_currentSong].type}',
      font: Font(
        size: 12,
        family: 'Arial',
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );

    offsetY += 20;

    _renderer.print(
      x: offsetX,
      y: offsetY,
      msg: 'Created: ${_songList[_currentSong].created}',
      font: Font(
        size: 12,
        family: 'Arial',
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );
  }

  void _renderSegments() {
    final segmentColors = [
      '#440154',
      '#481467',
      '#482576',
      '#453781',
      '#404688',
      '#39558c',
      '#33638d',
      '#2d718e',
      '#287d8e',
      '#238a8d',
      '#1f968b',
      '#20a386',
      '#29af7f',
      '#3dbc74',
      '#56c667',
      '#75d054',
      '#95d840',
      '#bade28',
      '#dde318',
      '#fde725',
    ];

    for (int i = 0; i < _songList.length; i++) {
      if (i == _currentSong) {
        _renderer.print(
          x: 200,
          y: 160,
          msg: 'Play: ${_songList[i].id}',
          font: Font(
            size: 10,
            family: 'vt323',
            color: Color(
              red: 255,
              green: 255,
              blue: 255,
            ),
          ),
        );

        _renderer.rect(
          x: _songSegments[i].x,
          y: _songSegments[i].y,
          width: _blockSize,
          height: _blockSize,
          color: Color(
            red: 220,
            green: 220,
            blue: 220,
          ),
        );
      } else {
        _renderer.rect(
          x: _songSegments[i].x,
          y: _songSegments[i].y,
          width: _blockSize,
          height: _blockSize,
          color: hexToColor(segmentColors[i]),
        );
      }
    }
  }

  @override
  // TODO: implement overLayScreens
  Map<String, GameScreenOverlay> get overLayScreens => {};
}
