import 'package:material_ui/material_ui.dart';
import '../models/game.dart';
import '../theme/app_theme.dart';
import '../utils/form_validators.dart';
import '../widgets/app_background.dart';
import '../widgets/selectable_dropdown_input.dart';
import '../widgets/validated_input.dart';
import 'game_form2.dart';

class GameFormStep1Screen extends StatefulWidget {
  final Game? existingGame;

  const GameFormStep1Screen({super.key, this.existingGame});

  @override
  State<GameFormStep1Screen> createState() => _GameFormStep1ScreenState();
}

class _GameFormStep1ScreenState extends State<GameFormStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _developerController;
  late final TextEditingController _ratingController;
  String? _selectedGenre;

  bool get isEditing => widget.existingGame != null;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.existingGame?.title ?? '');
    _developerController =
        TextEditingController(text: widget.existingGame?.developer ?? '');
    _ratingController =
        TextEditingController(text: widget.existingGame?.rating ?? '');
    _selectedGenre = widget.existingGame?.genre;
  }

  Future<void> _goToStep2() async {
    if (!_formKey.currentState!.validate()) return;

    final result = await Navigator.push<Game>(
      context,
      MaterialPageRoute(
        builder: (_) => GameFormStep2Screen(
          existingGame: widget.existingGame,
          title: _nameController.text.trim(),
          genre: _selectedGenre!,
          developer: _developerController.text.trim(),
          rating: _ratingController.text.trim(),
        ),
      ),
    );

    if (result != null && mounted) {
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        Expanded(
                          child: Text(
                            isEditing ? 'EDITAR JOGO' : 'CADASTRO DE JOGOS',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ValidatedInput(
                      label: 'Nome do Jogo',
                      controller: _nameController,
                      validator: (v) =>
                          FormValidators.requiredField(v, 'Nome do Jogo'),
                    ),
                    SelectableDropdownInput(
                      label: 'Gênero',
                      value: _selectedGenre,
                      items: GameOptions.genres,
                      hintText: 'Selecione o gênero',
                      onChanged: (value) =>
                          setState(() => _selectedGenre = value),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Selecione o gênero' : null,
                    ),
                    ValidatedInput(
                      label: 'Desenvolvedora',
                      controller: _developerController,
                      validator: (v) =>
                          FormValidators.requiredField(v, 'Desenvolvedora'),
                    ),
                    ValidatedInput(
                      label: 'Avaliação',
                      controller: _ratingController,
                      hintText: 'Ex: 9/10',
                      validator: (v) =>
                          FormValidators.requiredField(v, 'Avaliação'),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 170,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: _goToStep2,
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: const Text(
                            'PRÓXIMO',
                            style: TextStyle(fontSize: 19),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentPrimary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}