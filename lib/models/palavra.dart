class Palavra {
  final String palavra;
  final String silabasDaPalavra1;
  final String silabasDaPalavra2;
  final String silabasDaPalavra3;
  final String silabasDaPalavra4;
  final String silabasDaPalavra5;
  final String urlImagem;

  const Palavra({
    required this.palavra,
    required this.silabasDaPalavra1,
    this.silabasDaPalavra2 = '',
    this.silabasDaPalavra3 = '',
    this.silabasDaPalavra4 = '',
    this.silabasDaPalavra5 = '',
    required this.urlImagem,
  });
}
