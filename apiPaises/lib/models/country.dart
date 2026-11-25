class Country {
  final String name;
  final String capital;
  final String region;

  Country({
    required this.name,
    required this.capital,
    required this.region,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    String capital = 'Não informado';

    if (json['capitals'] is List &&
        (json['capitals'] as List).isNotEmpty) {
      final firstCapital = json['capitals'][0];

      if (firstCapital is Map<String, dynamic>) {
        capital = firstCapital['name'] ?? 'Não informado';
      } else {
        capital = firstCapital.toString();
      }
    }

    return Country(
      name: json['names']?['common'] ?? 'Não informado',
      capital: capital,
      region: json['region']?.toString() ?? 'Não informado',
    );
  }
}