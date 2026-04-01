import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Invertextoservice {
  final String _token = "25403|Q0Aj42b7h8ioVAUpsOppyPfD3pr55Bdq";

  Future<Map<String, dynamic>> convertePorExtenso(String? valor) async{
    try{
      final url = Uri.parse("https://api.invertexto.com/v1/number-to-words?token=$_token&number=$valor&language=pt&currency=BRL");
      final response = await http.get(url);
      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        throw Exception('Erro ${response.statusCode} : ${response.body}');
      }
    }on SocketException{
      throw Exception('Erro de conexão com a internet');
    }catch(e){
      rethrow;
    }
  }

  Future<Map<String, dynamic>> buscaCEP(String? valor) async{
    try{
      final url = Uri.parse("https://api.invertexto.com/v1/cep/$valor?token=$_token");
      final response = await http.get(url);
      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        throw Exception('Erro ${response.statusCode} : ${response.body}');
      }
    }on SocketException{
      throw Exception('Erro de conexão com a internet');
    }catch(e){
      rethrow;
    }
  }
}