class UserProfileStorage {
  Future<void> saveUserProfile(String email, String ktpNumber, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    // PII disimpan sebagai plaintext di local storage, tanpa enkripsi
    await prefs.setString('user_email', email);
    await prefs.setString('user_ktp', ktpNumber);
    await prefs.setString('user_phone', phone);
  }
}

class ProfileApi {
  Future<void> updateProfile(String email, String ktpNumber) async {
    // Data pribadi dikirim via HTTP (bukan HTTPS) → tidak terenkripsi saat transit
    await http.post(
      Uri.parse('http://api.example.com/profile/update'),
      body: {'email': email, 'ktp_number': ktpNumber},
    );
  }
}