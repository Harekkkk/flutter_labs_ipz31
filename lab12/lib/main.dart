import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
	runApp(const MyApp());
}

const String requestCatcherUrl = 'https://ipz31-artem-lab12.requestcatcher.com';

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Lab 12 Dio',
			theme: ThemeData(
				colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
				useMaterial3: true,
				inputDecorationTheme: const InputDecorationTheme(
					border: OutlineInputBorder(),
					filled: true,
				),
			),
			home: const LoginScreen(),
		);
	}
}

mixin InputValidationMixin {
	bool isPasswordValid(String password) => password.length >= 7;
	bool isEmailValid(String email) {
		RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$');
		return regex.hasMatch(email);
	}
}

class LoginScreen extends StatefulWidget {
	const LoginScreen({super.key});

	@override
	State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with InputValidationMixin {
	final _formKey = GlobalKey<FormState>();
	final TextEditingController _loginController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();
	final Dio _dio = Dio();

	Future<void> _sendData() async {
		if (_formKey.currentState!.validate()) {
			try {
				await _dio.post(
					'$requestCatcherUrl/login',
					data: {
						'login': _loginController.text,
						'password': _passwordController.text,
					},
				);
				if (!mounted) return;
				ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(content: Text('Request sent to /login! Check browser.')),
				);
			} catch (e) {
				if (!mounted) return;
				ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(content: Text('Error: $e')),
				);
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text("Login (Lab 12)")),
			body: Padding(
				padding: const EdgeInsets.all(20.0),
				child: Form(
					key: _formKey,
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							TextFormField(
								controller: _loginController,
								decoration: const InputDecoration(labelText: "Email"),
								validator: (v) => isEmailValid(v ?? '') ? null : 'Enter valid email',
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: _passwordController,
								decoration: const InputDecoration(labelText: "Password"),
								obscureText: true,
								validator: (v) => isPasswordValid(v ?? '') ? null : 'Min 7 chars',
							),
							const SizedBox(height: 25),
							ElevatedButton(
								onPressed: _sendData,
								child: const Text("Login (Send Request)"),
							),
							const SizedBox(height: 10),
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									TextButton(
										onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen())),
										child: const Text("Sign Up"),
									),
									TextButton(
										onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResetPasswordScreen())),
										child: const Text("Reset Password"),
									),
								],
							)
						],
					),
				),
			),
		);
	}
}

class SignupScreen extends StatefulWidget {
	const SignupScreen({super.key});

	@override
	State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with InputValidationMixin {
	final _formKey = GlobalKey<FormState>();
	final TextEditingController _nameController = TextEditingController();
	final TextEditingController _loginController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();
	final Dio _dio = Dio();

	Future<void> _sendData() async {
		if (_formKey.currentState!.validate()) {
			try {
				await _dio.post(
					'$requestCatcherUrl/signup',
					data: {
						'name': _nameController.text,
						'login': _loginController.text,
						'password': _passwordController.text,
					},
				);
				if (!mounted) return;
				ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(content: Text('Request sent to /signup! Check browser.')),
				);
			} catch (e) {
				if (!mounted) return;
				ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(content: Text('Error: $e')),
				);
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text("Registration")),
			body: Padding(
				padding: const EdgeInsets.all(20.0),
				child: Form(
					key: _formKey,
					child: Column(
						children: [
							TextFormField(
								controller: _nameController,
								decoration: const InputDecoration(labelText: "Full Name"),
								validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: _loginController,
								decoration: const InputDecoration(labelText: "Email (Login)"),
								validator: (v) => isEmailValid(v ?? '') ? null : 'Invalid email',
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: _passwordController,
								decoration: const InputDecoration(labelText: "Password"),
								obscureText: true,
								validator: (v) => isPasswordValid(v ?? '') ? null : 'Min 7 chars',
							),
							const SizedBox(height: 25),
							ElevatedButton(
								onPressed: _sendData,
								child: const Text("Register (Send Request)"),
							),
							TextButton(
								onPressed: () => Navigator.pop(context),
								child: const Text("Back"),
							),
						],
					),
				),
			),
		);
	}
}

class ResetPasswordScreen extends StatefulWidget {
	const ResetPasswordScreen({super.key});

	@override
	State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with InputValidationMixin {
	final _formKey = GlobalKey<FormState>();
	final TextEditingController _loginController = TextEditingController();
	final Dio _dio = Dio();

	Future<void> _sendData() async {
		if (_formKey.currentState!.validate()) {
			try {
				await _dio.post(
					'$requestCatcherUrl/reset',
					data: {
						'login': _loginController.text,
					},
				);
				if (!mounted) return;
				ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(content: Text('Request sent to /reset! Check browser.')),
				);
			} catch (e) {
				if (!mounted) return;
				ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(content: Text('Error: $e')),
				);
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text("Reset Password")),
			body: Padding(
				padding: const EdgeInsets.all(20.0),
				child: Form(
					key: _formKey,
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							TextFormField(
								controller: _loginController,
								decoration: const InputDecoration(labelText: "Email"),
								validator: (v) => isEmailValid(v ?? '') ? null : 'Invalid email',
							),
							const SizedBox(height: 25),
							ElevatedButton(
								onPressed: _sendData,
								child: const Text("Send Reset Request"),
							),
							TextButton(
								onPressed: () => Navigator.pop(context),
								child: const Text("Back"),
							),
						],
					),
				),
			),
		);
	}
}