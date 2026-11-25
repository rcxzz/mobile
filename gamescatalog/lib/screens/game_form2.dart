import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:material_ui/material_ui.dart';
import '../models/game.dart';
import '../theme/app_theme.dart';
import '../utils/form_validators.dart';
import '../widgets/app_background.dart';
import '../widgets/selectable_dropdown_input.dart';
import '../widgets/validated_input.dart';

class GameFormStep2Screen extends StatefulWidget {
  final Game? existingGame;
  final String title;
  final String genre;
  final String developer;
  final String rating;

  const GameFormStep2Screen({
    super.key,
    this.existingGame,
    required this.title,
    required this.genre,
    required this.developer,
    required this.rating,
  });

  @override
  State<GameFormStep2Screen> createState() => _GameFormStep2ScreenState();
}

class _GameFormStep2ScreenState extends State<GameFormStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _ageRatingController;
  late final TextEditingController _releaseDateController;
  String? _selectedPlatform;
  late String _selectedFileLabel;
  Uint8List? _selectedImageBytes;

  bool get isEditing => widget.existingGame != null;

  @override
  void initState() {
    super.initState();
    _ageRatingController =
        TextEditingController(text: widget.existingGame?.ageRating ?? '');
    _releaseDateController =
        TextEditingController(text: widget.existingGame?.releaseDate ?? '');
    _selectedPlatform = widget.existingGame?.platform;
    _selectedFileLabel =
        widget.existingGame?.imageLabel ?? 'Carregar Arquivo ...';
    _selectedImageBytes = widget.existingGame?.imageBytes;
  }

  Future<void> _pickImageFromComputer() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      if (file.bytes != null) {
        setState(() {
          _selectedImageBytes = file.bytes;
          _selectedFileLabel = file.name;
        });
      }
    }
  }

  void _saveGame() {
    if (!_formKey.currentState!.validate()) return;

    if (isEditing) {
      widget.existingGame!
        ..title = widget.title
        ..genre = widget.genre
        ..developer = widget.developer
        ..rating = widget.rating
        ..ageRating = _ageRatingController.text.trim()
        ..releaseDate = _releaseDateController.text.trim()
        ..platform = _selectedPlatform!
        ..imageLabel = _selectedFileLabel
        ..imageBytes = _selectedImageBytes;

      Navigator.pop(context, widget.existingGame!);
    } else {
      final createdGame = Game(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: widget.title,
        genre: widget.genre,
        developer: widget.developer,
        rating: widget.rating,
        ageRating: _ageRatingController.text.trim(),
        releaseDate: _releaseDateController.text.trim(),
        platform: _selectedPlatform!,
        imageLabel: _selectedFileLabel,
        imageBytes: _selectedImageBytes,
      );

      Navigator.pop(context, createdGame);
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
                      label: 'Faixa Etária',
                      controller: _ageRatingController,
                      hintText: 'Ex: 18 anos ou Livre',
                      validator: (v) =>
                          FormValidators.requiredField(v, 'Faixa Etária'),
                    ),
                    ValidatedInput(
                      label: 'Data de Lançamento',
                      controller: _releaseDateController,
                      keyboardType: TextInputType.datetime,
                      hintText: 'DD/MM/AAAA',
                      validator: FormValidators.validateDate,
                    ),
                    SelectableDropdownInput(
                      label: 'Plataforma',
                      value: _selectedPlatform,
                      items: GameOptions.platforms,
                      hintText: 'Selecione a plataforma',
                      onChanged: (value) =>
                          setState(() => _selectedPlatform = value),
                      validator: (v) => v == null || v.isEmpty
                          ? 'Selecione a plataforma'
                          : null,
                    ),
                    const Text(
                      'Upload Imagem',
                      style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _pickImageFromComputer,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        height: 82,
                        decoration: BoxDecoration(
                          color: AppColors.inputFill,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.accentPrimary.withValues(alpha: 0.5),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload_outlined,
                              size: 30,
                              color: AppColors.accentSecondary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _selectedFileLabel,
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 130,
                        height: 62,
                        child: ElevatedButton(
                          onPressed: _saveGame,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentPrimary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Icon(Icons.check_rounded, size: 36),
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