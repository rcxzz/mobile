import 'package:material_ui/material_ui.dart';
import 'screens/login.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GameCatalogApp());
}

class GameCatalogApp extends StatelessWidget {
  const GameCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Jogos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}