// Define a structure to hold your counts
class SellerCounts {
  final int total;
  final int active;
  final int blocked;
  final int pending; // Good to track pending too!

  SellerCounts({
    required this.total,
    required this.active,
    required this.blocked,
    required this.pending,
  });
}
