void lista2(){
  List<String> frutas = ['Maçã', 'Banana', 'Morango', 'Abacate', 'Manga'];      //ex1
  print(frutas);

  print(frutas[2]);      //ex2  

  frutas.add('Laranja');      //ex3
  print(frutas);
  frutas.remove('Maçã');      
  print(frutas);

  for(int i=0; i<frutas.length; i++){      //ex4
    print(frutas[i].toUpperCase());
  }

  frutas.forEach((fruta){print(fruta.toLowerCase());});      //ex5

  List<String> frutasComA = frutas.where((fruta) {return fruta.toLowerCase().startsWith('a');}).toList();      //ex6
  print(frutasComA);

  Map<double, String> precosFrutas = {
    5.5:frutas[0], 6.6:frutas[1], 10.0:frutas[2], 3.5:frutas[3], 4.5:frutas[4]};      //ex7
  print(precosFrutas);

  precosFrutas.forEach((key, value){      //ex8
    print('$value R $key');
  });

  List<int> numeros = [1, 5, 18, 66, 78, 19, 26];
  var pares = numeros.where((numero) => numero % 2 == 0).toList();       //ex9
  print(pares);

}
