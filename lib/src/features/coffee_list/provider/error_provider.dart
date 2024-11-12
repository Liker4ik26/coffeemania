import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorNotifier extends StateNotifier<String?> {
  ErrorNotifier() : super(null);

  void setError(String error) => state = error;

  void resetError() => state = null;
}

final errorProvider =
    StateNotifierProvider<ErrorNotifier, String?>((ref) => ErrorNotifier());
