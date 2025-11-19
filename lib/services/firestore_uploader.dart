import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_team/models/movie.dart';
import 'package:project_team/models/booking_details.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> uploadIntialMovies(List<Movie> movies) async {
  final CollectionReference moviesCollection = _firestore.collection('movies');
  print('Bắt đầu tải lên ${movies.length} bộ phim vào Firestore...');

  for(Movie movie in movies) {
    try {
      Map<String,dynamic> movieData = movie.toJson();
      await moviesCollection.add(movieData);
      print('✅ Đã thêm thành công phim: ${movie.title}');
    } catch (e){
      print('❌ Lỗi khi thêm phim: ${movie.title}');
      print(e);
    }
      }
  print('✅ Đã tải lên ${movies.length} bộ phim vào Firestore.');
}

Future<void> uploadBooking(BookingDetails details) async {
  try {
    // 1. Lấy tham chiếu đến Collection 'bookings'
    final CollectionReference bookingsCollection = _firestore.collection('bookings');

    // 2. Chuyển đổi đối tượng BookingDetails thành Map
    Map<String, dynamic> bookingData = details.toJson();

    // 3. Sử dụng .add() để Firestore tạo ID giao dịch tự động
    await bookingsCollection.add(bookingData);

    print('✅ Đã lưu giao dịch thành công cho phim: ${details.movieTitle}');

  } catch (e) {
    print('❌ Lỗi khi lưu giao dịch: $e');
  }
}