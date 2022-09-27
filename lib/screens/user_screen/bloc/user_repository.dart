import 'package:rick_and_morty/screens/user_screen/bloc/user_provider.dart';

import '../../../models/user_model.dart';

class Repository {
  Provider provider = Provider();

  Future<List<UserModel>> getUsers() {
    return provider.getUsers();
  }

  Future<UserModel> getUser(String id) {
    return provider.getUser(id);
  }
}
