// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardModel {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  String id;
  int createdAt;

  CardModel({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.id,
    required this.createdAt,
  });

  CardModel copyWith({
    String? cardNumber,
    String? expiryDate,
    String? cardHolderName,
    String? cvvCode,
    String? id,
    int? createdAt,
  }) {
    return CardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cvvCode: cvvCode ?? this.cvvCode,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cardHolderName': cardHolderName,
      'cvvCode': cvvCode,
      'id': id,
      'createdAt': createdAt,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      cardNumber: map['cardNumber'] as String,
      expiryDate: map['expiryDate'] as String,
      cardHolderName: map['cardHolderName'] as String,
      cvvCode: map['cvvCode'] as String,
      id: map['id'] as String,
      createdAt: map['createdAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) =>
      CardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardModel(cardNumber: $cardNumber, expiryDate: $expiryDate, cardHolderName: $cardHolderName, cvvCode: $cvvCode, id: $id, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant CardModel other) {
    if (identical(this, other)) return true;

    return other.cardNumber == cardNumber &&
        other.expiryDate == expiryDate &&
        other.cardHolderName == cardHolderName &&
        other.cvvCode == cvvCode &&
        other.id == id &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return cardNumber.hashCode ^
        expiryDate.hashCode ^
        cardHolderName.hashCode ^
        cvvCode.hashCode ^
        id.hashCode ^
        createdAt.hashCode;
  }
}
