import 'package:travel_in/models/attractions_model.dart';
import 'package:geolocator/geolocator.dart';

class Client {
  List<Attraction> getAttractions() {
    var attr = <Attraction>[
      Attraction(
        "Успенский собор",
        1,
        questions: {
          'Когда он был построен?':
              'Собор с колокольней и роскошными росписями, был построен в 2010 г. по образцу прежней церкви.',
          'Какая у него высота?': '50 метров.',
        },
        imageUrl: "https://b1.culture.ru/c/609014.jpg",
        latitude: 57.6223256680192,
        longitude: 39.9018840690959,
        rating: 4.528,
      ),
      Attraction(
        "Часовня Казанской Богоматери",
        2,
        questions: {
          'Когда она была построена?':
              'Памятник установлен в ознаменование выхода из стен монастыря в 1612 году ополчения Минина и Пожарского.',
          'Кем она была спроектирована?': 'архитектор - Г. Л. Дайнов',
        },
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/ru/b/bb/%D0%A7%D0%B0%D1%81%D0%BE%D0%B2%D0%BD%D1%8F_%D0%9A%D0%B0%D0%B7%D0%B0%D0%BD%D1%81%D0%BA%D0%BE%D0%B9_%D0%91%D0%BE%D0%B3%D0%BE%D0%BC%D0%B0%D1%82%D0%B5%D1%80%D0%B8_.jpg",
        latitude: 57.620409583131355,
        longitude: 39.890178940931484,
        rating: 4.132,
      ),
      Attraction(
        "Драматический театр им. Ф.Г. Волкова",
        3,
        questions: {
          'Когда он был основан?': 'В 1751 году',
          'Сколько в нем сцен?': 'Три',
        },
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/d/d0/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D1%82%D0%B5%D0%B0%D1%82%D1%80%D0%B0_%D0%BD%D0%B0_%D0%BF%D0%BB%D0%BE%D1%89%D0%B0%D0%B4%D0%B8_%D0%92%D0%BE%D0%BB%D0%BA%D0%BE%D0%B2%D0%B0.jpg",
        latitude: 57.62731660142579,
        longitude: 39.884653253823345,
        rating: 3.743,
      ),
      Attraction(
        "Спасо-Преображенский Мужской Монастырь",
        4,
        questions: {
          'Когда он был построен?': 'ответ',
          'Кем он был спроектирован?': 'ответ',
        },
        imageUrl:
            "https://151722.selcdn.ru/monasterium.ru/resize_cache/85389/59941cad64831bc9fd3d0170114502c0/iblock/26c/26c43f671643c63609bbed7d1b26ddd0/6.jpg",
        latitude: 57.62144666211904,
        longitude: 39.88961378511274,
        rating: 3.445,
      ),
      Attraction(
        "Казанский женский монастырь",
        5,
        questions: {},
        imageUrl:
            "https://151722.selcdn.ru/monasterium.ru/resize_cache/36280/59941cad64831bc9fd3d0170114502c0/iblock/bec/phpcjlati_448_388.jpg",
        latitude: 57.739344277642935,
        longitude: 39.93016655975159,
        rating: 2.271,
      ),
      Attraction(
        "Демидовский столп",
        6,
        questions: {},
        imageUrl:
            "https://media-cdn.tripadvisor.com/media/photo-s/08/e6/fd/9f/caption.jpg",
        latitude: 57.62518079146104,
        longitude: 39.897172482827045,
        rating: 1.48,
      ),
      Attraction(
        "Вечный огонь",
        7,
        questions: {},
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/ru/4/47/Eternal_Flame_in_Yaroslavl_01.JPG",
        latitude: 57.624742512642996,
        longitude: 39.89943861720259,
      ),
      Attraction(
        "Храм Ильи Пророка",
        8,
        questions: {},
        imageUrl:
            "https://yarwiki.ru/uploaded/b/c/bc450130f344b4cb66359302380b5e8c-1000.jpg",
        latitude: 57.62688423852188,
        longitude: 39.894442155844786,
      ),
      Attraction(
        "Церковь Ильинско-Тихоновская",
        9,
        questions: {},
        imageUrl:
            "https://photo.russian-church.ru/c7/13/36/58/5e/1000-865-9bb7c8c08aa824d8955d2093c48f9.jpg",
        latitude: 57.6223256680192,
        longitude: 39.9018840690959,
      ),
      Attraction(
        "Церковь Богоявления",
        10,
        questions: {},
        imageUrl: "https://b1.culture.ru/c/185735.jpg",
        latitude: 57.6218621149015,
        longitude: 39.886385227008226,
      ),
      Attraction(
        "Церковь Иоанна Предтечи",
        11,
        questions: {},
        imageUrl:
            "https://putidorogi-nn.ru/images/stories/evropa/rossiya/cerkov_ioanna_predtechi_v_yaroslavle_2.jpg",
        latitude: 57.61102156360037,
        longitude: 39.85687775584398,
      ),
      Attraction(
        "Церковь Михаила Архангела",
        12,
        questions: {},
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/3/3e/Saint_Michael%27s_Church_in_Yaroslavl_01.jpg",
        latitude: 57.6222126947553,
        longitude: 39.89241553864546,
      ),
      Attraction(
        "Стрелка",
        13,
        questions: {},
        imageUrl:
            "https://travellgide.ru/wp-content/uploads/2018/06/89_b5g0Qsg4.jpg",
        latitude: 57.624744330143315,
        longitude: 39.88851056022966,
      ),
      Attraction(
        "Ярославский музей- заповедник",
        14,
        questions: {},
        imageUrl:
            "https://regnum.ru/uploads/pictures/news/2015/10/14/1444821861_e32bba217ba6_normal.jpg",
        latitude: 57.621815586361116,
        longitude: 39.888493984331014,
      ),
      Attraction(
        "Музей истории города Ярославля",
        15,
        questions: {},
        imageUrl:
            "https://visityaroslavia.ru/wp-content/uploads/2019/12/muzei-istorii-goroda-yaroslavlya.jpg",
        latitude: 57.627082382520264,
        longitude: 39.898634500026176,
      ),
      Attraction(
        "Знаменская башня",
        16,
        questions: {},
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/e/e7/Znamenskaya_Tower_Yar.jpg",
        latitude: 57.62546081108764,
        longitude: 39.88502242515448,
      ),
      Attraction(
        "Музей боевой славы",
        17,
        questions: {},
        imageUrl: "https://b1.culture.ru/c/334453.jpg",
        latitude: 57.634611966292375,
        longitude: 39.832557941348725,
      ),
      Attraction(
        "Музей музыки и времени",
        18,
        questions: {},
        imageUrl:
            "https://media-cdn.tripadvisor.com/media/photo-s/08/9f/ee/97/caption.jpg",
        latitude: 57.63022700567626,
        longitude: 39.89500116748213,
      ),
    ];
    return attr;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}

final Client client = new Client();
