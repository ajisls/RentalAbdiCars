class Mobil {
  String? id;
  String merekMobil;
  String modelMobil;
  String warnaMobil;
  String hargaSewa;
  String tahunMobil;
  String tersedia;
  Mobil({
    this.id,
    required this.merekMobil,
    required this.modelMobil,
    required this.warnaMobil,
    required this.hargaSewa,
    required this.tahunMobil,
    required this.tersedia,
  });
  factory Mobil.fromJson(Map<String, dynamic> json) => Mobil(
      merekMobil: json["merek"],
      modelMobil: json["model"],
      warnaMobil: json["warna"],
      hargaSewa: json["hargasewaperhari"],
      tahunMobil: json["tahun"],
      tersedia: json["tersedia"],
      id: json["id"]);
  Map<String, dynamic> toJson() => {
        "model": modelMobil,
        "merek": merekMobil,
        "warna": warnaMobil,
        "hargasewaperhari": hargaSewa,
        "tahun": tahunMobil,
        "tersedia": tersedia,
      };
}
