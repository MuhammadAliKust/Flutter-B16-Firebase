import 'package:fltuter_b16/models/user.dart';
import 'package:fltuter_b16/services/auth.dart';
import 'package:fltuter_b16/services/user.dart';
import 'package:fltuter_b16/views/login.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(label: Text("Name")),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(label: Text("Phone")),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(label: Text("Address")),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(label: Text("Email")),
          ),
          TextField(
            controller: pwdController,
            decoration: InputDecoration(label: Text("Password")),
          ),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Name cannot be empty.")),
                      );
                      return;
                    }
                    if (phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Phone cannot be empty.")),
                      );
                      return;
                    }
                    if (addressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Address cannot be empty.")),
                      );
                      return;
                    }
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Email cannot be empty.")),
                      );
                      return;
                    }
                    if (pwdController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password cannot be empty.")),
                      );
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await AuthServices()
                          .registerUser(
                            email: emailController.text,
                            password: pwdController.text,
                          )
                          .then((user) async {
                            await UserServices()
                                .createUser(
                                  UserModel(
                                    docId: user.uid.toString(),
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    address: addressController.text,
                                    email: emailController.text,
                                    createdAt:
                                        DateTime.now().millisecondsSinceEpoch,
                                  ),
                                )
                                .then((val) {
                                  isLoading = false;
                                  setState(() {});
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Message"),
                                        content: Text(
                                          "User has been registered successfully",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginView(),
                                                ),
                                              );
                                            },
                                            child: Text("Okay"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                });
                          });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Register"),
                ),
        ],
      ),
    );
  }
}
