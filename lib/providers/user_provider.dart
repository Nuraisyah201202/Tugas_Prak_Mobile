import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<User> _users = [];
  User? _selectedUser;

  List<User> get users => _users;
  User? get selectedUser => _selectedUser;

  Future<void> fetchUsers() async {
    _users = await _apiService.getUsers();
    notifyListeners();
  }

  Future<void> fetchUserById(int id) async {
    _selectedUser = await _apiService.getUserById(id);
    notifyListeners();
  }

  Future<void> addUser(String name, String job) async {
    await _apiService.createUser(name, job);
    await fetchUsers();
  }
}
