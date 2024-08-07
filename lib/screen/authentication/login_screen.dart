import 'package:deepak_machine_test/provider/authentication_provider.dart';
import 'package:deepak_machine_test/util/validator.dart';
import 'package:deepak_machine_test/util/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "eve.holt@reqres.in");
  final passwordController = TextEditingController(text: "cityslicka");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              CustomTextFormField(
                label: "Email",
                controller: emailController,
                validator: emailValidator,
              ),
              CustomTextFormField(
                label: "Password",
                controller: passwordController,
                validator: passwordValidator,
              ),
              const SizedBox(
                height: 50,
              ),
              Consumer<AuthenticationProvider>(
                builder: (context, provider, child) {
                  return !provider.loginLoading
                      ? ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              provider.userLogin(context,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: const Text("Login"))
                      : const Center(child: CircularProgressIndicator());
                },
              ),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Or"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              Consumer<AuthenticationProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                      onPressed: () {
                        //Java home is not configured in System so cant take SHA key
                        //google signin wont work properly
                        provider.googleLogin(context);
                      },
                      child: Text("Login with Google"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
