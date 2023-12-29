class UserModel {
  final String userId;
  final String username;
  final String email;
  final String fullName;

  final String createdAt;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.fullName,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        "userId": this.userId,
        "username": this.username,
        "email": this.email,
        "fullName": this.fullName,
        "createdAt": this.createdAt,
      };

  factory UserModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return UserModel(
      userId: snapshot['userId'],
      username: snapshot['username'],
      email: snapshot['email'],
      fullName: snapshot['fullName'],
      createdAt: snapshot['createdAt'],
    );
  }
}
