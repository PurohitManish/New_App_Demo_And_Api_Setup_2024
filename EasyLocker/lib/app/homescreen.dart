import 'package:EasyLocker/app/tab1/tab1.dart';
import 'package:EasyLocker/controllers/home_screen_controller/add_category_controller.dart';
import 'package:EasyLocker/controllers/home_screen_controller/get_category_controller.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';

import 'package:EasyLocker/utils/utils.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen>
    with SingleTickerProviderStateMixin {
  final AddCategoryController addCategoryController =
      Get.put(AddCategoryController());
  final GetCategoryController getCategoryController =
      Get.put(GetCategoryController());
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCategoryController.getCategorylist();
    });
    _tabController = TabController(length: 10, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homebackgroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.homebackgroundColor,
        leading: Padding(
            padding: EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              Assets.whatsapp,
              height: 20,
            )),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.lockericons),
            kWidth(5),
            Text(
              Apptext.EasyLocker,
              style: GoogleFonts.titilliumWeb(
                  fontSize: 28,
                  color: AppColors.icontextColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        //flexibleSpace:
        automaticallyImplyLeading: false,

        actions: [
          InkWell(
              onTap: () {
                bottomsheet(
                  context,
                  Apptext.Addcategory,
                  Apptext.Entercategory,
                  addCategoryController.textcategoryController,
                  CustomButton(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        if (addCategoryController
                            .textcategoryController.text.isEmpty) {
                          ToastUtil.showToast("Please enter a category");
                        } else {
                          addCategoryController.AddCategory(context);
                        }
                      },
                      children: [
                        Obx(
                          () => addCategoryController.AddCategoryLoading.value
                              ? centerLoader()
                              : PrimaryText(
                                  text: Apptext
                                      .Savebutton, // Ensure this is properly initialized
                                  color: AppColors.white,
                                ),
                        )
                      ]),
                  () {},
                ).then((value) {
                  addCategoryController.textcategoryController.text = "";
                });
              },
              child: SvgPicture.asset(Assets.tabaddicons)),
          kWidth(25)
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 45,
            //padding: EdgeInsets.symmetric(v),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.name,
              style: GoogleFonts.urbanist(fontSize: 14, color: AppColors.white),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.searchbarColors,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.searchbarColors)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.searchbarColors)),
                  contentPadding: EdgeInsets.only(left: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.searchbarColors)),
                  hintText: 'Search',
                  hintStyle: GoogleFonts.urbanist(
                      color: AppColors.searchbartextColors),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.searchbartextColors,
                  )),
            ),
          ),
          kHeight(5),
          TabBar(
            isScrollable: true,
            indicatorColor: AppColors.icontextColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: GoogleFonts.urbanist(
                fontSize: 16, color: AppColors.icontextColor),
            unselectedLabelColor: AppColors.white,
            tabAlignment: TabAlignment.start,
            dividerColor: AppColors.dividerColor,
            padding: EdgeInsets.only(left: 10),
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
              Tab(text: 'Tab 4'),
              Tab(text: 'Tab 5'),
              Tab(text: 'Tab 6'),
              Tab(text: 'Tab 7'),
              Tab(text: 'Tab 8'),
              Tab(text: 'Tab 9'),
              Tab(text: 'Tab 10'),
            ],
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              physics: ScrollPhysics(),
              controller: _tabController,
              children: [
                Container(
                    color: AppColors.homebackgroundColor,
                    child: Tab_1(
                      context: context,
                    )),
                //Container(color: Colors.red),
                Container(color: Colors.pink),
                Container(color: Colors.amber),
                Container(color: Colors.cyan),
                Container(color: Colors.purpleAccent),
                Container(color: Colors.pink),
                Container(color: Colors.purpleAccent),
                Container(color: Colors.amber),
                Container(color: Colors.cyan),
                Container(color: Colors.amber),
              ],
            ),
          ),
        ],
      ),
    );
    //));
  }
}
