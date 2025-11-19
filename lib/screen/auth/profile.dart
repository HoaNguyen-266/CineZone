import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_team/screen/profile/my_tickets.dart';
// 1. Định nghĩa Class MenuItem và dữ liệu
class MenuItem {
  final IconData icon;
  final String title;
  final String screen;
  final bool isLogout;

  // Sử dụng tham số vị trí tùy chọn cho isLogout (giá trị mặc định là false)
  const MenuItem(this.icon, this.title, this.screen, [this.isLogout = false]);
}

// 2. Định nghĩa Dữ liệu Menu
final List<MenuItem> mainMenuItems = [
  const MenuItem(Icons.local_activity_outlined, 'Vé Đã Đặt', 'MyTickets'),
  const MenuItem(Icons.card_giftcard_outlined, 'Ưu Đãi Của Tôi', 'MyVouchers'),
  const MenuItem(Icons.star_outline, 'Điểm Thưởng & Quà Tặng', 'Loyalty'),
];

final List<MenuItem> settingMenuItems = [
  const MenuItem(Icons.person_outline, 'Thông Tin Cá Nhân', 'PersonalInfo'),
  const MenuItem(Icons.settings_outlined, 'Cài Đặt Ứng Dụng', 'AppSettings'),
  const MenuItem(Icons.help_outline, 'Trợ Giúp & Liên Hệ', 'HelpSupport'),
  const MenuItem(Icons.logout, 'Đăng Xuất', 'Logout', true),
];

// 3. Widget ProfileScreen
class ProfileScreen extends StatelessWidget {
  // Callback để gọi hàm đổi theme từ MyCineTimeAppState
  final VoidCallback toggleTheme;

  const ProfileScreen({super.key, required this.toggleTheme});

  // Widget con để xây dựng từng dòng menu
  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    return InkWell(
      onTap: () async {
        if (item.isLogout) {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        } else if (item.screen == 'MyTickets') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const MyTicketsScreen()),
          );
        } else {
          // Xử lý điều hướng đến các màn hình khác
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Điều hướng đến ${item.screen}'))
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(item.icon, color: item.isLogout ? Colors.red : Colors.grey.shade700),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 16,
                  color: item.isLogout ? Colors.red : Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: item.isLogout ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (!item.isLogout)
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  // Widget con để xây dựng từng phần (Section)
  Widget _buildSection(BuildContext context, String title, List<MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              int index = entry.key;
              MenuItem item = entry.value;
              return Column(
                children: [
                  _buildMenuItem(context, item),
                  if (index < items.length - 1)
                    Divider(
                      height: 1,
                      indent: 15,
                      endIndent: 15,
                      color: Colors.grey.shade200,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Lấy thông tin người dùng hiện tại
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'Khách Hàng';
    final userEmail = user?.email ?? 'Chưa Đăng Nhập';

    // Màu chủ đạo từ main.dart
    const Color primaryColor = Color(0xFF432986);
    const Color headerColor = Color(0xFFAF9CF3);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // Header Profile Banner
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            backgroundColor: primaryColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('CINEZONE',
                  style: GoogleFonts.robotoSerif(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  )),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [headerColor, primaryColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: primaryColor),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userEmail,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Chỉnh sửa hồ sơ!'))
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Menu Items
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildSection(context, 'Quản lý Tài khoản', mainMenuItems),
                const SizedBox(height: 10),
                _buildSection(context, 'Cài đặt và Hỗ trợ', settingMenuItems),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}