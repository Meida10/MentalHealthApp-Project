import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter/pages/chat_home_page.dart';
import 'package:projeto_flutter/pages/edit_profile_page.dart';
import 'package:projeto_flutter/pages/home_page.dart';
import 'package:projeto_flutter/pages/make_appoitment_page.dart';
import 'package:projeto_flutter/pages/see_apointments_page.dart';
import '../auth/auth_service.dart';
import '../pages/auth_page.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void signUserOut(BuildContext context) async {
    final auth = AuthService();
    auth.signOut();
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }

  Future<String?> getUserRoleFromFirestore() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();
      return userDoc.data()?['role'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("H O M E"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                ),
              ),
              const Divider(
                thickness: 2,
                indent: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: ListTile(
                  leading: const Icon(Icons.chat),
                  title: const Text("C H A T"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatHomePage(),
                      ),
                    );
                  },
                ),
              ),
              const Divider(
                thickness: 2,
                indent: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("P R O F I L E"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfilePage(),
                      ),
                    );
                  },
                ),
              ),
              const Divider(
                thickness: 2,
                indent: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: FutureBuilder<String?>(
                  future: getUserRoleFromFirestore(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }
                    if (snapshot.hasData &&
                        snapshot.data == 'Utilizador Normal') {
                      return ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: const Text("C O N S U L T A S"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ScheduleAppointmentPage(),
                            ),
                          );
                        },
                      );
                    }
                    if (snapshot.hasData && snapshot.data == 'Psicólogo') {
                      return ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: const Text("M A R C A Ç Õ E S"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SeeAppointmentsPage(),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 230.0),
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("S E T T I N G S"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              onTap: () {
                signUserOut(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
