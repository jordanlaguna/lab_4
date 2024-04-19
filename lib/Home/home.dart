import 'package:flutter/material.dart';
import 'package:lab_4/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> productos = [
    'Coca-cola',
    'Hamburguesa',
    'Papas',
    'Pollo',
    'Pizza'
  ];
  List<String> productosGuardados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Combo'),
        backgroundColor: const Color.fromARGB(255, 95, 222, 99),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyApp()));
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '¡Bienvenido!',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 40.0),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        producto,
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          _saveData(producto);
                        },
                        child: const Text('Agregar'),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                _loadData();
              },
              child: const Text('Cargar Datos'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Productos Guardados:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 10,
              children: productosGuardados.map((producto) {
                return Chip(
                  label: Text(producto),
                  deleteButtonTooltipMessage: 'Eliminar $producto',
                  onDeleted: () {
                    _removeData(
                        producto); // Llama a la función para eliminar el producto
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _removeData(String producto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    productosGuardados.remove(producto); // Elimina el producto de la lista
    prefs.setStringList('productos_guardados',
        productosGuardados); // Actualiza SharedPreferences
    setState(() {}); // Actualiza la interfaz de usuario
    print('Producto eliminado: $producto');
  }

  void _saveData(String producto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    productosGuardados.add(producto);
    prefs.setStringList('productos_guardados', productosGuardados);
    setState(() {});
    print('Producto guardado: $producto');
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList('productos_guardados');
    if (data != null) {
      setState(() {
        productosGuardados = data;
      });
      print('Productos cargados: $data');
    } else {
      print('No se encontró ningún dato.');
    }
  }
}
