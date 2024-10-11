import 'dart:html';

class TextToSpeech {
  final speech = SpeechSynthesisUtterance();
  MediaRecorder? mediaRecorder;
  List<Blob> audioChunks = [];

  void speak(String text, {double? rate, double? pitch, double? volume}) {
    speech.text = text;
    speech.rate = rate ?? 1.0;
    speech.pitch = pitch ?? 1.0;
    speech.volume = volume ?? 1.0;
    //speech.voice = getRandomArrayElement(window.speechSynthesis!.getVoices())
    //    as SpeechSynthesisVoice;
    window.speechSynthesis!.speak(speech);
  }
}
