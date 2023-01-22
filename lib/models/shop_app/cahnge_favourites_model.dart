class ChangeFavouritesmodel {
  bool? status;
  String? message;

  ChangeFavouritesmodel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
