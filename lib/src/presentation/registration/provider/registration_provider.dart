import 'package:hooks_riverpod/hooks_riverpod.dart';

final emailErrorProvider = StateProvider<String?>((ref) => null);
final passwordErrorProvider = StateProvider<String?>((ref) => null);
final isButtonEnabledProvider = StateProvider<bool>((ref) => false);

class RegistrationData {
  final String nama;
  final String email;
  final String nik;
  final String nomorAkses;

  RegistrationData({
    required this.nama,
    required this.email,
    required this.nik,
    required this.nomorAkses,
  });
}

/// **Provider untuk menyimpan data pendaftaran**
final registrationProvider =
    StateProvider<RegistrationData?>((ref) => null);
