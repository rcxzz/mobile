import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import '../models/user_account.dart';
import '../theme/app_theme.dart';
import '../utils/form_validators.dart';
import '../widgets/app_background.dart';
import '../widgets/validated_input.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) return;

    final user = UserAccount(
      username: _usernameController.text.trim(),
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
    );

    Navigator.pop(context, user);
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
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'CADASTRO',
                              style: TextStyle(fontSize: 32, letterSpacing: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 18),
                    ValidatedInput(
                      label: 'Usuário',
                      controller: _usernameController,
                      hintText: 'Ex: jogador01',
                      validator: (v) {
                        if (v == null || v.trim().length < 3) {
                          return 'O usuário deve ter no mínimo 3 caracteres';
                        }
                        return null;
                      },
                    ),
                    ValidatedInput(
                      label: 'Nome',
                      controller: _nameController,
                      hintText: 'Nome completo',
                      validator: (v) => FormValidators.requiredField(v, 'Nome'),
                    ),
                    ValidatedInput(
                      label: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'exemplo@email.com',
                      validator: FormValidators.validateEmail,
                    ),
                    ValidatedInput(
                      label: 'Telefone (DDD + Número)',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      hintText: 'Ex: 42999998888',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      validator: FormValidators.validatePhone,
                    ),
                    ValidatedInput(
                      label: 'Senha',
                      controller: _passwordController,
                      obscureText: true,
                      hintText: 'Mínimo 6 caracteres',
                      validator: FormValidators.validatePassword,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 210,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentPrimary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'AVANÇAR',
                          style: TextStyle(fontSize: 21, letterSpacing: 1.2),
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