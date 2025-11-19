import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_team/screen/home/movie_homepage.dart';
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
// Tham chiếu đến Firebase Authentication và Firestore
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

@override
Widget build(BuildContext context) {
  // Controllers cho form
  final surnameController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // Trạng thái hiển thị mật khẩu
  bool _isPasswordVisible = false;

  return Scaffold(
    backgroundColor: const Color(0xFFAF9CF3),
    body: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset(
              'assets/images/logo.jpg',
              height: 80,
            ),
            const SizedBox(height: 10),
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
                          offset: const Offset(2, 2))
                    ]),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 350,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Đăng ký tài khoản",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(height: 18),
                  // --- Họ ---
                  TextField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      labelText: "Họ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // --- Tên ---
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Tên",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // --- Số điện thoại ---
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Số điện thoại",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  // --- Email ---
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Gmail",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // --- Mật khẩu ---
                  TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      // ⭐ LOGIC ĐĂNG KÝ VÀ LƯU VÀO FIRESTORE
                      onPressed: () async {
                        // Kiểm tra các trường cơ bản
                        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Vui lòng nhập đầy đủ Email và Mật khẩu.')),
                          );
                          return;
                        }

                        try {
                          // 1. TẠO TÀI KHOẢN VỚI AUTH
                          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );

                          // Lấy UID (ID duy nhất)
                          String uid = userCredential.user!.uid;

                          // 2. LƯU THÔNG TIN CÁ NHÂN VÀO FIRESTORE
                          await _firestore.collection('users').doc(uid).set({
                            'surname': surnameController.text.trim(),
                            'name': nameController.text.trim(),
                            'phone': phoneController.text.trim(),
                            'email': emailController.text.trim(),
                            'createdAt': FieldValue.serverTimestamp(),
                          });

                          // 3. THÔNG BÁO VÀ CHUYỂN HƯỚNG
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Đăng ký tài khoản thành công!')),
                          );

                          Navigator.pushReplacement(
                            context,
                            // ⭐ Lưu ý: Cần truyền hàm toggleTheme nếu MovieHomePage cần nó
                            MaterialPageRoute(builder: (_) => MovieHomePage(toggleTheme: () {
                            })),
                          );

                        } on FirebaseAuthException catch (e) {
                          // Xử lý lỗi Auth
                          String message = 'Lỗi đăng ký. Vui lòng thử lại.';
                          if (e.code == 'weak-password') {
                            message = 'Mật khẩu quá yếu (tối thiểu 6 ký tự).';
                          } else if (e.code == 'email-already-in-use') {
                            message = 'Email này đã được sử dụng.';
                          } else if (e.code == 'invalid-email') {
                            message = 'Địa chỉ Email không hợp lệ.';
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message)),
                          );
                        } catch (e) {
                          // Xử lý lỗi Firestore hoặc lỗi chung
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Đã xảy ra lỗi: ${e.toString()}')),
                          );
                        }
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