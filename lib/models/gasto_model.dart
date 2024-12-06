import 'package:intl/intl.dart';

class GastoModel {
  int? id; // El ID puede ser nulo al crear un nuevo gasto
  String title;
  double price;
  String datetime;
  String type;

  GastoModel({
    this.id, //opcional
    required this.title,
    required this.price,
    required this.datetime,
    required this.type,
  });

  factory GastoModel.fromDB(Map<String, dynamic> data) => GastoModel(
        id: data["id"], 
        title: data["title"],
        price: data["price"],
        datetime: data["datetime"],
        type: data["type"],
      );

  Map<String, dynamic> conertirAMap() => {
        if (id != null) 'id': id, 
        "title": title,
        "price": price,
        "datetime": datetime,
        "type": type,
      };

  String get formattedDate {
    try {
      DateTime parsedDate = DateTime.parse(datetime); // Parsear la fecha
      return DateFormat('yyyy-MM-dd').format(parsedDate); // Formatear
    } catch (e) {
      return datetime; // Si no se puede parsear, devolver el valor original
    }
  }      
}
