import 'dart:math';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final database = FirebaseDatabase.instance.ref();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyCineTimeApp());
}

class MyCineTimeApp extends StatefulWidget {
  @override
  MyCineTimeAppState createState() => MyCineTimeAppState();
}

class MyCineTimeAppState extends State<MyCineTimeApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
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

class Movie {
  final String title;
  final String imagePath;
  final double rating;
  final int duration;
  final String releaseDate;
  final String description;
  final List<Map<String, String>> actors;
  final Map<String, String> director;

  Movie(this.title, this.imagePath, this.rating, this.duration, this.releaseDate, this.description,
      this.actors, this.director);
}

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

// MAIN HOME PAGE
class MovieHomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  MovieHomePage({required this.toggleTheme});

  final List<Movie> featuredMovies = [
    Movie('Trận Chiến Sau Tranh Chiến',
        'assets/images/tranchiensautranchien.jpg',7.6,120,'26/09/2025',
        'Một bộ phim hành động kịch tính về cuộc chiến giữa các băng nhóm...',
        [
          {'name': 'Diễn viên 1', 'avatar': 'assets/images/actor1.jpg'},
          {'name': 'Diễn viên 2', 'avatar': 'assets/images/actor2.jpg'},
        ],
        {'name': 'Đạo diễn 1', 'avatar': 'assets/images/director1.jpg'}),
    Movie('Cục Vàng Của Ngoại',
        'assets/images/cucvangcuangoai.jpg', 8.3, 119, '16/10/2025',
        'Câu chuyện xoay quanh bà Hậu, một bà ngoại tảo tần, hết lòng vì con cháu...',
        [
          {'name': 'Diễn viên 3', 'avatar': 'assets/images/actor3.jpg'},
          {'name': 'Diễn viên 4', 'avatar': 'assets/images/actor4.jpg'},
        ],
        {'name': 'Đạo diễn 2', 'avatar': 'assets/images/director2.jpg'}),
    Movie('The Concert Film', 'assets/images/theconcertfilm.jpg', 10, 120,'17/10/2025',
        'Một bộ phim âm nhạc đặc sắc, kể về hành trình của một ban nhạc trẻ...',
        [
          {'name': 'Diễn viên 5', 'avatar': 'assets/images/actor5.jpg'},
        ],
        {'name': 'Đạo diễn 3', 'avatar': 'assets/images/director3.jpg'}),
    Movie('Nhà Ma Xó', 'assets/images/nhamaxo.jpg',6.8,108,'24/10/2025',
        'Một bộ phim kinh dị về một ngôi nhà ma ám...',
        [
          {'name': 'Diễn viên 6', 'avatar': 'assets/images/actor6.jpg'},
        ],
        {'name': 'Đạo diễn 4', 'avatar': 'assets/images/director4.jpg'}),
  ];

  final List<Movie> movies = [
    Movie('Cục Vàng Của Ngoại', 'assets/images/cucvangcuangoai.jpg',8.3, 119, '16/10/2025',
        'Câu chuyện xoay quanh bà Hậu, một bà ngoại tảo tần, hết lòng vì con cháu...',
        [
          {'name': 'Diễn viên 3', 'avatar': 'assets/images/actor3.jpg'},
          {'name': 'Diễn viên 4', 'avatar': 'assets/images/actor4.jpg'},
        ],
        {'name': 'Đạo diễn 2', 'avatar': 'assets/images/director2.jpg'}),
    Movie('The concert film', 'assets/images/theconcertfilm.jpg',10,120,'17/10/2025',
        'Một bộ phim âm nhạc đặc sắc, kể về hành trình của một ban nhạc trẻ...',
        [
          {'name': 'Diễn viên 5', 'avatar': 'assets/images/actor5.jpg'},
        ],
        {'name': 'Đạo diễn 3', 'avatar': 'assets/images/director3.jpg'}),
    Movie('Nhà Ma Xó', 'assets/images/nhamaxo.jpg',6.8,108,'24/10/2025',
        'Một bộ phim kinh dị về một ngôi nhà ma ám...',
        [
          {'name': 'Diễn viên 6', 'avatar': 'assets/images/actor6.jpg'},
        ],
        {'name': 'Đạo diễn 4', 'avatar': 'assets/images/director4.jpg'}),
    Movie('Phỏng Vấn Sát Nhân', 'assets/images/phongvansatnhan.jpg',6.5, 107, '24/10/2025',
        'Một bộ phim hình sự về cuộc điều tra một vụ án mạng...',
        [
          {'name': 'Diễn viên 7', 'avatar': 'assets/images/actor7.jpg'},
        ],
        {'name': 'Đạo diễn 5', 'avatar': 'assets/images/director5.jpg'}),
    Movie('Chú Thuật Sư Hồi Chiến', 'assets/images/chuthuatsu.jpg',8.0, 162 , '26/09/2025',
        'Một bộ phim hành động về một nhóm chú thuật sư...',
        [
          {'name': 'Diễn viên 8', 'avatar': 'assets/images/actor8.jpg'},
        ],
        {'name': 'Đạo diễn 6', 'avatar': 'assets/images/director6.jpg'}),
    Movie('Trò Chơi Ảo Giác', 'assets/images/trochoiaogiac.jpg',8.2, 118, '10/10/2025',
        'Một bộ phim viễn tưởng về một trò chơi ảo...',
        [
          {'name': 'Diễn viên 9', 'avatar': 'assets/images/actor9.jpg'},
        ],
        {'name': 'Đạo diễn 7', 'avatar': 'assets/images/director7.jpg'}),
  ];

  final List<Movie> moviesComingSoon = [
    Movie('Trốn Chạy Tử Thần','assets/images/tronchaytuthan.jpg',0.0,133,'14/11/2025' ,'Một bộ phim ...',
        [{'name': 'Dien vien', 'avatar': 'asset'}],{'name': 'Dao dien', 'avatar': ''}),
    Movie('Cải Mả', 'assets/images/caima.jpg',0.0,115,'31/10/2025','',[{'name': 'Dien vien', 'avatar': 'asset'}],{'name': 'Dao dien', 'avatar': ''}),
    Movie('Phá Đám Sinh Nhật Mẹ', 'assets/images/phadamsinhnhatme.jpg',7.6,91-93,'31/10/2025','',[{'name': 'Dien vien', 'avatar': 'asset'}],{'name': 'Dao dien', 'avatar': ''}),
    Movie('Điện Thoại Đen 2', 'assets/images/dienthoaiden_2.jpg',6.5, 114, '31/10/2025','',[{'name': 'Dien vien', 'avatar': 'asset'}],{'name': 'Dao dien', 'avatar': ''}),
    Movie('Phòng Trọ Ma Bầu', 'assets/images/phongtromabau.jpg',0.0,120,'07/11/2025','',[{'name': 'Dien vien', 'avatar': 'asset'}],{'name': 'Dao dien', 'avatar': ''}),
    Movie('ai Thương ai Mến', 'assets/images/aithuongaimen.jpg',0.0,000,'01/01/2026','',[{'name': 'Dien vien', 'avatar': 'asset'}],{'name': 'Dao dien', 'avatar': ''}),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(68.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'CINEZONE',
                style: GoogleFonts.robotoSerif(
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Color(0xFF432986),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Color(0xFF6E3AA7),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      'Nổi bật',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 255,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: featuredMovies.length,
                      itemBuilder: (context, index){
                        final movie = featuredMovies[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  movie.imagePath,
                                  width: 210,
                                  height: 255,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(color: Colors.black, blurRadius: 1)
                                          ]),
                                    ),
                                    Text(
                                      '1 tiếng 59 phút',
                                      style: TextStyle(color: Colors.white70, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.7),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(14),
                                        bottomRight: Radius.circular(14),
                                      )
                                  ),
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(color: Colors.yellowAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 12,
                                right: 16,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8))),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => MovieBookingPage(movie: movie),
                                      ),
                                    );
                                  },
                                  child: Text('Đặt vé',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            TabBar(
              indicatorColor: Colors.purple,
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Đang chiếu'),
                Tab(text: 'Sắp chiếu'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(9),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.68,
                      children: movies.map((movie) => movieGridItem(movie, context)).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(9),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.68,
                      children: moviesComingSoon.map((movie) => movieGridItem(movie, context)).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: (){},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Colors.grey),
                  ),
                  child: Text(
                    'Xem thêm',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
            Container(
              height: 56,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _BottomNavItem(icon: Icons.home, label: 'Trang Chủ', selected: true),
                  _BottomNavItem(icon: Icons.person, label: 'Cá Nhân', selected: false),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget movieGridItem(Movie movie, BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => MovieBookingPage(movie: movie)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.asset(
                movie.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 7),
          Text(
            movie.title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class MovieBookingPage extends StatelessWidget {
  final Movie movie;

  const MovieBookingPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFF72687D),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: SizedBox.shrink(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner phim + Info cơ bản
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.asset(movie.imagePath, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(movie.imagePath, width: 48, height: 68, fit: BoxFit.cover),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 17),
                                  Text(
                                    movie.rating.toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Đánh giá',
                                    style: TextStyle(color: Colors.grey, fontSize: 13),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: Colors.orange),
                                  SizedBox(width: 2),
                                  Text(
                                    '${movie.duration} phút',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.calendar_month, size: 16, color: Colors.orange),
                                  SizedBox(width: 2),
                                  Text(movie.releaseDate, style: TextStyle(fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.play_circle_outline, color: Color(0xFF432986), size: 32),
                      ],
                    ),
                  ),
                  // TabBar cho 3 Tab
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
                    ),
                    child: TabBar(
                      indicatorColor: Colors.purple,
                      labelColor: Colors.purple,
                      unselectedLabelColor: Colors.grey.shade600,
                      tabs: [
                        Tab(text: 'Suất chiếu'),
                        Tab(text: 'Thông Tin'),
                        Tab(text: 'Đánh Giá'),
                      ],
                    ),
                  ),
                  Container(
                    height: 800,
                    child: TabBarView(
                      children: [
                        // Tab 1: Suất chiếu
                        _buildShowtimeTab(),
                        // Tab 2: Thông tin
                        _buildInfoTab(),
                        // Tab 3: Đánh giá
                        _buildReviewTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildShowtimeTab() {
    final showtimes = {
      'CineZone Gò Vấp': ['07:00', '12:45', '15:15', '17:50', '20:00'],
      'CineZone Thủ Đức': ['08:30', '14:00', '19:30', '21:00'],
      'CineZone Quận 1': ['09:00', '11:00', '16:30', '22:00'],
      'CineZone Quận 12': ['10:00', '13:00', '18:00'],
      'CineZone Quận 7': ['07:30', '12:00', '15:45', '20:45'],
      'CineZone Quận 2': ['11:30', '17:00', '21:30'],
    };
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    value: 'TP Hồ Chí Minh',
                  icon: Icon(Icons.arrow_drop_down),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (String? newValue) {

                  },
                  items: <String>['TP Hồ Chí Minh', 'Hà Nội'].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDateChip('Thứ 6\n07/11', false),
              _buildDateChip('Thứ 7\n08/11', false),
              _buildDateChip('Chủ Nhật\n09/11', false),
              _buildDateChip('Thứ 2\n10/11', false),
            ],
          ),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Thứ Sáu 07, Tháng 11 2025', style: TextStyle(color: Colors.grey.shade600)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: showtimes.length,
              itemBuilder: (context, index) {
                String cinemaName = showtimes.keys.elementAt(index);
                List<String> times = showtimes.values.elementAt(index);
                return ShowtimeSelector (
                  cinemaName: cinemaName,
                  showtimes: times,
                  onTimeSelected: (time) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SeatSelectionPage(
                          movie: movie,
                          cinema: cinemaName,
                          time: time,
                          date: '07/11',
                        ),
                      ),
                    );
                  },
                  isFirst: index ==0,
                );
              },
            ),
          )
        ],
      ),
    );
  }
  Widget _buildDateChip(String label, bool isSelected){
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? Colors.black : Colors.grey.shade400),
      ),
      child: Text(
        label, textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold :FontWeight.normal,
          height: 1.2,
        ),
      ),
    );
  }
  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nội dung', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            movie.description,
            style: TextStyle(fontSize: 15, height: 1.5),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20),
          Text('Diễn Viên',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movie.actors.length,
              itemBuilder: (context, index) {
                final actor = movie.actors[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(actor['avatar']!),
                      ),
                      SizedBox(height: 4),
                      Text(actor['name']!, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text('Đạo Diễn',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(movie.director['avatar']!),
              ),
              SizedBox(width: 10),
              Text(movie.director['name']!, style: TextStyle(fontSize: 15)),
            ],
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
  Widget _buildReviewTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(movie.imagePath, width: 150, height: 220, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(
              'Đánh giá cho',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            Text(
              '"${movie.title}"',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              '10', // Giả sử người dùng đang chọn 10 sao
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.orange.shade700),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                10,
                    (index) => Icon(
                  Icons.star,
                  color: index < 10 ? Colors.amber : Colors.grey,
                  size: 28,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic Đánh giá/Đồng ý
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Đồng ý',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _BottomNavItem(
  {required this.icon, required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: selected ? Colors.purple.shade900 : Colors.grey.shade600,
        size: 26,
        ),
        Text(label, style: TextStyle(fontSize: 10, color: selected ? Colors.purple.shade900 : Colors.grey.shade600,
        ),
        )
      ],
    );
  }
}
class ShowtimeSelector extends StatefulWidget {
  final String cinemaName;
  final List<String> showtimes;
  final Function(String) onTimeSelected;
  final bool isFirst;

  const ShowtimeSelector({
    required this.cinemaName,
    required this.showtimes,
    required this.onTimeSelected,
    required this.isFirst,
  });

  @override
  _ShowtimeSelectorState createState() => _ShowtimeSelectorState();
}

class _ShowtimeSelectorState extends State<ShowtimeSelector> {
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isFirst; // Mở rộng rạp đầu tiên
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cinemaName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '2D PHỤ ĐỀ',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    )
                  ],
                ),
                Row(
                  children: [
                    if (widget.isFirst)
                      Text(
                        '3.5 km',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14),
                      ),
                    SizedBox(width: 5),
                    Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.grey.shade600),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: widget.showtimes.map((time) {
                return OutlinedButton(
                  onPressed: () => widget.onTimeSelected(time),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(time),
                );
              }).toList(),
            ),
          ),
        Divider(color: Colors.grey.shade300, thickness: 1),
      ],
    );
  }
}
class SeatSelectionPage extends StatefulWidget {
  final Movie movie;
  final String cinema;
  final String time;
  final String date;

  const SeatSelectionPage({
    Key? key,
    required this.movie,
    required this.cinema,
    required this.time,
    required this.date,
  }) : super(key: key);

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  // Trạng thái ghế: 'selected', 'reserved', 'normal', 'double', 'vip', 'triple'
  Map<String, List<String>> _seatStatus = {};
  List<String> _selectedSeats = [];

  @override
  void initState() {
    super.initState();
    _initializeSeats();
  }

  void _initializeSeats() {
    // Khởi tạo trạng thái cho 10 hàng (A đến L, bỏ qua I) và 14 cột
    final rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L'];
    _seatStatus = {};

    for (var row in rows) {
      _seatStatus[row] = List.generate(14, (col) => 'normal');
    }

    // Giả lập ghế đã bán ('reserved')
    _seatStatus['C']![2] = 'reserved';
    _seatStatus['C']![3] = 'reserved';
    _seatStatus['F']![7] = 'reserved';
    _seatStatus['F']![8] = 'reserved';

    // Giả lập ghế VIP
    _seatStatus['G'] = List.generate(14, (col) => 'vip');
    _seatStatus['H'] = List.generate(14, (col) => 'vip');
  }

  void _toggleSeat(String row, int colIndex) {
    String seatId = '$row${colIndex + 1}';
    String status = _seatStatus[row]![colIndex];

    if (status == 'reserved') return; // Không thể chọn ghế đã bán

    setState(() {
      if (_selectedSeats.contains(seatId)) {
        _selectedSeats.remove(seatId);
      } else {
        _selectedSeats.add(seatId);
      }
    });
  }

  Color _getSeatColor(String status, String row, int colIndex) {
    String seatId = '$row${colIndex + 1}';
    if (_selectedSeats.contains(seatId)) return Color(0xFF72687D); // Đang chọn
    switch (status) {
      case 'reserved':
        return Colors.red.shade900; // Đã bán
      case 'vip':
        return Color(0xFFF0E463); // Ghế VIP
      case 'double':
        return Color(0xFFF79A9A); // Ghế đôi (Giả lập)
      case 'triple':
        return Color(0xFFC8F79A); // Ghế ba (Giả lập)
      case 'normal':
      default:
        return Colors.grey.shade300; // Ghế trống
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Chọn Chỗ Ngồi',
            style: TextStyle(color: Colors.black, fontSize: 18)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Banner thông tin phim
          Container(
            color: Color(0xFFAF9CF3),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '2D PHỤ ĐỀ L2',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(widget.time,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                )
              ],
            ),
          ),

          // Sơ đồ ghế ngồi
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Sơ đồ ghế
                      _buildSeatLayout(),
                      SizedBox(height: 30),
                      // Màn hình
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade700,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Màn Hình',
                          style: TextStyle(color: Colors.grey.shade600)),
                      SizedBox(height: 20),
                      // Chú thích
                      _buildLegend(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Thanh toán
          _buildCheckoutBar(),
        ],
      ),
    );
  }

  Widget _buildSeatLayout() {
    final rows = ['L', 'K', 'J', 'H', 'G', 'F', 'E', 'D', 'C', 'B', 'A'];
    final int totalColumns = 14;
    // Khắc phục lỗi cú pháp: dùng .size.width và khai báo biến
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = screenWidth - 40; // Chiều rộng Container sau khi trừ padding 16*2=32 + lề 8

    // Tính toán kích thước ghế động dựa trên 15.6 đơn vị (14 ghế + 1 cột chữ cái + khoảng trống)
    // 15.6 là hệ số điều chỉnh tối ưu để đảm bảo không tràn màn hình
    final double calculatedSeatSize = (containerWidth) / 15.6;
    final double dynamicSeatSize = calculatedSeatSize.clamp(18.0, 24.0); // Giới hạn kích thước
    final double dynamicSeatSpacing = 3.0; // Tăng nhẹ spacing để dễ nhìn
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: rows.map((row) {
          if (row == 'I') return SizedBox.shrink(); // Bỏ qua hàng I
          return Padding(
            padding: EdgeInsets.only(bottom: dynamicSeatSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: dynamicSeatSize,
                    alignment: Alignment.center,
                    child: Text(row,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14))),
                SizedBox(width: dynamicSeatSize * 2),
                ...List.generate(totalColumns, (colIndex) {
                  String status = _seatStatus[row]![colIndex];
                  Color seatColor = _getSeatColor(status, row, colIndex);
                  String seatId = '$row${colIndex + 1}';

                  // Logic chia ghế thành 3 cụm (4 - 6 - 4) và khoảng trống ở giữa
                  if(colIndex == 5) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: dynamicSeatSpacing*5),
                        _buildSingleSeat(status,row,colIndex,seatColor,seatId,dynamicSeatSize, dynamicSeatSpacing),
                      ],
                    );
                  }
                  if(colIndex == 10) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: dynamicSeatSpacing*5),
                        _buildSingleSeat(status,row,colIndex,seatColor,seatId, dynamicSeatSize,dynamicSeatSpacing),
                      ],
                    );
                  }
                  return _buildSingleSeat(status,row,colIndex,seatColor,seatId,dynamicSeatSize,dynamicSeatSize);
                }),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildSingleSeat(String status, String row, int colIndex, Color color, String seatId, double size, double spacing){
    return Padding(
      padding: EdgeInsets.only(right: spacing),
      child: GestureDetector(
        onTap: () => _toggleSeat(row, colIndex),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey.shade500,
              width: 1,
            ),
          ),
          child: _selectedSeats.contains(seatId) ? Center(
            child: Icon(Icons.check,
            size: size*0.7, color: Colors.white)) : null,
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade500),
          ),
        ),
        SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 13)),
        SizedBox(width: 15),
      ],
    );
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(
                'Ghế trống', Colors.grey.shade300),
            _buildLegendItem('Ghế đôi', Color(0xFFF79A9A)), // Màu giả lập
            _buildLegendItem('Ghế VIP', Color(0xFFF0E463)),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem('Ghế ba', Color(0xFFC8F79A)), // Màu giả lập
            _buildLegendItem('Đã bán', Colors.red.shade900),
            _buildLegendItem('Đang chọn', Color(0xFF72687D)),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckoutBar() {
    String seatList = _selectedSeats.isEmpty
        ? 'Chọn ghế'
        : _selectedSeats.join(', ');
    double totalPrice = _selectedSeats.length * 80000; // Giả sử giá 80k/ghế

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(seatList,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                    'Tổng cộng: ${NumberFormat.currency(locale: 'vi', symbol: '₫').format(totalPrice)}',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _selectedSeats.isEmpty
                ? null
                : () {
              // Logic thanh toán
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Chuyển sang màn hình thanh toán cho ghế: $seatList'),
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF72687D),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Tiếp tục', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}