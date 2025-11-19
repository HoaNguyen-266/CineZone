import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_team/models/transaction_display.dart';
import 'package:project_team/models/transaction_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> uploadTransaction(TransactionHistory transaction) async {
  try {
    final CollectionReference transactionsCollection =
    _firestore.collection('transactions');
    await transactionsCollection.add(transaction.toJson());
    print(
        '✅ Đã lưu LỊCH SỬ GIAO DỊCH thành công: ${transaction.transactionId}');
  } catch (e) {
    print('❌ Lỗi khi lưu lịch sử giao dịch: $e');
  }
}
Stream<List<TransactionDisplay>> getMyTransactions() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value([]);
    }
    // Lấy UID của người dùng hiện tại
    final uid = user.uid;
    return _firestore
        .collection('transactions')
    // ⭐ BỘ LỌC QUAN TRỌNG: Chỉ lấy giao dịch của người dùng này
        .where('userId', isEqualTo: uid)
        .orderBy(
        'timestamp', descending: true) // Sắp xếp theo thời gian mới nhất
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // Chuyển đổi Firestore Document thành TransactionDisplay
        return TransactionDisplay.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
}