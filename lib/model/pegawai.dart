class Pegawai {
  String? id;
  String namaPegawai;
  String? nip;
  String tanggalLahir;
  String nomorTelepon;
  String email;
  String? password;
  Pegawai(
      {this.id,
      this.nip,
      required this.namaPegawai,
      required this.tanggalLahir,
      required this.nomorTelepon,
      required this.email,
      this.password});

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
      id: json["id"],
      nip: json["nip"],
      namaPegawai: json["nama"],
      tanggalLahir: json["tanggal_lahir"],
      nomorTelepon: json["nomor_telepon"],
      email: json["email"],
      password: json["password"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": namaPegawai,
        "nip": nip,
        "tanggal_lahir": tanggalLahir,
        "nomor_telepon": nomorTelepon,
        "email": email,
        "password": password,
      };
}
