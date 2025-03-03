# Product CRUD App

This is a Flutter application that implements a basic CRUD (Create, Read, Update, Delete) functionality for managing products using a `ProductController`.

## Features
- Add new products
- Update existing products
- Delete products
- Fetch and display products in a ListView

## Technologies Used
- Flutter
- Dart

## Getting Started
### Prerequisites
Ensure you have Flutter installed on your machine. You can check by running:
```sh
flutter --version
```
If Flutter is not installed, follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).

### Installation
1. Clone the repository:
   ```sh
   git clone <repository_url>
   ```
2. Navigate to the project directory:
   ```sh
   cd assignment_3
   ```
3. Get the dependencies:
   ```sh
   flutter pub get
   ```
4. Run the application:
   ```sh
   flutter run
   ```

## Code Structure
- **`Module13Class1Crud`**: A stateful widget that manages the UI and CRUD operations.
- **`ProductController`**: Handles fetching, creating, updating, and deleting products.
- **`productDialog`**: Displays a dialog to add or update products.
- **`fetchData`**: Fetches and updates the product list.
- **`ListView.builder`**: Renders the list of products.

## Usage
1. Click on the **➕ Floating Action Button** to add a new product.
2. Fill in the product details and click **Add Product**.
3. To update a product, click the **Edit (✏️) button** next to the product.
4. To delete a product, click the **Delete (🗑️) button**.

## Future Enhancements
- Implement a backend API for product storage.
- Add image upload functionality.
- Improve UI/UX with better styling and animations.

## License
This project is licensed under the MIT License.

