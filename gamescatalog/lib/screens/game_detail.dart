import 'package:material_ui/material_ui.dart';
import '../models/game.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/game_cover_banner.dart';
import 'game_form1.dart';

class GameDetailScreen extends StatefulWidget {
  final Game game;

  const GameDetailScreen({super.key, required this.game});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  bool _wasUpdated = false;

  Widget _buildInfoLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'Monomaniac One',
            fontSize: 22,
            color: AppColors.textPrimary,
          ),
          children: [
            TextSpan(
              text: '$label : ',
              style: const TextStyle(color: AppColors.accentSecondary),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Future<void> _editGame() async {
    final updated = await Navigator.push<Game>(
      context,
      MaterialPageRoute(
        builder: (_) => GameFormStep1Screen(existingGame: widget.game),
      ),
    );

    if (updated != null) {
      setState(() {
        _wasUpdated = true;
      });
    }
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        title: const Text(
          'Confirmar Exclusão',
          style: TextStyle(fontSize: 24, color: AppColors.danger),
        ),
        content: Text(
          'Tem certeza que deseja excluir "${widget.game.title}" do catálogo? Esta ação não pode ser desfeita.',
          style: const TextStyle(fontSize: 18, color: AppColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(
              'CANCELAR',
              style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'EXCLUIR',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      Navigator.pop(context, 'deleted');
    }
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          game.title,
                          style: const TextStyle(fontSize: 30, height: 1.15),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(
                          context,
                          _wasUpdated ? 'updated' : null,
                        ),
                        icon: const Icon(Icons.close_rounded, size: 32),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GameCoverBanner(
                      label: game.imageLabel,
                      height: 180,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoLine('Gênero', game.genre),
                  _buildInfoLine('Desenv.', game.developer),
                  _buildInfoLine('Avaliação', game.rating),
                  _buildInfoLine('Faixa Etária', game.ageRating),
                  _buildInfoLine('Lançamento', game.releaseDate),
                  _buildInfoLine('Plataforma', game.platform),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        tooltip: 'Editar jogo',
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          size: 38,
                          color: AppColors.accentSecondary,
                        ),
                        onPressed: _editGame,
                      ),
                      IconButton(
                        tooltip: 'Excluir jogo',
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 34,
                          color: AppColors.danger,
                        ),
                        onPressed: _confirmDelete,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}