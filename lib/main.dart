import 'package:aes_encrypt_decrypt/CustomElevatedButton.dart';
import 'package:encrypt/encrypt.dart' as e;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class EncryptData {
//for AES Algorithms

  static e.Encrypted? encrypted;
  // ignore: prefer_typing_uninitialized_variables
  static var decrypted;

  static encryptAES(plainText) {
    final key = e.Key.fromUtf8('my 32 length key................');
    final iv = e.IV.fromLength(16);
    final encrypter = e.Encrypter(e.AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    if (kDebugMode) {
      print(encrypted!.base64);
    }
  }

  static decryptAES(plainText) {
    final key = e.Key.fromUtf8('my 32 length key................');
    final iv = e.IV.fromLength(16);
    final encrypter = e.Encrypter(e.AES(key));
    decrypted = encrypter.decrypt(encrypted!, iv: iv);
    if (kDebugMode) {
      print(decrypted);
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();
  List<ButtonData> buttonData = [];

  @override
  Widget build(BuildContext context) {
    buttonData = <ButtonData>[
      ButtonData('Encryption', () {
        setState(() {
          EncryptData.encryptAES(_controller.text);
        });
      }),
      ButtonData('Decryption', () {
        setState(() {
          EncryptData.decryptAES(_controller.text);
        });
      }),
      ButtonData('Clear', () {
        setState(() {
          _controller.clear();
          EncryptData.encrypted = null;
          EncryptData.decrypted = '';
        });
      })
    ];
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          title: const Text("Encrypt and Decrypt Data"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: _buildBody(),
            ),
          ),
        ));
  }

  Widget _buildBody() {
    return Container(
      height: 280,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 2,
        child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Text',
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "EncryptText : ${EncryptData.encrypted != null ? EncryptData.encrypted?.base64 : ''}",
                maxLines: 2,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text("DecryptText : ${EncryptData.decrypted ?? ''}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontSize: 16)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 0; i < buttonData.length; i++) ...{
                    CustomElevatedButton(
                        buttonText: buttonData[i].buttonname,
                        onPressed: buttonData[i].onPressed),
                  }
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonData {
  String buttonname;
  void Function()? onPressed;

  ButtonData(this.buttonname, this.onPressed);
}
