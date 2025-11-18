import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_team/models/movie.dart';

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
