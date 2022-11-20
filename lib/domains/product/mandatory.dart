class Mandatory {
  String id;
  String name;
  String description;
  late String certMarkUrl;
  late String certificateNumber;

  Mandatory(this.id, this.name, this.description,
      {String? certMarkUrl, String? certificateNumber}) {
    this.certMarkUrl = certMarkUrl ?? '';
    this.certificateNumber = certificateNumber ?? '';
  }
}
