class UserModel {
  final String userId;
  final String username;
  final String email;
  final String fullName;
  String photoUrl;
  final String createdAt;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.fullName,
    this.photoUrl = "",
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        "userId": this.userId,
        "username": this.username,
        "email": this.email,
        "fullName": this.fullName,
        "photoUrl": this.photoUrl,
        "createdAt": this.createdAt,
      };

  // factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   final snap = snapshot.data() as Map<String, dynamic>;

  //   return UserModel(
  //     userId: snap['userId'],
  //     username: snap['username'],
  //     email: snap['email'],
  //     fullName: snap['fullName'],
  //     createdAt: snap['createdAt'],
  //   );
  // }
}
