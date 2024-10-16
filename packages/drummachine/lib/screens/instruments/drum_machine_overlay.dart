import 'package:teenytinytwodee/teenytinytwodee.dart';

class DrumMachineOverlay extends GameScreenOverlay {
  final _renderer = Renderer();
  final _wavFormSynthesis = WavFormSynthesis();

  final _drumTrack = Map<String, List<int>>() = {
    'Bass Drum': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Snare': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Cymbal': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Ride Cymbal': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Hi Hat': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Low Tom': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Mid Tom': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'High Tom': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Hand Clap': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Rim Shot': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Cow Bell': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  };

  int _currentBar = 0;
  int _currentBPM = 120;
  int _currentDelay = 120;
  String _currentInstrument = 'Bass Drum';
  final TimerUtil _timer = TimerUtil();

  @override
  void init() {
    _timer.waitTime = _currentBPM;

    _wavFormSynthesis.register(
      name: 'Bass Drum',
      waveForm: WaveForm.sine,
      frequency: 50,
      duration: 0.5,
      volume: 1.5,
    );

    _wavFormSynthesis.register(
      name: 'Rim Shot',
      waveForm: WaveForm.sine,
      frequency: 2000,
      duration: 0.1,
      volume: 1.0,
    );

    _wavFormSynthesis.register(
      name: 'Hand Clap',
      waveForm: WaveForm.square,
      frequency: 700,
      duration: 0.2,
      volume: 1.0,
      generateWhiteNoise: true,
    );

    _wavFormSynthesis.register(
      name: 'Cow Bell',
      waveForm: WaveForm.square,
      frequency: 800,
      duration: 0.3,
      volume: 0.1,
    );

    _wavFormSynthesis.register(
      name: 'Low Tom',
      waveForm: WaveForm.sine,
      frequency: 100,
      duration: 0.5,
      volume: 1.0,
    );

    _wavFormSynthesis.register(
      name: 'Mid Tom',
      waveForm: WaveForm.sine,
      frequency: 150,
      duration: 0.5,
      volume: 1,
    );

    _wavFormSynthesis.register(
      name: 'High Tom',
      waveForm: WaveForm.sine,
      frequency: 200,
      duration: 0.5,
      volume: 0.5,
    );

    _wavFormSynthesis.register(
      name: 'Snare',
      waveForm: WaveForm.sine,
      duration: 0.2,
      generateWhiteNoise: true,
      volume: 0.5,
    );

    _wavFormSynthesis.register(
      name: 'Hi Hat',
      waveForm: WaveForm.sine,
      duration: 0.1,
      generateWhiteNoise: true,
      volume: 0.5,
    );

    _wavFormSynthesis.register(
      name: 'Cymbal',
      waveForm: WaveForm.sine,
      duration: 0.5,
      generateWhiteNoise: true,
      volume: 0.5,
    );

    _wavFormSynthesis.register(
      name: 'Ride Cymbal',
      waveForm: WaveForm.sine,
      duration: 1.0,
      generateWhiteNoise: true,
      volume: 0.5,
    );
  }

  @override
  void renderLoop() {
    int offsetX = 250;

    _renderer.rect(
      x: offsetX,
      y: 120,
      width: 325,
      height: 300,
      color: black,
    );

    offsetX += 2;

    _renderer.rect(
      x: offsetX,
      y: 122,
      width: 321,
      height: 296,
      color: hexToColor('#201904'),
    );

    offsetX += 10;

    _renderer.rect(
      x: offsetX,
      y: 132,
      width: 301,
      height: 276,
      color: black,
    );

    offsetX += 8;

    _renderer.rect(
      x: offsetX,
      y: 142,
      width: 100,
      height: 16,
      color: hexToColor('#202021'),
    );

    offsetX = 270;

    _renderer.print(
      msg: _currentInstrument,
      x: offsetX,
      y: 155,
      font: Font(family: 'vt323', size: 20, color: white),
    );

    offsetX = 490;

    _renderer.rect(
      x: offsetX,
      y: 142,
      width: 40,
      height: 16,
      color: hexToColor('#202021'),
    );

    offsetX = 500;

    _renderer.print(
      msg: _currentBPM.toString(),
      x: offsetX,
      y: 155,
      font: Font(family: 'vt323', size: 20, color: brightRed),
    );

    offsetX += 30;

    _renderer.print(
      msg: 'BPM',
      x: offsetX,
      y: 155,
      font: Font(family: 'vt323', size: 20, color: white),
    );

    offsetX = 280;

    for (int i = 0; i < 16; i++) {
      if (_drumTrack[_currentInstrument]![i] == 1) {
        _renderer.circle(
          x: offsetX + i * 18,
          y: 350,
          radius: 4,
          color: brightRed,
        );
      } else {
        if (i == _currentBar) {
          _renderer.circle(x: offsetX + i * 18, y: 350, radius: 4, color: red);
        } else {
          _renderer.circle(
            x: offsetX + i * 18,
            y: 350,
            radius: 4,
            color: drkGray,
          );
        }
      }
    }
  }

  @override
  void keyboard(int keyCode) {
    // TODO: implement keyboard
  }

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  void onOpen() {
    // TODO: implement onOpen
  }

  @override
  void logicLoop() {
    if (_timer.hasTimePassed()) {
      for (final key in _drumTrack.keys) {
        if (_drumTrack[key]![_currentBar] == 1) {
          _wavFormSynthesis.play(key);
        }
      }

      _currentBar++;
      if (_currentBar > 15) {
        _currentBar = 0;
      }

      _timer.reset();
    }
  }

  @override
  List<Widget> getWidgets() {
    final List<Widget> widgets = [];

    const offsetX = 265;

    final windowWidget = WindowWidget(
      id: 'drumMachine',
      x: offsetX,
      y: 132,
      width: 300,
      height: 276,
    );

    final buttonColors = [red, orange, yellow, ltGray];
    final buttonHoverColors = [brightRed, brightOrange, brightYellow, white];
    int j = 0;

    for (int i = 0; i < 16; i++) {
      windowWidget.addWidget(
        ButtonWidget(
          id: 'drumMachine',
          x: 5 + i * 18,
          y: 230,
          width: 16,
          height: 24,
          color: buttonColors[j],
          mouseOverColor: buttonHoverColors[j],
          onClick: () {
            if (_drumTrack[_currentInstrument]![i] == 1) {
              _drumTrack[_currentInstrument]![i] = 0;
            } else {
              _drumTrack[_currentInstrument]![i] = 1;
              _wavFormSynthesis.play(_currentInstrument);
            }
          },
        ),
      );

      if ((i + 1) % 4 == 0) {
        j++;
      }
    }

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: 8,
        y: 30,
        width: 30,
        height: 20,
        color: maroon,
        mouseOverColor: red,
        text: 'reset',
        font: Font(family: 'vt323', size: 12, color: white),
        onClick: () {
          for (final key in _drumTrack.keys) {
            for (int i = 0; i < 16; i++) {
              _drumTrack[key]![i] = 0;
            }
          }
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: 230,
        y: 30,
        width: 20,
        height: 20,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          if (_currentBPM > 40) {
            _currentBPM--;
            _currentDelay++;
            _timer.waitTime = _currentDelay;
          }
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: 260,
        y: 30,
        width: 20,
        height: 20,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          if (_currentBPM < 200) {
            _currentBPM++;
            _currentDelay--;
            _timer.waitTime = _currentDelay;
          }
        },
      ),
    );

    int instrumentSelectorX = 10;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'BD',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'Bass Drum';
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('Bass Drum');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('Bass Drum');
        },
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'SD',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'Snare';
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('Snare');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(
          family: 'vt323',
          size: 16,
          color: Color(
            red: 255,
            green: 255,
            blue: 255,
          ),
        ),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('Snare');
        },
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'LT',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'Low Tom';
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('Low Tom');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('Low Tom');
        },
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'MT',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'Mid Tom';
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('Mid Tom');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('Mid Tom');
        },
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'HT',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'High Tom';
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('High Tom');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('High Tom');
        },
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'RS',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'Rim Shot';
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('Rim Shot');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('Rim Shot');
        },
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'HC',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'Hand Clap';
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('Hand Clap');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('Hand Clap');
        },
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'CB',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'Cow Bell';
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('Cow Bell');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('Cow Bell');
        },
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'CY',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'Cymbal';
        },
      ),
    );
    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('Cymbal');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('Cymbal');
        },
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'HH',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'Hi Hat';
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('Hi Hat');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('Hi Hat');
        },
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'RS',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _currentInstrument = 'Ride Cymbal';
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 100,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '+',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.increaseVolume('Ride Cymbal');
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 130,
        width: 24,
        height: 24,
        color: drkGray,
        mouseOverColor: ltGray,
        text: '-',
        font: Font(family: 'vt323', size: 16, color: white),
        onClick: () {
          _wavFormSynthesis.decreaseVolume('Ride Cymbal');
        },
      ),
    );

    instrumentSelectorX += 25;

    widgets.add(windowWidget);

    return widgets;
  }
}
