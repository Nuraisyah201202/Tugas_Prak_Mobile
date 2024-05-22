import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengguna'),
      ),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).fetchUserById(userId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan'));
          } else {
            return Consumer<UserProvider>(
              builder: (ctx, userProvider, _) {
                final user = userProvider.selectedUser;
                if (user == null) {
                  return Center(child: Text('Pengguna tidak ditemukan.'));
                } else {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                        SizedBox(height: 20),
                        Text('Nama: ${user.firstName} ${user.lastName}', style: TextStyle(fontSize: 20)),
                        SizedBox(height: 10),
                        Text('Email: ${user.email}', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
