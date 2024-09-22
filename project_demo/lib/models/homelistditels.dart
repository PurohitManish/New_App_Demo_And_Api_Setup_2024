import 'package:EasyLocker/utils/app_assets.dart';

class HomeListDitelsModel {
  final int id;
  final String image1;
  final String image2;
  final String image3;
  final String description;
  final String date;
  final String time;

  HomeListDitelsModel({
    required this.id,
    required this.description,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.date,
    required this.time,
  });
}

List<HomeListDitelsModel> homeListDitelsModel = [
  HomeListDitelsModel(
      id: 1,
      image1: Assets.image1,
      image2: Assets.image2,
      image3: Assets.image3,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
      date: '1st March, 2024',
      time: '4:30 AM'),
  HomeListDitelsModel(
      id: 2,
      image1: Assets.image1,
      image2: Assets.image2,
      image3: Assets.image3,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
      date: '1st March, 2024',
      time: '4:30 AM'),
  HomeListDitelsModel(
      id: 3,
      image1: Assets.image1,
      image2: Assets.image2,
      image3: Assets.image3,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
      date: '1st March, 2024',
      time: '4:30 AM'),
  HomeListDitelsModel(
      id: 4,
      image1: Assets.image1,
      image2: Assets.image2,
      image3: Assets.image3,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
      date: '1st March, 2024',
      time: '4:30 AM'),
  HomeListDitelsModel(
      id: 5,
      image1: Assets.image1,
      image2: Assets.image2,
      image3: Assets.image3,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
      date: '1st March, 2024',
      time: '4:30 AM'),
];
