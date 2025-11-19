import 'package:project_team/services/firestore_uploader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_team/models/booking_details.dart'; // Import Model
import 'package:project_team/screen/booking/payment_result_screen.dart'; // Import màn hình kế tiếp

class PaymentScreen extends StatefulWidget{
  final BookingDetails bookingDetails;
  const PaymentScreen({super.key, required this.bookingDetails});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod;

  final List<String> paymentMethods = [
    'Ví MOMO',
    'Ví ShopeePay',
    'Ví ZaloPay',
    'Thanh toán ngân hàng',
  ];

  void _handleContinuePayment() async {
    if (_selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn phương thức thanh toán.')),
      );
      return;
    }

    // --- Mô phỏng Thanh toán ---
    await Future.delayed(const Duration(milliseconds: 500));
    const bool paymentSuccess = true;

    if (paymentSuccess) {
      final bookingDetails = widget.bookingDetails;
      await uploadBooking(bookingDetails);
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context)=> PaymentResultScreen(
                  bookingDetails: bookingDetails,
                  paymentMethod: _selectedPaymentMethod!,
                  isSuccess: true,
                  transactionId: 'TXN${DateTime.now().millisecondsSinceEpoch}',
              ),
          ),
      );
    } else {
      // Xử lý thất bại
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thanh toán thất bại. Vui lòng thử lại.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi', symbol: '₫', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giao Diện Thanh Toán'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildSummaryCard(widget.bookingDetails, currencyFormat),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text('Chọn Phương Thức Thanh Toán:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                // Danh sách Phương thức Thanh toán
                ...paymentMethods.map((method) {
                  return ListTile(
                    leading: const Icon(Icons.payment, color: Color(0xFF72687D)),
                    title: Text(method),
                    trailing: Radio<String>(
                      value: method,
                      groupValue: _selectedPaymentMethod,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPaymentMethod = value;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = method;
                      });
                    },
                  );
                }).toList(),
              ],
            ),
          ),

          // Thanh toán - Bottom Bar
          _buildCheckoutBar(currencyFormat),
        ],
      ),
    );
  }

  // Widget phụ trợ (Không cần tách sang file riêng)
  Widget _buildSummaryCard(BookingDetails details, NumberFormat currencyFormat) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(details.movieTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            _summaryRow('Suất:', '${details.showtime}'),
            _summaryRow('Ghế:', details.seats, isHighlight: true),
            _summaryRow('Tổng cộng:', currencyFormat.format(details.totalAmount), isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isHighlight = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 15, color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? Colors.orange : (isTotal ? Colors.red : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutBar(NumberFormat currencyFormat) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                const Text('Tổng cần thanh toán:',
                    style: TextStyle(
                        fontSize: 14, color: Colors.black54)),
                Text(
                    currencyFormat.format(widget.bookingDetails.totalAmount),
                    style: const TextStyle(
                        color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _selectedPaymentMethod == null ? null : _handleContinuePayment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF72687D),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Xác nhận', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}