import 'package:coffee_mania/src/shared_preferences/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  SharedPreferencesRepositoryImpl(this.preferences);

  final SharedPreferences preferences;

  @override
  Future<void> saveAddress(String address) async {
    await preferences.setString('address', address);
  }

  @override
  Future<String?> loadAddress() async {
    return preferences.getString('address');
  }
}
