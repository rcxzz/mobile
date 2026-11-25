import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/country_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller =
      TextEditingController();

  final CountryService service =
      CountryService();

  Country? country;
  bool loading = false;

  Future<void> search() async {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      loading = true;
    });

    final result =
        await service.searchCountry(
      controller.text.trim(),
    );

    setState(() {
      country = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Busca de Países',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Digite um país',
                border:
                    const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon:
                      const Icon(Icons.search),
                  onPressed: search,
                ),
              ),
              onSubmitted: (_) => search(),
            ),

            const SizedBox(height: 20),

            if (loading)
              const CircularProgressIndicator(),

            if (!loading &&
                country != null)
              Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.public,
                        size: 70,
                      ),

                      const SizedBox(height: 15),

                      Text(
                        country!.name,
                        textAlign:
                            TextAlign.center,
                        style:
                            const TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const Divider(
                        height: 30,
                      ),

                      ListTile(
                        leading: const Icon(
                          Icons.location_city,
                        ),
                        title: Text(
                          'Capital: ${country!.capital}',
                        ),
                      ),

                      ListTile(
                        leading: const Icon(
                          Icons.public,
                        ),
                        title: Text(
                          'Região: ${country!.region}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (!loading &&
                country == null)
              const Padding(
                padding:
                    EdgeInsets.only(top: 30),
                child: Text(
                  'Pesquise um país para visualizar as informações.',
                ),
              ),
          ],
        ),
      ),
    );
  }
}