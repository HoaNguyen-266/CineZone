import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyCineTimeApp());

class MyCineTimeApp extends StatefulWidget {
  @override
  MyCineTimeAppState createState() => MyCineTimeAppState();
}

class MyCineTimeAppState extends State<MyCineTimeApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = (_themeMode == ThemeMode.light)
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Cine Time',
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: LoginScreen(onLoginSuccess: (loginContext) {
        Navigator.pushReplacement(
          loginContext,
          MaterialPageRoute(builder: (_) => MainScreen(toggleTheme: toggleTheme)),
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
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onLoginSuccess(context);
              },
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}

// REGISTER
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, child: Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}

// MOVIE MODEL
class Movie {
  final String title;
  final String description;
  final String imageUrl;
  final String trailerUrl;

  Movie({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.trailerUrl,
  });
}

// MAIN SCREEN
class MainScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  MainScreen({required this.toggleTheme});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Movie> featuredMovies = [
    Movie(
      title: "Mưa Đỏ",
      description: "Mưa đỏ (tên đầy đủ: Mưa đỏ: Máu xương đổ xuống – Đất trời lưu danh; tiếng Anh: Red Rain) là một bộ phim điện ảnh Việt Nam thuộc thể loại lịch sử – chiến tranh – chính kịch ra mắt năm 2025.",
      imageUrl: "https://upload.wikimedia.org/wikipedia/vi/thumb/4/49/Mua_do_poster.jpg/250px-Mua_do_poster.jpg",
      trailerUrl: "https://www.youtube.com/watch?v=BD6PoZJdt_M",
    ),
  ];
  List<Movie> recommendedMovies = [];

  @override
  void initState() {
    super.initState();
    recommendedMovies = featuredMovies;
  }

  void goToDetails(Movie movie) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailScreen(movie: movie)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cine Time"),
        actions: [
          IconButton(onPressed: widget.toggleTheme, icon: Icon(Icons.brightness_6)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
          }, icon: Icon(Icons.person)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm phim',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                ),
                onSubmitted: (value) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen(onSelected: goToDetails),
                  ),);
                },
              ),
            ),
            Text("Phim nổi bật", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Container(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featuredMovies.length,
                itemBuilder: (_, index) {
                  var movie = featuredMovies[index];
                  return GestureDetector(
                    onTap: () => goToDetails(movie),
                    child: Container(
                      width: 140,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          Image.network(movie.imageUrl, fit: BoxFit.cover, height: 120),
                          Text(movie.title, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text("Gợi ý cho bạn", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Container(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedMovies.length,
                itemBuilder: (_, index) {
                  var movie = recommendedMovies[index];
                  return GestureDetector(
                    onTap: () => goToDetails(movie),
                    child: Container(
                      width: 140,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          Image.network(movie.imageUrl, fit: BoxFit.cover, height: 120),
                          Text(movie.title, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SEARCH SCREEN
class SearchScreen extends StatefulWidget {
  final Function(Movie) onSelected;
  SearchScreen({required this.onSelected});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  List<Movie> movies = [
    Movie(
      title: "Mưa Đỏ",
      description: "Mưa đỏ... (mô tả tương tự trên)",
      imageUrl: "https://upload.wikimedia.org/wikipedia/vi/thumb/4/49/Mua_do_poster.jpg/250px-Mua_do_poster.jpg",
      trailerUrl: "https://youtu.be/BD6PoZJdt_M?si=N7DRyeSAePf5Nhs8",
    ),
  ];
  List<Movie> results = [];

  void search(String query) {
    setState(() {
      results = movies.where((m) => m.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tìm kiếm phim")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Nhập tên phim", suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () => search(controller.text))),
              onSubmitted: search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (_, index) {
                var movie = results[index];
                return ListTile(
                  leading: Image.network(movie.imageUrl),
                  title: Text(movie.title),
                  subtitle: Text(movie.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                  onTap: () => widget.onSelected(movie),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// MOVIE DETAIL SCREEN
class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  MovieDetailScreen({required this.movie});

  @override
  MovieDetailScreenState createState() => MovieDetailScreenState();
}

class MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;
  double userRating = 0;
  final _commentController = TextEditingController();
  List<String> comments = [];

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        comments.add(_commentController.text);
        _commentController.clear();
      });
    }
  }
  void openTrailer(String url) async {
    final uri = Uri.parse(url);
    if(await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể mở trailer')),
      );
    }
  }
  void rateMovie(double rating) {
    setState(() {
      userRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(widget.movie.imageUrl),
            SizedBox(height: 8),
            Text(widget.movie.description),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                openTrailer(widget.movie.trailerUrl);
              },
              child: Text("Xem Trailer"),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                  onPressed: toggleFavorite,
                ),
                SizedBox(width: 8),
                Text(isFavorite ? "Đã thêm vào yêu thích" : "Thêm vào yêu thích")
              ],
            ),
            SizedBox(height: 10),
            Text("Đánh Giá Phim"),
            Slider(
              value: userRating,
              onChanged: rateMovie,
              min: 0,
              max: 5,
              divisions: 5,
              label: userRating.toString(),
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(labelText: "Bình luận"),
            ),
            ElevatedButton(
              onPressed: addComment,
              child: Text("Gửi Bình Luận"),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (_, index) => ListTile(title: Text(comments[index])),
            )
          ],
        ),
      ),
    );
  }
}

// PROFILE SCREEN
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hồ Sơ Cá Nhân")),
      body: Center(
        child: Text("Quản lý thông tin cá nhân"),
      ),
    );
  }
}
