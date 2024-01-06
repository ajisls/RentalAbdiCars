// class customer {
//   String? id;
//   String namacustomer;
//   String email;
//   String phonenumber;
//   String address;

//   Poli({this.id, required this.namaPoli});
//   factory Poli.fromJson(Map<String, dynamic> json) =>
//       Poli(id: json["id"], namaPoli: json["nama_poli"]);
//   Map<String, dynamic> toJson() => {"nama_poli": namaPoli};
// }
class Customer {
  String? id;
  String namacustomer;
  String email;
  String phonenumber;
  String address;

  Customer({
    this.id,
    required this.namacustomer,
    required this.email,
    required this.phonenumber,
    required this.address,
  });
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
      namacustomer: json["namacustomer"],
      email: json["email"],
      phonenumber: json["phonenumber"],
      address: json["address"],
      id: json["id"]);
  Map<String, dynamic> toJson() => {
        "namacustomer": namacustomer,
        "email": email,
        "phonenumber": phonenumber,
        "address": address,
      };
}
