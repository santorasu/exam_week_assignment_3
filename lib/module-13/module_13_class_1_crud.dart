import 'package:assignment_3/module-13/product_controller.dart';
import 'package:flutter/material.dart';

class Module13Class1Crud extends StatefulWidget {
  const Module13Class1Crud({super.key});

  @override
  State<Module13Class1Crud> createState() => _Module13Class1CrudState();
}

class _Module13Class1CrudState extends State<Module13Class1Crud> {
  final ProductController productController = ProductController();

  void productDialog({
    String? id,
    String? name,
    int? qty,
    String? img,
    int? unitPrice,
    int? totalPrice,
  }) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productCodeController = TextEditingController();
    TextEditingController productQuantityController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    productNameController.text = name ?? '';
    productQuantityController.text = qty != null ? qty.toString() : '0';
    productImageController.text = img ?? '';
    productUnitPriceController.text = unitPrice.toString() ?? '0';
    productTotalPriceController.text = totalPrice.toString() ?? '0';
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(id == null ? "Add Products" : "Update Product"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: productNameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                ),

                TextField(
                  controller: productImageController,
                  decoration: InputDecoration(labelText: 'Product Image'),
                ),
                TextField(
                  controller: productQuantityController,
                  decoration: InputDecoration(labelText: 'Product Quantity'),
                ),
                TextField(
                  controller: productUnitPriceController,
                  decoration: InputDecoration(labelText: 'Product Unit Price'),
                ),
                TextField(
                  controller: productTotalPriceController,
                  decoration: InputDecoration(labelText: 'Total Price'),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Close'),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {
                        if (id == null) {
                          productController.createProduct(
                            productNameController.text,
                            productImageController.text,
                            int.parse(productQuantityController.text),
                            int.parse(productUnitPriceController.text),
                            int.parse(productTotalPriceController.text),
                          );
                        } else {
                          productController.updateProduct(
                            id,
                            productNameController.text,
                            productImageController.text,
                            int.parse(productQuantityController.text),
                            int.parse(productUnitPriceController.text),
                            int.parse(productTotalPriceController.text),
                          );
                        }

                        fetchData();
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Text(
                        id == null ? "Add Products" : "Update Product",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
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
        appBar: AppBar(title: const Text("Products")),
        body: ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            var product = productController.products[index];
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
                  product.productName.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Price: \$ ${product.unitPrice} | Quantity: ${product.qty}\nTotal Price: ${product.totalPrice}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed:
                          () => productDialog(
                            id: product.sId,
                            name: product.productName,
                            img: product.img,
                            unitPrice: product.unitPrice,
                            totalPrice: product.totalPrice,
                          ),
                      icon: Icon(Icons.edit),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {

                          productController
                              .deleteProducts(product.sId.toString())
                              .then((value) {
                                if (value) {
                                  setState(() {
                                    fetchData();
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Product Deleted"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please try again.."),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              });
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => productDialog(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
