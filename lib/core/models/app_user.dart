class AppUser {
  final String uid;
  final String username;
  final String email;
  final String? phone;
  final String? pfp;

  AppUser({
    required this.uid,
    required this.username,
    required this.email,
    this.phone,
    this.pfp,
  });

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "username": username,
        "email": email,
        "phone": phone,
        "pfp": pfp,
      };

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map["uid"] ?? "",
      username: map["username"] ?? "User",
      email: map["email"] ?? "",
      phone: map["phone"] ?? "",
      pfp: map["pfp"],
    );
  }
}
