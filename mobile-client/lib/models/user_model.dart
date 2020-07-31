class User {
  String username;
  String email;
  String firstName;
  String lastName;
  String password;
  String confirmPassword;

  User(
      {this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.password,
      this.confirmPassword});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}
