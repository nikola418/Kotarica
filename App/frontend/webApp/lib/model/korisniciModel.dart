import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert' as convert;

import '../main.dart';
import 'ether_setup.dart';

class KorisniciModel extends ChangeNotifier {
  Korisnik ulogovaniKorisnik;

  var abiCode; //ovde ce da bude smesten json file iz src/abis/korisnici.json
  EthereumAddress adresaUgovora;

  Credentials credentials;
  EthereumAddress nasaAdresa;

  DeployedContract ugovor;

  int brKorisnika = 0;
  //F-je na ethereumu
  ContractFunction brojKorisnika;
  ContractFunction korisnici;
  ContractFunction korisniciMail;
  ContractFunction logovanje;
  ContractFunction proveriUsername;
  ContractFunction dodajKorisnika;
  ContractFunction _dodajSliku;
  ContractFunction _izmeniKorisnika;

  Web3Client client;

  KorisniciModel() {
    inicijalnoSetovanje();
  }

  Future<void> inicijalnoSetovanje() async {
    client = Web3Client(rpcUrl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedCotract();
    //Korisnik k = await vratiKorisnikaMail("mika.mikic@gmail.com");
    //print(k.ime);

    //await dodavanjeNovogKorisnika("mika@mikic", "mika", "Mika", "Mikic", "mika.mikic@gmail.com", "060987654321", "2/2");
    /*int broj = await login("mika@mikic", "mika");
    if(broj > 0) {
      print(ulogovaniKorisnik.ime + " " + ulogovaniKorisnik.prezime);
    }*/
    // await dodajSliku(1, "promena");
    // print("promenio sam");
    //await izmeniKorisnika(4, "Milos", "Ivanovic", "0000000000", "Nepoznata, 12, 34000");
    notifyListeners();
  }

  Future<void> getAbi() async {
    /**************************  WEB  ********************************** */
    // String abiStringFile =
    //     await rootBundle.loadString("assets/src/Korisnici.json");

    // var jsonAbi = jsonDecode(abiStringFile);
    /**************************  WEB  ********************************** */

    /**************************  MOB  ********************************** */
    final response =
        await http.get(Uri.http('147.91.204.116:11096', 'Korisnici.json'));
    var jsonAbi;
    if (response.statusCode == 200) {
      jsonAbi = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from server');
    }
    /**************************  MOB  ********************************** */

    abiCode = jsonEncode(jsonAbi["abi"]);

    adresaUgovora =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);

    //print(adresaUgovora);
  }

  Future<void> getCredentials() async {
    //ovde smo dobili nasu javnu adresu uz pomocom privatnog kljuca
    credentials = await client.credentialsFromPrivateKey(privatniKljuc);
    nasaAdresa = await credentials.extractAddress();
  }

  //Ovde treba da budu navedene sve f-je koje se nalaze na ugovoru
  Future<void> getDeployedCotract() async {
    ugovor = DeployedContract(
        ContractAbi.fromJson(abiCode, "Korisnici"), adresaUgovora);

    brojKorisnika = ugovor.function("brojKorisnika");
    korisnici = ugovor.function("korisnici");
    korisniciMail = ugovor.function("korisniciMail");
    logovanje = ugovor.function("prijavljivanje");
    proveriUsername = ugovor.function("proveriUsername");
    dodajKorisnika = ugovor.function("dodajKorisnika");
    _dodajSliku = ugovor.function("dodajSliku");
    _izmeniKorisnika = ugovor.function("izmeniKorisnika");
  }

  //Logovanje
  Future<int> login(String username, String password) async {
    var temp = await client.call(
        contract: ugovor, function: logovanje, params: [username, password]);
    //Vraca nula ako nije nasao username i password
    //id korisnika ako ga je nasao
    BigInt tempInt = temp[0];
    int _id = tempInt.toInt();
    print(_id);
    if (_id > 0) {
      await vratiKorisnika(_id);
      print("Prijavio");
      return _id;
    } else {
      print("Nisam");
      return 0;
    }
  }

  //Setuje prijavljenog korisnika
  Future<void> vratiKorisnika(int _id) async {
    ulogovaniKorisnik = await dajKorisnikaZaId(_id);
  }

  Future<Korisnik> dajKorisnikaZaId(int _idKorisnika) async {
    Korisnik kor = Korisnik(
        id: 0,
        mail: "",
        password: "",
        ime: "",
        prezime: "",
        brojTelefona: "",
        adresa: "",
        slika: "");

    if (_idKorisnika > 0) {
      var k = await client.call(
          contract: ugovor,
          function: korisnici,
          params: [BigInt.from(_idKorisnika)]);

      kor = Korisnik(
          id: _idKorisnika,
          mail: k[1],
          password: k[2],
          ime: k[3],
          prezime: k[4],
          brojTelefona: k[5],
          adresa: k[6],
          slika: k[7]);
    }

    return kor;
  }

  //Registracija
  //dodavanjeNovogKorisnika(String)
  dodavanjeNovogKorisnika(String _mail, String _password, String _ime,
      String _prezime, String _broj, String _adresa) async {
    int postoji;

    postoji = await proveraDaLiPostojiUsername(_mail);
    if (postoji == 1) {
      // znaci da ne postoji taj username
      var k = await client.sendTransaction(
          credentials,
          Transaction.callContract(
              maxGas: 6721975,
              contract: ugovor,
              function: dodajKorisnika,
              parameters: [_mail, _password, _ime, _prezime, _broj, _adresa]));
      if (k != 0) {
        return await login(_mail, _password);
      }
    }

    // kada se uspesno registrovao, odma prijavimo tog korisnika
  }

  Future<int> proveraDaLiPostojiUsername(String _username) async {
    var k = await client
        .call(contract: ugovor, function: proveriUsername, params: [_username]);

    BigInt tempInt = k[0];
    return tempInt.toInt();
  }

  Future<Korisnik> vratiKorisnikaMail(String mail) async {
    if (mail != "") {
      var k = await client
          .call(contract: ugovor, function: korisniciMail, params: [mail]);

      BigInt bigId = k[0];
      int _id = bigId.toInt();
      if (_id != 0 || _id != null) {
        return Korisnik(
            id: _id,
            mail: k[1],
            password: k[2],
            ime: k[3],
            prezime: k[4],
            brojTelefona: k[5],
            adresa: k[6],
            slika: k[7]);
      }
    }
  }

  Future<void> dodajSliku(int id, String slika) async {
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            maxGas: 6721975,
            contract: ugovor,
            function: _dodajSliku,
            parameters: [BigInt.from(id), slika]));
  }

  Future<void> izmeniKorisnika(int _idKorisnika, String ime, String prezime,
                                String broj, String adresa) async {
     await client.sendTransaction(
          credentials,
          Transaction.callContract(
              maxGas: 6721975,
              contract: ugovor,
              function: _izmeniKorisnika,
              parameters: [BigInt.from(_idKorisnika), ime, prezime,
                                      broj, adresa]));
  }

  static Map<String, String> header = {
    "Access-Control_Allow_Origin": "*",
    'Content-type': 'application/json',
    //; charset=utf-8
    'Accept': 'application/json',
    //'Authorization': 'Authorize'
  };

  static Future<String> checkUser(String email, String password) async {
    Uri urlPom = Uri(path: url + 'Token/authenticate');
    var decoded = Uri.decodeComponent(urlPom.toString());
    //print('url ' + urlPom.toString());
    var data = Map();
    data['username'] = email;
    data['password'] = password;
    var jsonBody = convert.jsonEncode(data);
    //print('jsonBody ' + jsonBody.toString());
    var res =
        await http.post(Uri.parse(decoded), headers: header, body: jsonBody);
    String data2 = res.body.toString();
    // print(res.statusCode.toString());
    if (res.statusCode != 200) return ('false');
    return data2;
  }
}

class Korisnik {
  int id;
  String mail;
  String password;
  String ime;
  String prezime;
  String brojTelefona;
  String adresa;
  String slika;

  Korisnik(
      {this.id,
      this.mail,
      this.password,
      this.ime,
      this.prezime,
      this.brojTelefona,
      this.adresa,
      this.slika});

  Korisnik.clone(Korisnik cl)
      : this(
            id: cl.id,
            mail: cl.mail,
            password: cl.password,
            ime: cl.ime,
            prezime: cl.prezime,
            brojTelefona: cl.brojTelefona,
            adresa: cl.adresa,
            slika: cl.slika);
}
