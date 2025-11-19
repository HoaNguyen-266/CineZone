import 'package:project_team/models/booking_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
class TransactionHistory{
  final BookingDetails bookingDetails;
  final String paymentMethod;
  final bool isSuccess;
  final String transactionId;

  TransactionHistory({
    required this.bookingDetails,
    required this.paymentMethod,
    required this.isSuccess,
    required this.transactionId,
});

  Map<String,dynamic> toJson(){
    return{
      'bookingDetails':bookingDetails.toJson(),
      'paymentMethod':paymentMethod,
      'isSuccess':isSuccess,
      'trasnsactionId': transactionId,
      'timestamp':DateTime.now().toIso8601String(),
      'userId': FirebaseAuth.instance.currentUser?.uid,
    };
  }
}