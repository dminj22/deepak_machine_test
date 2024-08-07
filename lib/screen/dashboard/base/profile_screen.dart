import 'package:deepak_machine_test/provider/authentication_provider.dart';
import 'package:deepak_machine_test/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, provider, child) {
        if (provider.profile != null) {
          var data = provider.profile!.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: SizedBox(
                      width: 200,
                      height: 200,
                      child: CustomImage(
                          url: data!.avatar.toString(), radius: 20)),
                ),
                CustomTextFormField(
                  enabled: false,
                  label: "First Name",
                  controller: TextEditingController(text: data.firstName),
                ),
                CustomTextFormField(
                  enabled: false,
                  label: "Last Name",
                  controller: TextEditingController(text: data.lastName),
                ),
                CustomTextFormField(
                  enabled: false,
                  label: "Email",
                  controller: TextEditingController(text: data.email),
                ),
              ],
            ),
          );
        } else {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
              SizedBox(
                height: 10,
              ),
              Text("Loading Profile")
            ],
          );
        }
      },
    );
  }
}
