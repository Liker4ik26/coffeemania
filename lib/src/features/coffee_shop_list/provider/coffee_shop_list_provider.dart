import 'package:coffee_mania/di/injectable.dart';
import 'package:coffee_mania/src/shared_preferences/shared_preferences_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sharedPreferencesProvider = Provider<SharedPreferencesRepository>((ref) {
  return getIt<SharedPreferencesRepository>();
});
final addressProvider = FutureProvider<String?>((ref) async {
  final sharedPreferencesRepository = ref.watch(sharedPreferencesProvider);
  return sharedPreferencesRepository.loadAddress();
});

final addressNotifierProvider =
    StateNotifierProvider<AddressNotifier, String?>((ref) {
  return AddressNotifier(ref.watch(sharedPreferencesProvider));
});

class AddressNotifier extends StateNotifier<String?> {
  AddressNotifier(this.sharedPreferencesRepository) : super(null);
  final SharedPreferencesRepository sharedPreferencesRepository;

  Future<void> saveAddress(String address) async {
    await sharedPreferencesRepository.saveAddress(address);
    state = address;
  }

  Future<void> loadAddress() async {
    final address = await sharedPreferencesRepository.loadAddress();
    state = address;
  }
}
