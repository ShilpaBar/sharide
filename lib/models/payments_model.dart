// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentsModel {
  String? bankName;
  String? branchName;
  String accNo;
  String? ifscCode;
  String? accHolderName;
  bool isUpi;
  PaymentsModel({
    this.bankName,
    this.branchName,
    required this.accNo,
    this.ifscCode,
    this.accHolderName,
    this.isUpi = false,
  });

  PaymentsModel copyWith({
    String? bankName,
    String? branchName,
    String? accNo,
    String? ifscCode,
    String? accHolderName,
    bool? isUpi,
  }) {
    return PaymentsModel(
      bankName: bankName ?? this.bankName,
      branchName: branchName ?? this.branchName,
      accNo: accNo ?? this.accNo,
      ifscCode: ifscCode ?? this.ifscCode,
      accHolderName: accHolderName ?? this.accHolderName,
      isUpi: isUpi ?? this.isUpi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bankName': bankName,
      'branchName': branchName,
      'accNo': accNo,
      'ifscCode': ifscCode,
      'accHolderName': accHolderName,
      'isUpi': isUpi,
    };
  }

  factory PaymentsModel.fromMap(Map<String, dynamic> map) {
    return PaymentsModel(
      bankName: map['bankName'] != null ? map['bankName'] as String : null,
      branchName:
          map['branchName'] != null ? map['branchName'] as String : null,
      accNo: map['accNo'] as String,
      ifscCode: map['ifscCode'] != null ? map['ifscCode'] as String : null,
      accHolderName:
          map['accHolderName'] != null ? map['accHolderName'] as String : null,
      isUpi: map['isUpi'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentsModel.fromJson(String source) =>
      PaymentsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentsModel(bankName: $bankName, branchName: $branchName, accNo: $accNo, ifscCode: $ifscCode, accHolderName: $accHolderName, isUpi: $isUpi)';
  }

  @override
  bool operator ==(covariant PaymentsModel other) {
    if (identical(this, other)) return true;

    return other.bankName == bankName &&
        other.branchName == branchName &&
        other.accNo == accNo &&
        other.ifscCode == ifscCode &&
        other.accHolderName == accHolderName &&
        other.isUpi == isUpi;
  }

  @override
  int get hashCode {
    return bankName.hashCode ^
        branchName.hashCode ^
        accNo.hashCode ^
        ifscCode.hashCode ^
        accHolderName.hashCode ^
        isUpi.hashCode;
  }
}
