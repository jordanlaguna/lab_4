import 'package:flutter/material.dart';
import 'package:lab_4/Home/home.dart';
import 'package:lab_4/sql/database_helpeer.dart';

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
      home: LoginPage(),
      routes: {
        '/second': (context) => const Home(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

<<<<<<< Updated upstream
  @override
  Widget build(BuildContext context) {
=======
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final DatabaseHelper databaseHelper;
  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper(); // Inicializa la variable databaseHelper
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
>>>>>>> Stashed changes
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
<<<<<<< Updated upstream
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
=======
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Register a new account:',
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 10), // Espacio entre los campos
>>>>>>> Stashed changes
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
<<<<<<< Updated upstream
              TextFormField(
                obscureText: true,
=======
              const SizedBox(height: 10),
              TextFormField(
>>>>>>> Stashed changes
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
<<<<<<< Updated upstream
              ),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes realizar la lógica de inicio de sesión
                  print('Inicio de sesión');
                },
                child: const Text('Login'),
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
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
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
                onPressed: () {
                  // Aquí puedes realizar la lógica de registro
                  print('Registro');
                },
                child: const Text('Registro'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ya tienes una cuenta? Inicia sesión aquí'),
=======
                obscureText: true, // Para ocultar la contraseña
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
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
>>>>>>> Stashed changes
              ),
            ],
          ),
        ),
      ),
    );
  }
}
