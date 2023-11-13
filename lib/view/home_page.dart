import 'package:flutter/material.dart';
import 'package:hesap_makinesi/widgets/button_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  var tfKontrol = TextEditingController();

  void degistir(String yazi) {
    setState(() {
      tfKontrol.text = tfKontrol.text + yazi;
    });
  }

  void topla() {
    var kontrolEdilecekIslem = tfKontrol.text;

    bossaKontrol();
    sonKarakterArtiIse(kontrolEdilecekIslem);
    ilkKarakterArtiIse(kontrolEdilecekIslem);
    artArdaIkiArtiVarsa(kontrolEdilecekIslem);

    try {
      var toplanacakIslem = tfKontrol.text;
      List<String> toplanacakElemanlar = toplanacakIslem.split('+');
      var toplam = 0.0;
      for (var eleman in toplanacakElemanlar) {
        toplam = toplam + double.parse(eleman);
      }
      setState(() {
        tfKontrol.text = toplam.toString();
      });
    } catch (e) {
      print("hata yakalandi: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bir şeyleri yanlis yaptiniz lutfen kontrol edin"),
        ),
      );
    }
  }

  void artArdaIkiArtiVarsa(String kontrolEdilecekIslem) {
    for (int i = 0; i < kontrolEdilecekIslem.length; i++) {
      if (kontrolEdilecekIslem[i] == "+") {
        // Art arda iki veya daha fazla + karakteri varsa hata mesaji
        if (i > 0 && kontrolEdilecekIslem[i - 1] == "+") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Art arda iki veya daha fazla + karakteri giremezsiniz"),
            ),
          );
        }
      }
    }
  }

  void ilkKarakterArtiIse(String kontrolEdilecekIslem) {
    if (kontrolEdilecekIslem[0] == "+") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("İlk karakter + olamaz"),
        ),
      );
    }
  }

  void sonKarakterArtiIse(String kontrolEdilecekIslem) {
    if (kontrolEdilecekIslem[kontrolEdilecekIslem.length - 1] == "+") {
      //son karakter + ise hata mesaji
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Son karakter + olamaz"),
        ),
      );
    }
  }

  void bossaKontrol() {
    if (tfKontrol.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("bir secim yapmamissiniz")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hesap Makinesi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldim(tfKontrol: tfKontrol),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: yediSekizDokuzButon(),
            ),
            dortBesAltiButon(),
            birIkiUcButon(),
            sifirCArtiButon(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          topla();
        },
        child: const Text("="),
      ),
    );
  }

  Row sifirCArtiButon() {
    return Row(
      children: [
        ButonWidget(
            text: "0",
            onPressed: () {
              degistir("0");
            }),
        ButonWidget(
            text: "C",
            onPressed: () {
              tfKontrol.text = "";
            }),
        ButonWidget(
            text: "+",
            onPressed: () {
              tfKontrol.text = "${tfKontrol.text}+";
            }),
      ],
    );
  }

  Row birIkiUcButon() {
    return Row(
      children: [
        ButonWidget(
            text: "1",
            onPressed: () {
              degistir("1");
            }),
        ButonWidget(
            text: "2",
            onPressed: () {
              degistir("2");
            }),
        ButonWidget(
            text: "3",
            onPressed: () {
              degistir("3");
            }),
      ],
    );
  }

  Row dortBesAltiButon() {
    return Row(
      children: [
        ButonWidget(
            text: "4",
            onPressed: () {
              degistir("4");
            }),
        ButonWidget(
            text: "5",
            onPressed: () {
              degistir("5");
            }),
        ButonWidget(
            text: "6",
            onPressed: () {
              degistir("6");
            }),
      ],
    );
  }

  Row yediSekizDokuzButon() {
    return Row(
      children: [
        ButonWidget(
            text: "7",
            onPressed: () {
              degistir("7");
            }),
        ButonWidget(
            text: "8",
            onPressed: () {
              degistir("8");
            }),
        ButonWidget(
            text: "9",
            onPressed: () {
              degistir("9");
            }),
        ElevatedButton(
            onPressed: () {
              tfKontrol.text = tfKontrol.text.substring(0, tfKontrol.text.length - 1);
            },
            child: const Icon(Icons.keyboard_double_arrow_left_outlined))
      ],
    );
  }
}

class TextFieldim extends StatelessWidget {
  const TextFieldim({
    super.key,
    required this.tfKontrol,
  });

  final TextEditingController tfKontrol;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tfKontrol,
      keyboardType: TextInputType.none,
      decoration: const InputDecoration(label: Text("işlem:"), border: OutlineInputBorder(borderSide: BorderSide())),
    );
  }
}
