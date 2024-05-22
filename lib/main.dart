import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'providers/user_provider.dart';
import 'screens/user_list_screen.dart';
import 'screens/user_detail_screen.dart';
import 'screens/user_form_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<bool> _isLoggedIn() async {
    String? token = await _storage.read(key: 'token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'User Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: _isLoggedIn(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasData && snapshot.data == true) {
              return UserListScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
        routes: {
          '/user-list': (ctx) => UserListScreen(),
          '/user-detail': (ctx) => UserDetailScreen(),
          '/user-form': (ctx) => UserFormScreen(),
        },
      ),
    );
  }
}
