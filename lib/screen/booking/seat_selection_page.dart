import 'package:flutter/material.dart';
import 'package:project_team/models/booking_details.dart';
import 'package:project_team/models/movie.dart';
import 'package:intl/intl.dart'; // 1. Để dùng NumberFormat
import 'package:project_team/screen/booking/payment_screen.dart'; // 2. Để dùng PaymentScreen (Giả định path)

// ... class SeatSelectionPage

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
    double totalPrice = 0; // Giả sử giá 80k/ghế
    for(var seatId in _selectedSeats) {
      String row = seatId[0];
      int colIndex = int.parse(seatId.substring(1)) -1;
      String status = _seatStatus[row]![colIndex];
      if(status == 'vip'){
        totalPrice += 100000;
      }else{
        totalPrice += 80000;
      }
    }
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
                : (){
              final bookingDetails = BookingDetails(
                movieTitle: widget.movie.title,
                showtime: widget.time,
                seats: seatList,
                totalAmount: totalPrice,
              );
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(bookingDetails: bookingDetails),
                ),
              );
            },
            child: Text('Tiếp tục',style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}