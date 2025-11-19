import 'package:flutter/cupertino.dart';

class TransactionDisplay {
  final String transactionId;
  final String movieTitle;
  final String seats;
  final double totalAmount;
  final DateTime timestamp;

  TransactionDisplay({
    required this.transactionId,
    required this.movieTitle,
    required this.seats,
    required this.totalAmount,
    required this.timestamp,
});

  factory TransactionDisplay.fromFirestore(Map<String,dynamic> data, String id){
    final bookingData = data['bookingDetails'] as Map<String,dynamic>? ??{};
    final timestampString = data['timestamp'] ?? DateTime.now().toIso8601String();
    return TransactionDisplay(
      transactionId: id,
      movieTitle: bookingData['movieTitle'],
      seats: bookingData['seats'],
      totalAmount: bookingData['totalAmount'],
      timestamp: DateTime.parse(timestampString),
    );
  }
}