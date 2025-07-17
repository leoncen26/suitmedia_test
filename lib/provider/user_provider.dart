import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier{
  String _name = '';
  String _selectedUser = '';

  String get name => _name;
  String get selectedUser => _selectedUser;

  void setName(String newName){
    _name = newName;
    notifyListeners();
  }

  void setSelectedName(String newName){
    _selectedUser = newName;
    notifyListeners();
  }
}