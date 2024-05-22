import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pengguna'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/user-form').then((_) {
                // Menyegarkan daftar pengguna setelah kembali dari form
                Provider.of<UserProvider>(context, listen: false).fetchUsers();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).fetchUsers(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan'));
          } else {
            return Consumer<UserProvider>(
              builder: (ctx, userProvider, _) {
                return ListView.builder(
                  itemCount: userProvider.users.length,
                  itemBuilder: (ctx, index) {
                    User user = userProvider.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/user-detail',
                          arguments: user.id,
                        );
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
