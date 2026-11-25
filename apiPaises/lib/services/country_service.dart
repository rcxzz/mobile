import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class CountryService {
  static const String apiKey =
      'rc_live_2598356bd15a4f68968d3dea81088ad7';

  Future<Country?> searchCountry(String name) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.restcountries.com/countries/v5/names.common/$name',
        ),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');

      if (response.statusCode != 200) {
        return null;
      }

      final data = jsonDecode(response.body);

      if (data['data'] == null ||
          data['data']['objects'] == null) {
        return null;
      }

      final List objects =
          data['data']['objects'];

      if (objects.isEmpty) {
        return null;
      }

      final country =
          objects.first as Map<String, dynamic>;

      return Country.fromJson(country);
    } catch (e) {
      print('ERRO => $e');
      return null;
    }
  }
}