import 'package:flutter/material.dart';
import 'package:projeto_flutter/auth/auth_service.dart';
import 'package:projeto_flutter/components/my_drawer.dart';
import 'package:projeto_flutter/services/chat/chat_service.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';

class ChatHomePage extends StatelessWidget {
  ChatHomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Chat Home Page"),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["name"] != null
            ? userData["name"].toString()
            : "Nome não disponível",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
