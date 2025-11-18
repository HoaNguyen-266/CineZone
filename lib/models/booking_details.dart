// lib/models/booking_details.dart

class BookingDetails {
  final String movieTitle;
  final String showtime;
  final String seats;
  final double totalAmount;

  BookingDetails({
    required this.movieTitle,
    required this.showtime,
    required this.seats,
    required this.totalAmount,
  });
}