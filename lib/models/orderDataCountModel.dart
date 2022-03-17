class OrderDataCountModel {
  final int all;
  final int active;
  final int confirmed;
  final int cancelled;
  final int delivered;
  final int unDelivered;
  final int pending;

  OrderDataCountModel(
      {this.all = 0,
      this.active = 0,
      this.confirmed = 0,
      this.cancelled = 0,
      this.delivered = 0,
      this.unDelivered = 0,
      this.pending = 0});
}
