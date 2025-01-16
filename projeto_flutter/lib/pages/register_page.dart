import 'package:flutter/material.dart';
import 'package:projeto_flutter/auth/auth_service.dart';
import 'home_page.dart';
import 'package:projeto_flutter/components/my_button.dart';
import 'package:projeto_flutter/components/my_textfield.dart';
import 'psychologist_verifiy_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalityController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  String userRole = 'Utilizador Normal';
  final List<String> roles = ['Utilizador Normal', 'Psicólogo'];

  void signUserUp(BuildContext context) async {
    final auth = AuthService();

    if (passwordController.text == confirmPasswordController.text) {
      try {
        await auth.signUpWithEmailPassword(
          nameController.text,
          emailController.text,
          phoneController.text,
          nationalityController.text,
          dateOfBirthController.text,
          userRole,
          passwordController.text,
        );

        if (userRole == 'Psicólogo') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PsychologistVerificationPage(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      } on Exception catch (e) {
        showErrorMessage(e.toString());
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords não correspondem!"),
        ),
      );
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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

                // Name Textfield
                MyTextField(
                  controller: nameController,
                  hintText: 'Nome de Utilizador',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Email Textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Phone Textfield
                MyTextField(
                  controller: phoneController,
                  hintText: 'Número de Telemóvel',
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 10),

                // Nationality Textfield
                MyTextField(
                  controller: nationalityController,
                  hintText: 'Nacionalidade',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Date of Birth Textfield
                MyTextField(
                  controller: dateOfBirthController,
                  hintText: 'Data de Nascimento',
                  obscureText: false,
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      dateOfBirthController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },
                ),

                const SizedBox(height: 10),

                // Role Textfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 26.0), // Define o espaçamento
                      child: DropdownButton<String>(
                        value: userRole,
                        items: roles.map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (String? newRole) {
                          setState(() {
                            userRole = newRole!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Password Textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Confirmar Password Textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                // Botão de Registo
                MyButton(
                  text: "Criar Conta",
                  onTap: () => signUserUp(context),
                ),

                const SizedBox(height: 15),

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
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
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

                const SizedBox(height: 10),

                // Se já tiver conta
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Já tens conta?',
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Inicia sessão agora',
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
        ),
      ),
    );
  }
}
