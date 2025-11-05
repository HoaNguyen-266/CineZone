import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyCineTimeApp());

class MyCineTimeApp extends StatefulWidget {
  @override
  MyCineTimeAppState createState() => MyCineTimeAppState();
}

class MyCineTimeAppState extends State<MyCineTimeApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
      (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CINEZONE',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: LoginScreen(onLoginSuccess: (loginContext) {
        Navigator.pushReplacement(
          loginContext,
          MaterialPageRoute(
              builder: (_) => MovieHomePage(toggleTheme: toggleTheme)),
        );
      }),
    );
  }
}

// LOGIN
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
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/2894/2894479.png',
                height: 80,
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

// REGISTER
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final surnameController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFFAF9CF3),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/2894/2894479.png',
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
                    SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
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

// HomePage
class MovieHomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  MovieHomePage({required this.toggleTheme});

  final List<String> featuredMovies = [
    'assets/images/tranchiensautranchien.jpg',
    'assets/images/cucvangcuangoai.jpg',
    'assets/images/theconcertfilm.jpg',
    'assets/images/nhamaxo.jpg'
  ];

  final List<Movie> movies = [
    Movie('Cục Vàng Của Ngoại', 'assets/images/cucvangcuangoai.jpg'),
    Movie('Tổ Quốc Trong Tim', 'assets/movie2.jpg'),
    Movie('Nguoi An Toi', 'assets/movie3.jpg'),
    Movie('Phong Vien Soi No', 'assets/movie4.jpg'),
    Movie('Chau Thieu Nu Moi Cuoc', 'assets/movie5.jpg'),
    Movie('Toi Chat Ao Ban', 'assets/movie6.jpg'),
  ];

  final List<Movie> moviesComingSoon = [
    Movie('',''),
    Movie('title', 'imagePath'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trang Chủ'),
          backgroundColor: Colors.purple,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Đang Chiếu'),
              Tab(text: 'Sắp Chiếu'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 220,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredMovies.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 140,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          featuredMovies[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 500,
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: movies.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index){
                          return Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    movies[index].imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                movies[index].title,
                                style: TextStyle(fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: moviesComingSoon.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index){
                          return Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    moviesComingSoon[index].imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang Chủ',),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Giỏ Hàng'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá Nhân'),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.blueAccent
          ,
        ),
      ),
    );
  }
}
class Movie {
  final String title;
  final String imagePath;
  Movie(this.title, this.imagePath);
}
