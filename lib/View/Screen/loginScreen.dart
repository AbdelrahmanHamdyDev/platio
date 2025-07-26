import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platio/Service/firebase.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key, this.initialSignIn = true});

  final bool initialSignIn;

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FireAuth fireAuth = FireAuth();

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  bool _obscurePassword = true;
  bool _isSignIn = true;

  @override
  void initState() {
    super.initState();
    _isSignIn = widget.initialSignIn;
  }

  void _toggleAuthMode() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final userName = _userNameController.text.trim();

      String? errorMessage;
      if (_isSignIn) {
        errorMessage = await fireAuth.loginWithEmail(
          email: email,
          password: password,
        );
      } else {
        errorMessage = await fireAuth.registerWithEmail(
          email: email,
          password: password,
          username: userName,
        );
      }

      if (errorMessage == null) {
        Navigator.pushReplacementNamed(context, '/menu');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final switchText =
        _isSignIn ? "Create a new account?" : "Already have an account?";
    final title =
        _isSignIn ? "Good to see you again" : "Create account to continue";
    final Botton_title = _isSignIn ? "Sign In" : "Sign Up";

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: GoogleFonts.cinzel(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 40),

                  if (!_isSignIn)
                    _buildTextField(
                      controller: _userNameController,
                      label: "Username",
                      prefix: const Icon(Icons.person),
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? "Enter username"
                                  : null,
                    ),

                  if (!_isSignIn) const SizedBox(height: 12),

                  // Email
                  _buildTextField(
                    controller: _emailController,
                    label: "Email",
                    keyboardType: TextInputType.emailAddress,
                    prefix: const Icon(Icons.email),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter your email"
                                : null,
                  ),

                  const SizedBox(height: 12),

                  // Password
                  _buildTextField(
                    controller: _passwordController,
                    label: "Password",
                    obscure: _obscurePassword,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter your password";
                      }
                      if (val.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    prefix: const Icon(Icons.lock_rounded),
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Submit button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: const Color(0xFFF25700),
                      foregroundColor: Colors.white,
                      textStyle: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _submit,
                    child: Text(Botton_title.toUpperCase()),
                  ),

                  // Toggle Sign In/Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(switchText, style: GoogleFonts.playfairDisplay()),
                      TextButton(
                        onPressed: _toggleAuthMode,
                        child: Text(
                          !_isSignIn ? "Sign In" : "Sign Up",
                          style: GoogleFonts.playfairDisplay(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    bool obscure = false,
    TextInputType? keyboardType,
    Widget? prefix,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
      validator: validator,
    );
  }
}
