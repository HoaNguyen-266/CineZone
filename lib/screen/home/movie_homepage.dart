import 'package:flutter/material.dart';
import 'package:project_team/models/movie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_team/screen/auth/profile.dart';
import 'package:project_team/widgets/showtime_selector.dart';
import 'package:project_team/screen/booking/seat_selection_page.dart';
import 'package:project_team/services/firestore_uploader.dart';

class MovieHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  MovieHomePage({required this.toggleTheme});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  int _selectedIndex = 0;

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
  void _uploadAllMovies() {
    List<Movie> allMovies = [...featuredMovies, ...movies, ...moviesComingSoon];
    final uniqueMovies = <String, Movie>{};
    for (var movie in allMovies) {
      uniqueMovies.putIfAbsent(movie.title, () => movie);
    }
    uploadIntialMovies(uniqueMovies.values.toList());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đang tải dữ liệu phim lên Firestore, kiểm tra console.')),
    );
  }
  Widget _buildHomeScreenContent(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // Banner nổi bật
          Container(
            color: const Color(0xFF6E3AA7),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
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
                const SizedBox(height: 12),
                SizedBox(
                  height: 255,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(color: Colors.black, blurRadius: 1)
                                        ]),
                                  ),
                                  const Text(
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
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 0.7),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                      bottomRight: Radius.circular(14),
                                    )
                                ),
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(color: Colors.yellowAccent,
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
                                child: const Text('Đặt vé',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          // TabBar
          const TabBar(
            indicatorColor: Colors.purple,
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'Đang chiếu'),
              Tab(text: 'Sắp chiếu'),
            ],
          ),
          // TabBarView
          Expanded(
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(9),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.68,
                    children: movies.map((movie) => movieGridItem(movie, context)).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9),
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
          // Xem thêm Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: const Text(
                  'Xem thêm',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Danh sách các màn hình (Tab Trang Chủ và Tab Cá Nhân)
  late final List<Widget> _screens = [
    _buildHomeScreenContent(context),
    ProfileScreen(toggleTheme: widget.toggleTheme),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // AppBar chỉ hiển thị ở Trang Chủ, khi ở trang Cá Nhân thì dùng AppBar riêng của nó
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(68.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'CINEZONE',
                style: GoogleFonts.robotoSerif(
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Color(0xFF432986),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: _uploadAllMovies, icon: Icon(Icons.cloud_upload,color: Colors.blue),
              )
            ],
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        // Bottom Navigation Bar
        bottomNavigationBar: Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavItem(
                  icon: Icons.home,
                  label: 'Trang Chủ',
                  selected: _selectedIndex == 0,
                  onTap: () => _onItemTapped(0)
              ),
              _BottomNavItem(
                  icon: Icons.person,
                  label: 'Cá Nhân',
                  selected: _selectedIndex == 1,
                  onTap: () => _onItemTapped(1)
              ),
            ],
          ),
        )
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
          const SizedBox(height: 7),
          Text(
            movie.title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
  final VoidCallback onTap;

  const _BottomNavItem(
      {required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: selected ? Colors.purple.shade900 : Colors.grey.shade600,
            size: 26,
          ),
          Text(label, style: TextStyle(fontSize: 10, color: selected ? Colors.purple.shade900 : Colors.grey.shade600,
          ),
          )
        ],
      ),
    );
  }
}