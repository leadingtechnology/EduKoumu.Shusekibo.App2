class SeatConfiguration {
  SeatConfiguration({
    required this.seatOrder,
    required this.name,
  });

  final int seatOrder;
  final String name;

  factory SeatConfiguration.fromJson(Map<String, dynamic> json) {
    return SeatConfiguration(
      seatOrder: json['SeatOrder'] as int,
      name: json['name'] as String,
    );
  }
}

List<SeatConfiguration> seatConfigurations = [
  SeatConfiguration(seatOrder: 1, name: '横方向 左→右'),
  SeatConfiguration(seatOrder: 2, name: '横方向 右→左'),
  SeatConfiguration(seatOrder: 3, name: '縦方向 上→下'),
  SeatConfiguration(seatOrder: 4, name: '縦方向 下→上'),
];
