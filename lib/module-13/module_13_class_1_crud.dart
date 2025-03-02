import 'package:assignment_3/module-13/product_controller.dart';
import 'package:flutter/material.dart';


class Module13Class1Crud extends StatefulWidget {
  const Module13Class1Crud({super.key});

  @override
  State<Module13Class1Crud> createState() => _Module13Class1CrudState();
}

class _Module13Class1CrudState extends State<Module13Class1Crud> {
  final ProductController productController = ProductController();

  void productDialog() {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productCodeController = TextEditingController();
    TextEditingController productQuantityController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add Products"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                    ),
                  ),

                  TextField(
                    controller: productImageController,
                    decoration: InputDecoration(
                      labelText: 'Product Image',
                    ),
                  ),
                  TextField(
                    controller: productQuantityController,
                    decoration: InputDecoration(
                      labelText: 'Product Quantity',
                    ),
                  ),
                  TextField(
                    controller: productUnitPriceController,
                    decoration: InputDecoration(
                      labelText: 'Product Unit Price',
                    ),
                  ),
                  TextField(
                    controller: productTotalPriceController,
                    decoration: InputDecoration(
                      labelText: 'Total Price',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close')),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              productController.createProducts(productNameController.text, productImageController.text, int.parse(productQuantityController.text), int.parse(productUnitPriceController.text), int.parse(productTotalPriceController.text));
                              fetchData();
                              Navigator.pop(context);
                            });

                          }, child: Text('Add Product')),
                    ],
                  )
                ],
              ),
            ));
  }

  Future<void> fetchData() async {
    await productController.fetchProducts();
    print(productController.products.length);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
        ),
        body: ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              var products = productController.products[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  // leading: Image.network(
                  //   products['Img'],
                  //   width: 150,
                  //   fit: BoxFit.contain,
                  // ),
                  title: Text(
                    products.productName.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Price: \$ ${products.unitPrice} | Quantity: ${products.qty}\nTotal Price: ${products.totalPrice}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () => productDialog(),
                          icon: Icon(Icons.edit)),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => productDialog(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
