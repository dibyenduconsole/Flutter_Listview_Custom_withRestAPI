class EmployeeDtata{
  //Source source;
  var id;
  var email;
  var first_name;
  var last_name;
  var avatar;

  EmployeeDtata(
      {
      //this.source,
      this.id,
      this.email,
      this.first_name,
      this.last_name,
      this.avatar
      });

   EmployeeDtata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['avatar'] = this.avatar;
    return data;
  }

}