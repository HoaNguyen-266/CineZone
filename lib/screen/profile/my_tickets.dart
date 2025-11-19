import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_team/models/transaction_display.dart';
import 'package:project_team/services/firestore_service.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vé Đã Đặt'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<TransactionDisplay>>(
        stream: getMyTransactions(), // ⭐ Gọi Service đọc dữ liệu
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print('Lỗi đọc Firestore: ${snapshot.error}');
            return const Center(child: Text('Đã xảy ra lỗi khi tải dữ liệu!'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Bạn chưa đặt vé nào.'));
          }

          final tickets = snapshot.data!;
          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              final currencyFormat = NumberFormat.currency(locale: 'vi', symbol: '₫', decimalDigits: 0);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.movie, color: Colors.purple),
                  title: Text(ticket.movieTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ghế: ${ticket.seats}'),
                      Text('Giao dịch: ${ticket.transactionId}'),
                      Text(DateFormat('dd/MM/yyyy HH:mm').format(ticket.timestamp),
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                  trailing: Text(
                    currencyFormat.format(ticket.totalAmount),
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    // Xử lý xem chi tiết vé
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}