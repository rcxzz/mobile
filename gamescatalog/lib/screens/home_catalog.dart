import 'package:material_ui/material_ui.dart';
import '../models/game.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/game_cover_banner.dart';
import 'game_detail.dart';
import 'game_form1.dart';
import 'login.dart';

class HomeCatalogScreen extends StatefulWidget {
  const HomeCatalogScreen({super.key});

  @override
  State<HomeCatalogScreen> createState() => _HomeCatalogScreenState();
}

class _HomeCatalogScreenState extends State<HomeCatalogScreen> {
  final List<Game> _games = [];
  String _searchQuery = '';

  List<Game> get _filteredGames {
    if (_searchQuery.isEmpty) return _games;
    return _games
        .where((g) =>
            g.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            g.genre.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            g.platform.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> _createGame() async {
    final createdGame = await Navigator.push<Game>(
      context,
      MaterialPageRoute(builder: (_) => const GameFormStep1Screen()),
    );

    if (createdGame != null) {
      setState(() {
        _games.add(createdGame);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.success,
            content: Text('Jogo cadastrado com sucesso!'),
          ),
        );
      }
    }
  }

  Future<void> _openGameDetails(Game game) async {
    final actionResult = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => GameDetailScreen(game: game)),
    );

    if (actionResult == 'deleted') {
      setState(() {
        _games.removeWhere((item) => item.id == game.id);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.danger,
            content: Text('Jogo excluído do catálogo.'),
          ),
        );
      }
    } else if (actionResult == 'updated') {
      setState(() {});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.success,
            content: Text('Dados do jogo atualizados!'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gamesToDisplay = _filteredGames;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          tooltip: 'Sair',
          icon: const Icon(Icons.logout_rounded, size: 28),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        ),
        title: const Text(
          'CATÁLOGO DE JOGOS',
          style: TextStyle(fontSize: 26, letterSpacing: 1.2),
        ),
        centerTitle: true,
      ),
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Consultar jogo por nome, gênero ou plataforma...',
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary.withValues(alpha: 0.6),
                      fontSize: 16,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.accentSecondary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: gamesToDisplay.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.sports_esports_outlined,
                                size: 72,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _games.isEmpty
                                    ? 'Nenhum jogo cadastrado ainda.\nToque no botão "+" abaixo para adicionar o primeiro!'
                                    : 'Nenhum jogo encontrado para essa busca.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 21,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
                        itemCount: gamesToDisplay.length,
                        itemBuilder: (context, index) {
                          final game = gamesToDisplay[index];
                          return GestureDetector(
                            onTap: () => _openGameDetails(game),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: AppColors.cardSurface,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.08),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                    child: GameCoverBanner(
                                      label: game.imageLabel,
                                      height: 150,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 14,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                game.title,
                                                style: const TextStyle(
                                                  fontSize: 23,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                              Text(
                                                '${game.genre} • ${game.platform}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.chevron_right_rounded,
                                          size: 30,
                                          color: AppColors.accentSecondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Cadastrar novo jogo',
        onPressed: _createGame,
        backgroundColor: AppColors.accentPrimary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_rounded, size: 34),
      ),
    );
  }
}