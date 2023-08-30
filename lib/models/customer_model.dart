class CustomerData {
  String? name;
  String? phone;
  num? balance;

  CustomerData({
    this.name,
  });

  CustomerData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    balance = json['balance'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'balance': balance,
    };
  }
}