import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// --- 1. Екран авторизації (LoginScreen) ---
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Authorization")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 100), // Замість Image.asset для прикладу
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: "Login")),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showDialog(context, "Logged in!"),
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const SignupScreen()));
              },
              child: const Text("Sign up"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const ResetPasswordScreen()));
              },
              child: const Text("Forgot password?"),
            )
          ],
        ),
      ),
    );
  }
}

// --- 2. Екран реєстрації (SignupScreen) ---
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(decoration: InputDecoration(labelText: "Full Name")),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(labelText: "Login")),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showDialog(context, "Registered!"),
              child: const Text("Register"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back to Login"),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 3. Екран відновлення паролю (ResetPasswordScreen) ---
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter your email to reset password"),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: "Email")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showDialog(context, "Reset link sent!"),
              child: const Text("Send Reset Link"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}

// Допоміжна функція для діалогів
void _showDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Message'),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))
      ],
    ),
  );
}