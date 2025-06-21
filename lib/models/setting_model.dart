class SettingModel {
  final int settingId;
  final int buyPrice;
  final int sellPrice;
  final int undoSellPrice;
  final int undiBuyPrice;
  final int mainAccount;

  SettingModel({
    required this.settingId,

    required this.buyPrice,
    required this.sellPrice,
    required this.undoSellPrice,
    required this.undiBuyPrice,
    required this.mainAccount,
  });
  factory SettingModel.fromJson(json) {
    return SettingModel(
      settingId: json['SETTING_ID'],
      buyPrice: json['BUY_PRICE'],
      sellPrice: json['SELL_PRICE'],
      undoSellPrice: json['UNDO_SELL_PRICE'],
      undiBuyPrice: json['UNDO_BUY_PRICE'],
      mainAccount: json['MAIN_ACCOUNT'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'SETTING_ID': settingId,
      'BUY_PRICE': buyPrice,
      'SELL_PRICE': sellPrice,
      'UNDO_SELL_PRICE': undoSellPrice,
      'UNDO_BUY_PRICE': undiBuyPrice,
      'MAIN_ACCOUNT': mainAccount,
    };
  }
}
