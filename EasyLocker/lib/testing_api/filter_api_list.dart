import 'package:EasyLocker/app/filterscreen.dart';
import 'package:EasyLocker/controllers/home_screen_controller/add_tags_controller.dart';
import 'package:EasyLocker/controllers/home_screen_controller/get_tags_controller.dart';
import 'package:EasyLocker/utils/app_assets.dart';
import 'package:EasyLocker/utils/app_colors.dart';
import 'package:EasyLocker/utils/app_string_text.dart';
import 'package:EasyLocker/utils/app_text.dart';
import 'package:EasyLocker/widget/custom_button.dart';
import 'package:EasyLocker/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterNewScreen extends StatefulWidget {
  final String categoryId;
  const FilterNewScreen({super.key, required this.categoryId});

  @override
  State<FilterNewScreen> createState() => _FilterNewScreenState();
}

class _FilterNewScreenState extends State<FilterNewScreen> {
  final AddTagsController addCardController = Get.put(AddTagsController());
  final GetTagsController getTagsController = Get.put(GetTagsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homebackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.homebackgroundColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(Assets.backbutton),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.lockericons),
            kWidth(5),
            Text(
              'EasyLocker',
              style: GoogleFonts.titilliumWeb(
                  fontSize: 28,
                  color: AppColors.icontextColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              bottomsheet(
                context,
                Apptext.AddTagtitle,
                Apptext.Entertagname,
                addCardController.texttagsController,
                CustomButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if (addCardController.texttagsController.text.isEmpty) {
                      ToastUtil.showToast("Please enter a tags");
                    } else {
                      addCardController.AddTags(widget.categoryId);
                    }
                  },
                  children: [
                    Obx(
                      () => addCardController.AddTagsLoading.value
                          ? centerLoader()
                          : PrimaryText(
                              text: Apptext.Savebutton,
                              color: AppColors.white,
                            ),
                    )
                  ],
                ),
                (value) {},
              ).then((value) async {
                print("Bottom sheet dismissed, updating tags...");
                addCardController.texttagsController.text = "";
                await getTagsController.getTagslist(widget.categoryId, true);
                print("Tags updated");
              }).catchError((error) {
                print("Error updating tags: $error");
              });
            },
            child: SvgPicture.asset(Assets.tabaddicons),
          ),
          kWidth(25),
        ],
      ),
      body:
          FilterListView(categoryId: widget.categoryId), // Pass categoryId here
    );
  }
}

class FilterListView extends StatefulWidget {
  final String categoryId;

  const FilterListView({super.key, required this.categoryId});

  @override
  _FilterListViewState createState() => _FilterListViewState();
}

class _FilterListViewState extends State<FilterListView> {
  final GetTagsController getTagsController = Get.put(GetTagsController());
  // List to hold selected tags
  final GetStorage storage = GetStorage();
  final String storageKey = 'selectedTags';

  @override
  void initState() {
    super.initState();
    // Initial fetch
    getTagsController.getTagslist(widget.categoryId, true);
    // Load tags from local storage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTagsFromLocal();
    });
  }

  void _saveTagsLocally() {
    // Group tags by categoryId before saving
    List<Map<String, dynamic>> tagJsonList =
        getTagsController.selectedTags.map((tagRespons) {
      return {
        'categoryid': tagRespons
            .categoryid, // Use the categoryId from the TagRespons object
        'tag': tagRespons.tag?.map((tag) => tag.toJson()).toList() ?? [],
      };
    }).toList();

    storage.write(storageKey, tagJsonList);
    print(
        '_saveTagsLocally:-${storage.read(storageKey)}'); // For debugging purposes
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
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () {
            if (getTagsController.getTagsLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            final tags = getTagsController.getTagsResponse.value?.result;
            if (tags != null && tags.isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    final tag1 = tags[index];
                    bool isSelected = getTagsController.selectedTags.any((t) =>
                        t.tag?.any((tag) => tag.tagid == tag1.sId) ?? false);

                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tag1.tag ?? "", // Display the tag name
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              Checkbox(
                                  side: BorderSide(color: Colors.white),
                                  fillColor: MaterialStateProperty.all(
                                      isSelected ? Colors.blue : Colors.white),
                                  checkColor: Colors.white,
                                  value: isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        // Find or create TagRespons for the category
                                        var existingRespons = getTagsController
                                            .selectedTags
                                            .firstWhere(
                                          (t) =>
                                              t.categoryid == widget.categoryId,
                                          orElse: () => TagRespons(
                                              categoryid: widget.categoryId,
                                              tag: []),
                                        );

                                        // Add the tag to the list if it doesn't already exist
                                        if (existingRespons.tag == null) {
                                          existingRespons.tag = [];
                                        }
                                        if (!existingRespons.tag!
                                            .any((t) => t.tagid == tag1.sId)) {
                                          existingRespons.tag!.add(Tag(
                                            tagid: tag1.sId!,
                                            tagname: tag1.tag ?? "",
                                          ));
                                        }

                                        // If it was a new entry, add it to selectedTags
                                        if (!getTagsController.selectedTags
                                            .contains(existingRespons)) {
                                          getTagsController.selectedTags
                                              .add(existingRespons);
                                        }
                                      } else {
                                        // Remove the tag from the list
                                        getTagsController.selectedTags
                                            .forEach((t) {
                                          t.tag?.removeWhere(
                                              (tag) => tag.tagid == tag1.sId);
                                        });
                                        // Remove any empty TagRespons objects
                                        getTagsController.selectedTags
                                            .removeWhere(
                                                (t) => t.tag?.isEmpty ?? true);
                                      }

                                      // Save updated tags
                                      _saveTagsLocally();
                                    });
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text("No tags available"));
            }
          },
        ),
        Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width, 48),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {
              // Save tags when the button is pressed
              _saveTagsLocally();
            },
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TagRespons {
  String? categoryid;
  List<Tag>? tag;

  TagRespons({this.categoryid, this.tag});

  TagRespons.fromJson(Map<String, dynamic> json) {
    categoryid = json['categoryid'];
    if (json['tag'] != null) {
      tag = <Tag>[];
      json['tag'].forEach((v) {
        tag!.add(new Tag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryid'] = this.categoryid;
    if (this.tag != null) {
      data['tag'] = this.tag!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tag {
  String? tagid;
  String? tagname;

  Tag({this.tagid, this.tagname});

  Tag.fromJson(Map<String, dynamic> json) {
    tagid = json['tagid'];
    tagname = json['tagname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagid'] = this.tagid;
    data['tagname'] = this.tagname;
    return data;
  }
}
