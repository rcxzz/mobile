import 'package:material_ui/material_ui.dart';
import '../models/user_account.dart';
import '../theme/app_theme.dart';
import '../utils/form_validators.dart';
import '../widgets/app_background.dart';
import '../widgets/validated_input.dart';
import 'home_catalog.dart';
import 'register_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  final List<UserAccount> _registeredUsers = [
    UserAccount(
      username: 'admin',
      name: 'Administrador',
      email: 'admin@jogos.com',
      phone: '42999999999',
      password: '123456',
    ),
  ];

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    final inputLogin = _loginController.text.trim();
    final inputPass = _passwordController.text;

    final userExists = _registeredUsers.any(
      (u) =>
          (u.email.toLowerCase() == inputLogin.toLowerCase() ||
              u.username.toLowerCase() == inputLogin.toLowerCase()) &&
          u.password == inputPass,
    );

    if (userExists) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeCatalogScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.danger,
          content: Text(
            'Usuário/Email ou senha inválidos! (Teste: admin / 123456)',
          ),
        ),
      );
    }
  }

  Future<void> _goToRegister() async {
    final newUser = await Navigator.push<UserAccount>(
      context,
      MaterialPageRoute(builder: (_) => const RegisterUserScreen()),
    );

    if (newUser != null) {
      setState(() {
        _registeredUsers.add(newUser);
        _loginController.text = newUser.email;
        _passwordController.text = newUser.password;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.success,
            content: Text('Cadastro realizado! Clique em ENTRAR.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        AppAssets.logo,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: AppColors.cardSurface,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.accentPrimary.withValues(alpha: 0.6),
                              width: 2.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.sports_esports_rounded,
                            size: 56,
                            color: AppColors.accentSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 36, letterSpacing: 2),
                    ),
                    const SizedBox(height: 26),
                    ValidatedInput(
                      label: 'Usuário / Email',
                      controller: _loginController,
                      hintText: 'admin ou admin@jogos.com',
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Informe o usuário ou e-mail';
                        }
                        if (v.contains('@')) {
                          return FormValidators.validateEmail(v);
                        }
                        if (v.trim().length < 3) {
                          return 'O usuário deve ter pelo menos 3 caracteres';
                        }
                        return null;
                      },
                    ),
                    ValidatedInput(
                      label: 'Senha',
                      controller: _passwordController,
                      obscureText: true,
                      hintText: '••••••',
                      validator: FormValidators.validatePassword,
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentPrimary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'ENTRAR',
                          style: TextStyle(fontSize: 22, letterSpacing: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _goToRegister,
                      child: const Text(
                        'Cadastre-se',
                        style: TextStyle(
                          fontSize: 19,
                          color: AppColors.accentSecondary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.accentSecondary,
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