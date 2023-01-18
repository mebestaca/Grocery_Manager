class ItemModel{

  final String name;
  final int amount;
  final int threshold;
  final String tag;
  final String uom;

  ItemModel({this.name="", this.amount=0, this.threshold=0, this.tag= "", this.uom=""});

  static const String fieldName = "NAME";
  static const String fieldAmount = "AMOUNT";
  static const String fieldThreshold = "THRESHOLD";
  static const String fieldTag = "TAGS";
  static const String fieldUOM = "UOM";

  static const String tagLow = "LOW";

  static String getTag({int amount=0, int threshold=0}) {
    return amount > threshold ? "" : ItemModel.tagLow;
  }

  ItemModel.fromJson(Map<String, Object?> json) :
        this(
          name: json[fieldName] as String,
          amount: json[fieldAmount] as int,
          threshold: json[fieldThreshold] as int,
          uom: json[fieldUOM] as String,
          tag:  json[fieldTag] as String
      );

  Map<String, Object?> toJson() {
    return {
      fieldName : name,
      fieldAmount : amount,
      fieldThreshold : threshold,
      fieldUOM : uom,
      fieldTag : tag
    };
  }


}