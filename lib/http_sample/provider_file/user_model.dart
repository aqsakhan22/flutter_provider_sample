class UserModel{

  final int id;
   String fname;
  final String email;
  final String lname;
  final String image;
  UserModel({required this.id, required this.fname, required this.email, required this.lname, required this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {

    return UserModel(
        id: json['id'],
        fname: json['firstName'],
        lname: json['lastName'],
        email: json['email'],
        image: json['image']
    );
  }
}