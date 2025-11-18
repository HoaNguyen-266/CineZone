import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_team/models/booking_details.dart'; // Import Model

class PaymentResultScreen extends StatelessWidget {
  final BookingDetails bookingDetails;
  final String paymentMethod;
  final bool isSuccess;
  final String transactionId;

  const PaymentResultScreen({
    super.key,
    required this.bookingDetails,
    required this.paymentMethod,
    required this.isSuccess,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi', symbol: '₫', decimalDigits: 0);

    return PopScope(
      canPop: false, // Ngăn người dùng back lại màn hình thanh toán
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kết Quả Thanh Toán'),
          automaticallyImplyLeading: false, // Xóa nút back
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Tiêu Đề Kết Quả ---
              Center(
                child: Column(
                  children: [
                    Icon(
                      isSuccess ? Icons.check_circle : Icons.cancel,
                      color: isSuccess ? Colors.green.shade700 : Colors.red.shade700,
                      size: 80,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isSuccess ? 'THANH TOÁN THÀNH CÔNG' : 'THANH TOÁN THẤT BẠI',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isSuccess ? Colors.green.shade700 : Colors.red.shade700,
                      ),
                    ),
                    if (isSuccess)
                      Text(
                        'Mã giao dịch: $transactionId',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),

              // --- Thông Tin Vé Đã Mua ---
              _buildDetailCard(
                title: 'Thông Tin Vé',
                children: [
                  _buildDetailRow('Phim:', bookingDetails.movieTitle),
                  _buildDetailRow('Suất Chiếu:', bookingDetails.showtime),
                  _buildDetailRow('Số Ghế:', bookingDetails.seats, isHighlight: true),
                ],
              ),

              const SizedBox(height: 20),

              // --- Chi Tiết Thanh Toán ---
              _buildDetailCard(
                title: 'Chi Tiết Thanh Toán',
                children: [
                  _buildDetailRow('Thanh Toán Bằng:', paymentMethod),
                  _buildDetailRow(
                    'Số Tiền Đã Thanh Toán:',
                    currencyFormat.format(bookingDetails.totalAmount),
                    isTotal: true,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Nút quay về trang chủ
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color(0xFF72687D),
                ),
                child: const Text('Hoàn Tất & Về Trang Chủ', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget phụ trợ cho các hàng chi tiết
  Widget _buildDetailRow(String label, String value, {bool isHighlight = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isHighlight ? Colors.orange : (isTotal ? Colors.red : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // Widget phụ trợ tạo Card chứa thông tin
  Widget _buildDetailCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }
}