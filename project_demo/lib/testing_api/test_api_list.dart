import 'package:EasyLocker/app/filterscreen.dart';
import 'package:EasyLocker/app/settings/settingscreen.dart';
import 'package:EasyLocker/controllers/home_screen_controller/add_card_controller.dart';
import 'package:EasyLocker/controllers/home_screen_controller/add_category_controller.dart';
import 'package:EasyLocker/controllers/home_screen_controller/get_category_controller.dart';
import 'package:EasyLocker/controllers/home_screen_controller/get_tags_controller.dart';
import 'package:EasyLocker/testing_api/filter_api_list.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class TestApi extends StatefulWidget {
  const TestApi({super.key});

  @override
  _TestApiState createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> with TickerProviderStateMixin {
  final GetStorage storage = GetStorage();
  final String storageKey = 'selectedTags';
  late final GetCategoryController controller;
  TabController? _tabController;
  final AddCategoryController addCategoryController =
      Get.put(AddCategoryController());
  final GetCategoryController getCategoryController =
      Get.put(GetCategoryController());
  final AddCardController addCardController = Get.put(AddCardController());
  final GetTagsController getTagsController = Get.put(GetTagsController());
  var categoryid = "";

  @override
  void initState() {
    super.initState();
    init();
    _loadTagsFromLocal();
  }

  Future<void> init() async {
    controller = Get.put(GetCategoryController());
    await controller.getCategorylist();

    ever(controller.getCategoryResponse, (_) {
      final categories = controller.getCategoryResponse.value.result;
      if (categories != null) {
        setState(() {
          _tabController = TabController(
            length: categories.length,
            vsync: this,
          );
        });
      }
    });
  }

  void _loadTagsFromLocal() {
    // Load selected tags from local storage
    List<dynamic>? storedTagJsonList = storage.read(storageKey);
    if (storedTagJsonList != null) {
      setState(() {
        getTagsController.selectedTags.value = storedTagJsonList.map((json) {
          return TagRespons.fromJson(json as Map<String, dynamic>);
        }).toList();
      });
    }
  }

  void _handleCancel(String categoryId) {
    // Check if categoryId is valid
    if (categoryId.isEmpty) {
      print('Invalid categoryId');
      return;
    }

    // Remove tags related to the given categoryId
    int initialLength = getTagsController.selectedTags.length;
    getTagsController.selectedTags.removeWhere((t) {
      print('t:-${t.categoryid}');
      return t.categoryid == categoryId;
    });
    int removedCount = getTagsController.selectedTags.length;

    // Print the number of removed tags
    print('Tags removed: $removedCount');

    // Save the updated list to local storage
    _saveTagsLocally();
  }

  void _saveTagsLocally() {
    List<Map<String, dynamic>> tagJsonList =
        getTagsController.selectedTags.map((tagRespons) {
      return {
        'categoryid': tagRespons.categoryid,
        'tag': tagRespons.tag?.map((tag) => tag.toJson()).toList() ?? [],
      };
    }).toList();

    storage.write(storageKey, tagJsonList);
    print(
        '_saveTagsLocally: ${storage.read(storageKey)}'); // For debugging purposes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homebackgroundColor,
      appBar: AppBar(
        toolbarHeight: 130,
        backgroundColor: AppColors.homebackgroundColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            Assets.whatsapp,
            height: 20,
          ),
        ),
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
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () async {
              await bottomsheet(
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
                    Obx(() => addCategoryController.AddCategoryLoading.value
                        ? centerLoader()
                        : PrimaryText(
                            text: Apptext.Savebutton,
                            color: AppColors.white,
                          )),
                  ],
                ),
                () {},
              ).then((value) async {
                addCategoryController.textcategoryController.text = "";
                await controller.getCategorylist();
              });
            },
            child: SvgPicture.asset(Assets.tabaddicons),
          ),
          kWidth(25),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Column(
            children: [
              Container(
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  style: GoogleFonts.urbanist(
                      fontSize: 14, color: AppColors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.searchbarColors,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.searchbarColors),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.searchbarColors),
                    ),
                    contentPadding: EdgeInsets.only(left: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.searchbarColors),
                    ),
                    hintText: 'Search',
                    hintStyle: GoogleFonts.urbanist(
                        color: AppColors.searchbartextColors),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.searchbartextColors,
                    ),
                  ),
                ),
              ),
              Obx(() {
                final categories = controller.getCategoryResponse.value.result;
                if (controller.getCategoryLoading.value) {
                  return const SizedBox();
                }

                if (categories != null && categories.isNotEmpty) {
                  if (_tabController == null ||
                      _tabController!.length != categories.length) {
                    _tabController = TabController(
                      length: categories.length,
                      vsync: this,
                    );
                  }

                  return TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: AppColors.icontextColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: GoogleFonts.urbanist(
                        fontSize: 16, color: AppColors.icontextColor),
                    unselectedLabelColor: AppColors.white,
                    tabAlignment: TabAlignment.start,
                    dividerColor: AppColors.dividerColor,
                    padding: EdgeInsets.only(left: 10),
                    tabs: categories
                        .map((category) => Tab(text: category.category))
                        .toList(),
                    onTap: (value) {
                      print('value:-${value}');

                      _loadTagsFromLocal();
                    },
                  );
                }

                return const SizedBox();
              }),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (controller.getCategoryLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final categories = controller.getCategoryResponse.value.result;

        if (categories != null && categories.isNotEmpty) {
          return TabBarView(
            controller: _tabController,
            children: categories.map((category) {
              categoryid = category.sId ?? "";
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 23,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: getTagsController
                                          .selectedTags.isNotEmpty &&
                                      _tabController!.index <
                                          getTagsController.selectedTags.length
                                  ? getTagsController
                                          .selectedTags[_tabController!.index]
                                          .tag
                                          ?.length ??
                                      0
                                  : 0,
                              itemBuilder: (context, index) {
                                final tags =
                                    getTagsController.selectedTags.isNotEmpty &&
                                            _tabController!.index <
                                                getTagsController
                                                    .selectedTags.length
                                        ? getTagsController
                                            .selectedTags[_tabController!.index]
                                            .tag
                                        : [];
                                return index < tags!.length
                                    ? Container(
                                        width: 65,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.searchbarColors,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: PrimaryText(
                                            text:
                                                '${tags[index].tagname ?? ""}',
                                            fontWeight: FontWeight.w500,
                                            size: 10,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      )
                                    : SizedBox
                                        .shrink(); // Return an empty widget if the index is out of bounds
                              },
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // Action for cancel button
                                _handleCancel(category.sId.toString());
                              },
                              child: SvgPicture.asset(
                                Assets.cancelbutton,
                                height: 24,
                              ),
                            ),
                            kWidth(15),
                            InkWell(
                              onTap: () {
                                Get.to(() => FilterNewScreen(
                                          categoryId: '${category.sId}',
                                        ))!
                                    .then((value) {
                                  _loadTagsFromLocal();
                                });
                              },
                              child: SvgPicture.asset(Assets.filterbutton),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Content for ${category.sId}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        }

        return const Center(child: Text('No categories found.'));
      }),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
