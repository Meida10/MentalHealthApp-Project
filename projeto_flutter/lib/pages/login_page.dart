import 'package:flutter/material.dart';
import 'package:projeto_flutter/auth/auth_service.dart';
import 'package:projeto_flutter/components/my_button.dart';
import 'package:projeto_flutter/components/my_textfield.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      showErrorMessage(e.toString());
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              isDarkTheme
                  ? 'assets/LogotipoSaudeMentalBranco.png'
                  : 'assets/LogotipoSaudeMentalPreto.png',
              height: 300,
              width: 300,
            ),

            // Email Textfield
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),

            const SizedBox(height: 10),

            // Password Textfield
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10),

            // Esqueceste-te da palavra-passe
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Esqueceste-te da palavra-passe?',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Botão de Login
            MyButton(
              text: "Login",
              onTap: () => signUserIn(context),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Ou",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Se não tiveres conta
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Não tens conta?',
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Regista-te agora',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
