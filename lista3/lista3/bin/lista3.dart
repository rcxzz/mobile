import 'package:lista3/baralho.dart';

void main() {
  var baralho = Baralho();

  baralho.embaralhar();

  for (int i = 0; i < 5; i++) {
    var carta = baralho.comprar();
    print(carta);
  }

  print("Cartas restantes no baralho: ${baralho.cartasRestantes()}");
}