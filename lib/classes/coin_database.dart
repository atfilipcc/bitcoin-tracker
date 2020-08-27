class CoinDatabase {
  List<String> _currenciesList = [
    'AUD',
    'BRL',
    'CAD',
    'CNY',
    'EUR',
    'GBP',
    'HKD',
    'IDR',
    'ILS',
    'INR',
    'JPY',
    'MXN',
    'NOK',
    'NZD',
    'PLN',
    'RON',
    'RUB',
    'SEK',
    'SGD',
    'USD',
    'ZAR'
  ];

  List<String> _cryptoList = [
    'BTC',
    'ETH',
    'LTC',
  ];

  List<String> getCurrencyList() {
    return this._currenciesList;
  }

  List<String> getCryptoList() {
    return this._cryptoList;
  }
}
