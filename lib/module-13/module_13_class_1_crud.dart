import 'package:assignment_3/module-13/product_controller.dart';
import 'package:assignment_3/module-13/widget/product_card.dart';
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
    TextEditingController productQuantityController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    productNameController.text = name ?? '';
    productQuantityController.text = qty != null ? qty.toString() : '0';
    productImageController.text = img ?? '';
    productUnitPriceController.text = unitPrice != null ? unitPrice.toString() : '0';
    productTotalPriceController.text = totalPrice != null ? totalPrice.toString() : '0';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white
                  ),

                  onPressed: () async {
                    if (id == null) {
                      await productController.createProduct(
                        productNameController.text,
                        productImageController.text,
                        int.parse(productQuantityController.text),
                        int.parse(productUnitPriceController.text),
                        int.parse(productTotalPriceController.text),
                      );
                    } else {
                      await productController.updateProduct(
                        id,
                        productNameController.text,
                        productImageController.text,
                        int.parse(productQuantityController.text),
                        int.parse(productUnitPriceController.text),
                        int.parse(productTotalPriceController.text),
                      );
                    }
                    await fetchData();
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Text(id == null ? "Add Products" : "Update Product"),
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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(title: const Text("Products")),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.6),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            var product = productController.products[index];
            return ProductCard(
              product: product,
              onEdit: () => productDialog(
                id: product.sId,
                name: product.productName,
                img: product.img,
                qty: product.qty,
                unitPrice: product.unitPrice,
                totalPrice: product.totalPrice,
              ),
              onDelete: () {
                productController.deleteProducts(product.sId.toString()).then((value) {
                  if (value) {
                    fetchData();
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