import 'package:lista3/naipe.dart';
import 'package:lista3/valor.dart';

class Carta {
  Naipe naipe;
  Valor valor;

  Carta(this.naipe, this.valor);

  @override
  String toString() {
    return '${_valorToString(valor)} DE ${_naipeToString(naipe)}';
  }

  String _valorToString(Valor valor) {
    switch (valor) {
      case Valor.as:
        return "ÁS";
      case Valor.dois:
        return "2";
      case Valor.tres:
        return "3";
      case Valor.quatro:
        return "4";
      case Valor.cinco:
        return "5";
      case Valor.seis:
        return "6";
      case Valor.sete:
        return "7";
      case Valor.oito:
        return "8";
      case Valor.nove:
        return "9";
      case Valor.dez:
        return "10";
      case Valor.valete:
        return "VALETE";
      case Valor.dama:
        return "DAMA";
      case Valor.rei:
        return "REI";
    }
  }

  String _naipeToString(Naipe naipe) {
    switch (naipe) {
      case Naipe.copas:
        return "COPAS";
      case Naipe.ouro:
        return "OURO";
      case Naipe.espada:
        return "ESPADAS";
      case Naipe.paus:
        return "PAUS";
    }
  }
}