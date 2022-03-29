import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ButterfliesList(),
        appBar: AppBar(
          title: Text("Бабочки", style: TextStyle(fontSize: 25)),
          centerTitle: true,
        ),
      )));
}

class Butterfly {
  String name;
  String description;

  static const List<String> _butterflies = [
    "Крапивница",
    "Павлиний глаз",
    "Капустница",
    "Голубянка алексис",
    "Голубянка аргус",
    "Переливница большая",
    "Траурница",
    "Червонец фиолетовый",
  ];

  static const List<String> _butterfliesDescription = [
    'Дневная бабочка среднего размера имеет размах крыльев 42-62 мм. Основной фон крыльев – кирпично-красный. При благоприятных обстоятельствах она проживает долгую жизнь – 9 месяцев',
    'Основной фон крыльев красно-бурый, красно-коричневый. На крыльях располагаются 4 крупных «глазка» с голубыми пятнами. Активны только при свете солнца. Как правило, срок жизни не превышает 3-х недель',
    'Капустница или белянка капустная Окраска крыльев капустницы зависит от покрывающей их пыльцы. Если дотронуться до крыльев бабочки пальцами, то на них остается пыльца, а крылья теряют свою окраску.',
    'Голубянка Алексис - редкий вид, внесен в Красную книгу Карелии. Крылья самцов сверху фиолетово-синие, с чёрной каймой шириной до 1 мм; у самок — бурые, с напылением синих чешуек у корня. Время лета длится с конца мая до июля',
    'Самцы насыщенного синего цвета, а самки – неброского коричневого. Крылья обрамляет изящная черная кайма с характерной для вида бахромой. Бабочки появляются в начале июня и живут до августа',
    'Бабочка имеет темно-коричневую общую окраску. Размах крыльев 60—70 мм, крылья с синим отливом. Лет бабочки в июне — августе. Переливница большая часто садится на дорожную грязь, свежий навоз, пьет сок растений',
    'В Америке ее называют траурная мантия, во Франции ее имя переводится как скорбь. Несмотря на свое название, окрас траурницы вовсе не черный. Цвет варьируется от темно-коричневого до темно-вишневого.',
    'Крылья самца сверху с сильным фиолетовым отливом. Самки могут быть коричневыми с оранжевой каймой на задних крыльях или ярко-оранжевыми. Распространена в южной и центральной Европе',
  ];
  Butterfly(this.name, this.description);

  static List<Butterfly> getClassList() {
    var _wingClassList = <Butterfly>[];
    for (int i = 0; i < _butterflies.length; i++) {
      _wingClassList
          .add(Butterfly(_butterflies[i], _butterfliesDescription[i]));
    }
    return _wingClassList;
  }

  static List<String> getPromptList() {
    return _butterflies;
  }

  static bool isNameValid(String name) {
    return _butterflies.contains(name);
  }
}

class ButterfliesList extends StatefulWidget {
  @override
  _ButterfliesListState createState() => _ButterfliesListState();
}

String _description = "";

class _ButterfliesListState extends State<ButterfliesList> {
  final _text = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  var _wingClassList = <Butterfly>[];

  final _controller = TextEditingController();

  int _selectedIndex = -1;

  int _getIndex(String name) {
    if (Butterfly.isNameValid(name)) {
      for (Butterfly b in _wingClassList) {
        if (b.name == name) return _wingClassList.indexOf(b);
      }
    }
    return -1;
  }

  @override
  void initState() {
    _wingClassList = Butterfly.getClassList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                  labelText: "Найти бабочку",
                  errorText: _validate ? 'Введите название бабочки' : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {
                  _selectedIndex = _getIndex(value);

                  if (_selectedIndex != -1) {
                    _description = _wingClassList[_selectedIndex].description;
                  } else {
                    _description = "Такой бабочки нет в списке";
                  }
                });
              }),
          const SizedBox(height: 10),
          Row(
            children: [
              RaisedButton(
                  onPressed: () {
                    setState(() {
                      _text.text.isEmpty ? _validate = true : _validate = false;
                    });
                  },
                  child: Text('Проверить'),
                  textColor: Colors.black38,
                  color: Colors.white),
            ],
          ),
          Container(
            height: 100.0,
            child: ListView.separated(
              padding: const EdgeInsets.all(10.0),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 100.0, width: 10.0),
              itemCount: _wingClassList.length,
              itemBuilder: _createListView,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _description,
            style: const TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget _createListView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _description = _wingClassList[index].description;

          _selectedIndex = index;
        });
      },
      child: Container(
        height: 200.0,
        width: 250.0,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(
                color:
                    index == _selectedIndex ? Colors.lightBlue : Colors.black12,
                width: 3.0),
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        child: Row(children: [
          const SizedBox(width: 10),
          const Image(
            image: AssetImage('assets/images/butterfly.png'),
            height: 34,
          ),
          const SizedBox(width: 15),
          Text(
            _wingClassList[index].name,
            style: const TextStyle(fontSize: 15.0),
          ),
        ]),
      ),
    );
  }
}
