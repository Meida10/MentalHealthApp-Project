import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  String name = '';
  String email = '';
  String phone = '';
  String nationality = '';
  String dateOfBirth = '';
  bool isEditing = false;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController nationalityController;
  late TextEditingController dateOfBirthController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    nationalityController = TextEditingController();
    dateOfBirthController = TextEditingController();

    fetchUserData();
  }

  void fetchUserData() async {
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .get();

      setState(() {
        name = userDoc.data()?['name'] ?? 'Nome de Utilizador';
        email = userDoc.data()?['email'] ?? user!.email!;
        phone = userDoc.data()?['phone'] ?? 'Número de Telemóvel';
        nationality = userDoc.data()?['nationality'] ?? 'Nacionalidade';
        dateOfBirth = userDoc.data()?['dateofbirth'] ?? 'Data de Nascimento';

        nameController.text = name;
        emailController.text = email;
        phoneController.text = phone;
        nationalityController.text = nationality;
        dateOfBirthController.text = dateOfBirth;
      });
    }
  }

  void saveUserData() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .update({
        'name': name,
        'email': email,
        'phone': phone,
        'nationality': nationality,
        'dateofbirth': dateOfBirth,
      });
      setState(() {
        isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nome',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    enabled: isEditing,
                    controller: nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onChanged: (value) => setState(() {
                      name = value;
                    }),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    readOnly: !isEditing,
                    controller: emailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (value) => setState(() {
                      email = value;
                    }),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Número de Telemóvel',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    enabled: isEditing,
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onChanged: (value) => setState(() {
                      phone = value;
                    }),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nacionalidade',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    enabled: isEditing,
                    controller: nationalityController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onChanged: (value) => setState(() {
                      nationality = value;
                    }),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: !isEditing,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data de Nascimento',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          enabled: false,
                          controller: dateOfBirthController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                width: 2.0,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                width: 2.0,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          onChanged: (value) => setState(() {
                            dateOfBirth = value;
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: isEditing
                    ? saveUserData
                    : () => setState(() {
                          isEditing = true;
                        }),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    width: 2.0,
                  ),
                ),
                child: Text(isEditing ? 'Salvar' : 'Editar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
