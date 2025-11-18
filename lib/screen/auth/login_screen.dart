import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginScreen extends StatelessWidget {
  final Function(BuildContext) onLoginSuccess;
  LoginScreen({required this.onLoginSuccess});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFFAF9CF3),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.asset(
                'assets/images/logo.jpg',
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                'Welcome\nCINEZONE',
                textAlign: TextAlign.center,
                style: GoogleFonts.lobster(
                  textStyle: TextStyle(
                      fontSize: 32,
                      letterSpacing: 2,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            blurRadius: 2,
                            color: Colors.grey.shade700,
                            offset: Offset(2, 2))
                      ]),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 350,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                    ),
                    SizedBox(height: 14),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Mật Khẩu",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          onLoginSuccess(context);
                        },
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Bạn Chưa có tài khoản?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SignUpScreen()),
                            );
                          },
                          child: Text("Đăng Ký",
                              style: TextStyle(color: Color(0xFF7760C6))),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final surnameController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool _isPasswordVisible = false;

    return Scaffold(
      backgroundColor: Color(0xFFAF9CF3),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.asset(
                'assets/images/logo.jpg',
                height: 80,
              ),
              SizedBox(height: 10),
              Text(
                'CINEZONE',
                style: GoogleFonts.lobster(
                  textStyle: TextStyle(
                      fontSize: 32,
                      letterSpacing: 2,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            blurRadius: 2,
                            color: Colors.grey.shade700,
                            offset: Offset(2, 2))
                      ]),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 350,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Đăng ký tài khoản",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(height: 18),
                    TextField(
                      controller: surnameController,
                      decoration: InputDecoration(
                        labelText: "Họ",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Tên",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Số điện thoại",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Gmail",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                    ),
                    SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          final userId = DateTime.now().millisecondsSinceEpoch.toString();
                          await FirebaseDatabase.instance.ref().child('users').child(userId).set({
                            'surname': surnameController.text,
                            'name': nameController.text,
                            'phone': phoneController.text,
                            'email': emailController.text,
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Đăng ký",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}