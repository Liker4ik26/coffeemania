abstract interface class SharedPreferencesRepository {
  const SharedPreferencesRepository();

  Future<void> saveAddress(String address);

  Future<String?> loadAddress();
}
