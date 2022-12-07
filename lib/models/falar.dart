import 'package:flutter_tts/flutter_tts.dart';

class Audio {
  FlutterTts flutterTts = FlutterTts();
  Future falar(String letra) async {
    await flutterTts.setLanguage('pt-BR');
    await flutterTts
        .setVoice({'name': 'Google português do Brasil', 'locale': 'pt-BR'});
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(letra);
  }

  Future pausar() async {
    try {
      await flutterTts.pause();
    } catch (e) {
      print('Erro: ${e}');
    }
  }
}
