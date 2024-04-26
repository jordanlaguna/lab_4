import 'package:flutter/material.dart';
import 'package:lab_4/Home/home.dart';
import 'package:lab_4/sql/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
      ),
      home: const LoginPage(),
      routes: {
        '/second': (context) => const Home(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthenticationService {
  Future<bool> login(String name, String password, String email) async {
    // Lógica real de autenticación utilizando la base de datos SQLite
    final DatabaseHelper databaseHelper = DatabaseHelper();
    final List<Map<String, dynamic>> user =
        await databaseHelper.loginUser(name, email, password);
    if (user.isNotEmpty) {
      // Si se encuentra un usuario con las credenciales proporcionadas, la autenticación es exitosa
      return true;
    } else {
      // Si no se encuentra ningún usuario, la autenticación falla
      return false;
    }
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationService authenticationService = AuthenticationService();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(31, 0, 13, 255),
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Registrar una nueva cuenta:',
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10), // Espacio entre los campos
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Obtener los valores ingresados por el usuario
                  String name = nameController.text;
                  String email = emailController.text;
                  String password = passwordController.text;

                  // Validar que los campos no estén vacíos
                  if (name.isNotEmpty &&
                      email.isNotEmpty &&
                      password.isNotEmpty) {
                    // Llamar al método login en authenticationService
                    bool authenticated = await authenticationService.login(
                        name, email, password);

                    // Verificar si la autenticación fue exitosa
                    if (authenticated) {
                      // Si la autenticación fue exitosa, puedes redirigir al usuario a la siguiente página
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, '/second');
                    } else {
                      // Si la autenticación falló, mostrar un mensaje de error al usuario
                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) {
                          const Color.fromARGB(1, 1, 94, 187);
                          return AlertDialog(
                            title: const Text('Error de inicio de sesión'),
                            content: const Text(
                                'Credenciales incorrectas. Por favor, inténtalo de nuevo.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    // Mostrar un mensaje si uno o ambos campos están vacíos
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Por favor, completa todos los campos.')),
                    );
                  }
                },
                child: const Text('Iniciar sesión'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text('No tienes una cuenta? Regístrate aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final DatabaseHelper databaseHelper; // Declaración aquí
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(31, 0, 13, 255),
        title: const Text('Registro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  databaseHelper =
                      DatabaseHelper(); // Inicializa la variable databaseHelper

                  int userId = await databaseHelper.registerUser(
                    nameController.text,
                    emailController.text,
                    passwordController.text,
                  );
                  print('User registered with ID: $userId');
                },
                child: const Text('Register'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: const Text('Go to Second Page'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ya tienes una cuenta? Inicia sesión aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
