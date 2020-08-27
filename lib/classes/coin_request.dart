import 'package:bitcoin_ticker/utils/network_helper.dart';
import '../classes/coin_database.dart';

const apiKey = 'API-KEY-HERE';

class CoinRequest {
  CoinDatabase coinDatabase = CoinDatabase();

  String currency;
  String currencyToCheckRate;

  CoinRequest({this.currency, this.currencyToCheckRate});

  Future<dynamic> getExchangeRate() async {
    String requestUrl =
        'https://rest.coinapi.io/v1/exchangerate/$currency/$currencyToCheckRate?apikey=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(requestUrl);
    var exchangeResponse = await networkHelper.getHttpData();
    return exchangeResponse;
  }
}
