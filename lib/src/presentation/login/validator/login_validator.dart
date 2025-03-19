    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return "Email harus diisi";
      }
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
      if (!emailRegex.hasMatch(value)) {
        return "Format email tidak benar";
      }
      return null;
    }

    /// **Fungsi Validasi Password**
    String? validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return "Kata sandi harus diisi";
      }
      return null;
    }