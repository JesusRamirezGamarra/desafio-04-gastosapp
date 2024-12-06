import 'package:flutter/material.dart';
import 'package:gastosappg10/models/gasto_model.dart';
import 'package:gastosappg10/utils/data_general.dart';

class ItemGastoWidget extends StatelessWidget {
  // Map<String, dynamic> gasto;
  final GastoModel gasto;
  final Function(GastoModel) onUpdate;
  final Function(GastoModel) onDelete;

  ItemGastoWidget({
    required this.gasto,
    required this.onUpdate,
    required this.onDelete,
    })  
  ;



  String _getImageForType(String typeName) {
    final type = types.firstWhere(
      (element) => element["name"] == typeName,
      orElse: () => {"image": "assets/images/otros.webp"},
    );
    return type["image"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: Text(
          gasto.title,
          // gasto["title"],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          //gasto.datetime,
          gasto.formattedDate,
          // gasto["datetime"] ?? "-",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        // trailing: Text(
        //   "S/ ${gasto.price}",
        //   // "S/ ${gasto["price"]}",
        //   style: TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "S/ ${gasto.price.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => onUpdate(gasto),
              child: Icon(Icons.edit, color: Colors.blue),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => onDelete(gasto),
              child: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),        
        leading: Image.asset(
          // type[gasto.type] ?? "assets/images/otros.webp",// default
          _getImageForType(gasto.type),
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
