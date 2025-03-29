import 'package:flutter/material.dart';

class Addproducts extends StatefulWidget {
  const Addproducts({
    super.key,
    this.uploadimage,
    required this.currentstock,
    required this.layernumber,
    required this.name,
    required this.needstoberestock,
  });

  final TextEditingController name;
  final TextEditingController currentstock;
  final TextEditingController needstoberestock;
  final TextEditingController layernumber;
  final VoidCallback? uploadimage;

  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widget.name,
            decoration: InputDecoration(
              label: Text('name of the product'),
            ),
          ),
          TextField(
            controller: widget.layernumber,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text('layer number')),
          ),
          TextField(
            controller: widget.currentstock,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text('Initial Stock')),
          ),
          TextField(
            controller: widget.needstoberestock,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text('Need to resupply')),
          ),
          TextButton(
            onPressed: widget.uploadimage,
            child: Text('Image Type'),
          )
        ],
      ),
    );
  }
}
