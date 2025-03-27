import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:theisi_app/front%20_end_app/componets/addproduct.dart';

import 'package:theisi_app/front%20_end_app/componets/listforproduct.dart';
import 'package:theisi_app/front%20_end_app/models/modeldata.dart';
import 'package:theisi_app/service/database.dart';

class Analyticspage extends StatefulWidget {
  const Analyticspage({super.key});

  @override
  State<Analyticspage> createState() => _AnalyticspageState();
}

class _AnalyticspageState extends State<Analyticspage> {
  Databaseservices dbservice = Databaseservices();
  String? dropdownvalue;
  List<String> sortby = [
    'Name',
    'Quantity',
    'Layer',
  ];

  List<bool> bottonshow = [];
  List<Modeldataforproducts> filtered = [];
  List<Modeldataforproducts> products = [];

  final TextEditingController controller = TextEditingController();
  final TextEditingController addname = TextEditingController();
  final TextEditingController stocklvel = TextEditingController();
  final TextEditingController needtobestock = TextEditingController();
  final TextEditingController layernumber = TextEditingController();

  void fetchData() {
    dbservice.getProducts().listen((snapshot) {
      List<Modeldataforproducts> tempList = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        tempList.add(
          Modeldataforproducts(
            id: doc.id, // Firestore document ID
            name: data['name'] ?? '',
            resupply: data['restockvalue'] ?? 0,
            total: data['initalStock'] ?? 0,
            layer: data['layernumber'] ?? 0,
          ),
        );
      }

      setState(() {
        products = tempList;
        filtered = List.from(products);

        bottonshow = List.generate(filtered.length, (index) => false);
      });
    });
  }

  void deletefunction(docid) async {
    dbservice.deleteproducts(docid);
  }

  void _addProduct() {
    setState(() {
      int stock = int.tryParse(stocklvel.text) ?? 0;
      int resupply = int.tryParse(needtobestock.text) ?? 0;
      int layer = int.tryParse(layernumber.text) ?? 0;

      dbservice.addproducts(addname.text, layer, resupply, stock);

      // Clear input fields
      addname.clear();
      stocklvel.clear();
      needtobestock.clear();
      layernumber.clear();
    });
  }

  Future<void> confirmationdelete(docid) async {
    return showDialog(
        context: context,
        builder: (
          context,
        ) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure you want to delete this product?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  deletefunction(docid);
                  print('delete');
                },
                child: Text('Confirm'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  void fitlerfunction(String value) {
    setState(() {
      List<Modeldataforproducts> tempList = products
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();

      if (tempList.isNotEmpty) {
        filtered = tempList;
        bottonshow = List.generate(filtered.length, (index) => false);
      }
    });
  }

  Future<void> editfunction(index, docid) {
    final TextEditingController newname = TextEditingController();
    final TextEditingController newlayernum = TextEditingController();
    final TextEditingController newstock = TextEditingController();
    final TextEditingController stockstatus = TextEditingController();
    // final String editname = name;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Addproducts(
                currentstock: newstock,
                layernumber: newlayernum,
                name: newname,
                needstoberestock: stockstatus),
            actions: [
              TextButton(
                onPressed: () {
                  dbservice.updateproduct(
                      docid,
                      newname.text,
                      int.tryParse(newlayernum.text) ?? 0,
                      int.tryParse(newstock.text) ?? 0,
                      int.tryParse(stockstatus.text) ?? 0);
                  Navigator.pop(context);
                },
                child: Text('Save changes'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    filtered = products;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenwitdh = MediaQuery.of(context).size.width;
    // double screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF2C2E31),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              color: Color(0xFF2D3641),
              child: Row(
                children: [
                  Text(
                    'Inventory Status',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(5),
                        // width: 250, // Adjusted width
                        child: TextFormField(
                          onChanged: (value) {
                            fitlerfunction(value);
                          },
                          enableSuggestions: true,
                          controller: controller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'search for a product',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton2(
                          value: dropdownvalue,
                          buttonStyleData: ButtonStyleData(
                            width: screenwitdh * .30,
                            height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          hint: Text(
                            'Sort by',
                            style: TextStyle(fontSize: 10),
                          ),
                          dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              offset: Offset(0, -10)),
                          onChanged: (value) => {
                                setState(() {
                                  dropdownvalue = value;
                                }),
                              },
                          items: sortby
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ))
                              .toList()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Container(
                              width: screenwitdh * .15,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: screenwitdh * .15,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Resupply',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        for (int i = 0; i < filtered.length; i++) {
                          bottonshow[i] = (i == index) ? !bottonshow[i] : false;
                        }
                      });
                    },
                    child: ProductList(
                      nameOfProduct: filtered[index].name,
                      quantityOfProduct: filtered[index].total,
                      restockOfProduct: filtered[index].resupply,
                      layernumber: filtered[index].layer,
                      edit: () async => editfunction(index, filtered[index].id),
                      showbotton: bottonshow[index],
                      delete: () async =>
                          confirmationdelete(filtered[index].id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add a product'),
              content: Addproducts(
                currentstock: stocklvel,
                layernumber: layernumber,
                name: addname,
                needstoberestock: needtobestock,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _addProduct();
                    Navigator.pop(context);
                  },
                  child: Text('submit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('close'),
                )
              ],
            ),
          );
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
