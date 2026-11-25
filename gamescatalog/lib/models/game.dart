import 'dart:typed_data';

class GameOptions {
  static const List<String> genres = [
    'Ação',
    'Aventura',
    'RPG',
    'Corrida',
    'Estratégia',
    'Esportes',
    'Terror',
  ];

  static const List<String> platforms = [
    'PC',
    'PlayStation',
    'Xbox',
    'Nintendo Switch',
    'Mobile',
    'Multiplataforma',
  ];
}

class Game {
  String id;
  String title;
  String genre;
  String developer;
  String rating;
  String ageRating;
  String releaseDate;
  String platform;
  String imageLabel;
  Uint8List? imageBytes;

  Game({
    required this.id,
    required this.title,
    required this.genre,
    required this.developer,
    required this.rating,
    required this.ageRating,
    required this.releaseDate,
    required this.platform,
    this.imageLabel = 'Capa do Jogo',
    this.imageBytes,
  });
}