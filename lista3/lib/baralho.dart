import 'dart:math';
import 'package:lista3/carta.dart';
import 'package:lista3/naipe.dart';
import 'package:lista3/valor.dart';

class Baralho {
  List<Carta> cartas = [];

  Baralho() {
    for (var naipe in Naipe.values) {
      for (var valor in Valor.values) {
        cartas.add(Carta(naipe, valor));
      }
    }
  }

  void embaralhar() {
    cartas.shuffle(Random());
  }

  Carta? comprar() {
    if (cartas.isNotEmpty) {
      return cartas.removeAt(0);
    }
    return null;
  }

  int cartasRestantes() {
    return cartas.length;
  }
}