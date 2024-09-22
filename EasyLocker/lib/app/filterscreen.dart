// import 'package:EasyLocker/controllers/home_screen_controller/add_tags_controller.dart';
// import 'package:EasyLocker/controllers/home_screen_controller/get_tags_controller.dart';
// import 'package:EasyLocker/utils/app_assets.dart';
// import 'package:EasyLocker/utils/app_colors.dart';
// import 'package:EasyLocker/utils/app_string_text.dart';
// import 'package:EasyLocker/utils/app_text.dart';
// import 'package:EasyLocker/widget/custom_button.dart';
// import 'package:EasyLocker/utils/utils.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/utils.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_fonts/google_fonts.dart';

// class FilterScreen extends StatefulWidget {
//   final String categoryId;
//   const FilterScreen({super.key, required this.categoryId});

//   @override
//   State<FilterScreen> createState() => _FilterScreenState();
// }

// class _FilterScreenState extends State<FilterScreen> {
//   final AddTagsController addCardController = Get.put(AddTagsController());
//   final GetTagsController getTagsController = Get.put(GetTagsController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.homebackgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.homebackgroundColor,
//         leading: InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: SvgPicture.asset(Assets.backbutton),
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(Assets.lockericons),
//             kWidth(5),
//             Text(
//               'EasyLocker',
//               style: GoogleFonts.titilliumWeb(
//                   fontSize: 28,
//                   color: AppColors.icontextColor,
//                   fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         actions: [
//           InkWell(
//             onTap: () async {
//               bottomsheet(
//                 context,
//                 Apptext.AddTagtitle,
//                 Apptext.Entertagname,
//                 addCardController.texttagsController,
//                 CustomButton(
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   width: MediaQuery.of(context).size.width,
//                   onPressed: () {
//                     if (addCardController.texttagsController.text.isEmpty) {
//                       ToastUtil.showToast("Please enter a tags");
//                     } else {
//                       addCardController.AddTags(widget.categoryId);
//                     }
//                   },
//                   children: [
//                     Obx(
//                       () => addCardController.AddTagsLoading.value
//                           ? centerLoader()
//                           : PrimaryText(
//                               text: Apptext.Savebutton,
//                               color: AppColors.white,
//                             ),
//                     )
//                   ],
//                 ),
//                 (value) {},
//               ).then((value) async {
//                 print("Bottom sheet dismissed, updating tags...");
//                 addCardController.texttagsController.text = "";
//                 await getTagsController.getTagslist(widget.categoryId, true);
//                 print("Tags updated");
//               }).catchError((error) {
//                 print("Error updating tags: $error");
//               });
//             },
//             child: SvgPicture.asset(Assets.tabaddicons),
//           ),
//           kWidth(25),
//         ],
//       ),
//       body:
//           FilterListView(categoryId: widget.categoryId), // Pass categoryId here
//     );
//   }
// }

// class FilterListView extends StatefulWidget {
//   final String categoryId;

//   const FilterListView({super.key, required this.categoryId});

//   @override
//   _FilterListViewState createState() => _FilterListViewState();
// }

// class _FilterListViewState extends State<FilterListView> {
//   final GetTagsController getTagsController = Get.put(GetTagsController());
//   // List to hold selected tags
//   final GetStorage storage = GetStorage();
//   final String storageKey = 'selectedTags';

//   @override
//   void initState() {
//     super.initState();
//     // Initial fetch
//     getTagsController.getTagslist(widget.categoryId, true);
//     // Load tags from local storage
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadTagsFromLocal();
//     });
//   }

//   void _saveTagsLocally() {
//     // Save selected tags to local storage
//     List<Map<String, dynamic>> tagJsonList =
//         getTagsController.selectedTags.map((tag) => tag.toJson()).toList();
//     storage.write(storageKey, tagJsonList);
//     print(storage.read(storageKey));
//   }

//   void _loadTagsFromLocal() {
//     // Load selected tags from local storage
//     List<dynamic>? storedTagJsonList = storage.read(storageKey);
//     if (storedTagJsonList != null) {
//       setState(() {
//         getTagsController.selectedTags.value = storedTagJsonList
//             .map((json) => Tag.fromJson(json as Map<String, dynamic>))
//             .toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Obx(
//           () {
//             if (getTagsController.getTagsLoading.value) {
//               return Center(child: CircularProgressIndicator());
//             }

//             final tags = getTagsController.getTagsResponse.value?.result;
//             if (tags != null && tags.isNotEmpty) {
//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: tags.length,
//                   itemBuilder: (context, index) {
//                     final tag = tags[index];

//                     return Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 15),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 tag.tag ?? "", // Display the tag name
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Checkbox(
//                                 side: BorderSide(color: Colors.white),
//                                 fillColor: MaterialStateProperty.all(
//                                     getTagsController.selectedTags
//                                             .any((t) => t.tagId == tag.sId)
//                                         ? Colors.blue
//                                         : Colors.white),
//                                 checkColor: Colors.white,
//                                 value: getTagsController.selectedTags
//                                     .any((t) => t.tagId == tag.sId),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     if (value == true) {
//                                       getTagsController.selectedTags.add(Tag(
//                                           tagId: tag.sId!,
//                                           tagName: tag.tag ?? ""));
//                                     } else {
//                                       getTagsController.selectedTags
//                                           .removeWhere(
//                                               (t) => t.tagId == tag.sId);
//                                     }
//                                     // Save updated tags
//                                     // _saveTagsLocally();
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider(
//                           height: 5,
//                           color: Colors.grey,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               );
//             } else {
//               return Center(child: Text("No tags available"));
//             }
//           },
//         ),
//         Container(
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               minimumSize: Size(MediaQuery.of(context).size.width, 48),
//               padding: EdgeInsets.symmetric(vertical: 15),
//             ),
//             onPressed: () {
//               // Save tags when the button is pressed
//               _saveTagsLocally();
//             },
//             child: Text(
//               'Save',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// // class FilterListView extends StatefulWidget {
// //   final String categoryId;

// //   const FilterListView({super.key, required this.categoryId});

// //   @override
// //   _FilterListViewState createState() => _FilterListViewState();
// // }

// // class _FilterListViewState extends State<FilterListView> {
// //   final GetTagsController getTagsController = Get.put(GetTagsController());
// //   List<String> selectedTagIds = []; // List to hold selected tag IDs
// //   final GetStorage storage = GetStorage();
// //   final String storageKey = 'selectedTagIds';

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Initial fetch
// //     getTagsController.getTagslist(widget.categoryId);
// //     // Load tags from local storage
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _loadTagsFromLocal();
// //     });
// //   }

// //   void _saveTagsLocally() {
// //     // Save selected tag IDs to local storage
// //     storage.write(storageKey, selectedTagIds);
// //     print(storage.read(storageKey));
// //   }

// //   void _loadTagsFromLocal() {
// //     // Load selected tag IDs from local storage
// //     List<String>? storedTagIds = storage.read(storageKey)?.cast<String>();
// //     if (storedTagIds != null) {
// //       setState(() {
// //         selectedTagIds = storedTagIds;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Obx(
// //           () {
// //             if (getTagsController.getTagsLoading.value) {
// //               return Center(child: CircularProgressIndicator());
// //             }

// //             final tags = getTagsController.getTagsResponse.value.result;
// //             if (tags != null && tags.isNotEmpty) {
// //               return Expanded(
// //                 child: ListView.builder(
// //                   itemCount: tags.length,
// //                   itemBuilder: (context, index) {
// //                     final tag = tags[index];

// //                     return Column(
// //                       children: [
// //                         Container(
// //                           padding: EdgeInsets.symmetric(horizontal: 15),
// //                           child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 tag.tag ?? "", // Display the tag name
// //                                 style: TextStyle(
// //                                   fontSize: 14,
// //                                   color: Colors.white,
// //                                 ),
// //                               ),
// //                               Checkbox(
// //                                 side: BorderSide(color: Colors.white),
// //                                 fillColor: MaterialStateProperty.all(
// //                                     selectedTagIds.contains(tag.sId)
// //                                         ? Colors.blue
// //                                         : Colors.white),
// //                                 checkColor: Colors.white,
// //                                 value: selectedTagIds.contains(tag.sId),
// //                                 onChanged: (value) {
// //                                   setState(() {
// //                                     if (value == true) {
// //                                       selectedTagIds.add(tag.sId!);
// //                                     } else {
// //                                       selectedTagIds.remove(tag.sId);
// //                                     }
// //                                     // Save updated tag IDs
// //                                     _saveTagsLocally();
// //                                   });
// //                                 },
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         Divider(
// //                           height: 5,
// //                           color: Colors.grey,
// //                         ),
// //                       ],
// //                     );
// //                   },
// //                 ),
// //               );
// //             } else {
// //               return Center(child: Text("No tags available"));
// //             }
// //           },
// //         ),
// //         Container(
// //           child: ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               minimumSize: Size(MediaQuery.of(context).size.width, 48),
// //               // primary: Colors.blue,
// //               padding: EdgeInsets.symmetric(vertical: 15),
// //             ),
// //             onPressed: () {
// //               // Save tags when the button is pressed
// //               _saveTagsLocally();
// //             },
// //             child: Text(
// //               'Save',
// //               style: TextStyle(
// //                 fontSize: 14,
// //                 color: Colors.white,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //////////////////////****************////
// // class FilterListView extends StatefulWidget {
// //   final String categoryId;

// //   const FilterListView({super.key, required this.categoryId});

// //   @override
// //   _FilterListViewState createState() => _FilterListViewState();
// // }

// // class _FilterListViewState extends State<FilterListView> {
// //   final GetTagsController getTagsController = Get.put(GetTagsController());
// //   List<bool> isCheckedList = [];
// //   final GetStorage storage = GetStorage();
// //   final String storageKey = 'selectedTags';

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Initial fetch
// //     getTagsController.getTagslist(widget.categoryId);
// //     // Load tags from local storage
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _loadTagsFromLocal();
// //     });
// //   }

// //   void _saveTagsLocally() {
// //     // Save selected tags to local storage
// //     storage.write(storageKey, getTagsController.tagvalue);
// //     print(storage.read(storageKey));
// //   }

// //   void _loadTagsFromLocal() {
// //     // Load selected tags from local storage
// //     List<String>? storedTags = storage.read(storageKey)?.cast<String>();
// //     if (storedTags != null) {
// //       setState(() {
// //         isCheckedList = List.generate(
// //           getTagsController.getTagsResponse.value.result?.length ?? 1,
// //           (index) => storedTags.contains(
// //               getTagsController.getTagsResponse.value.result?[index].tag),
// //         );
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Obx(
// //           () {
// //             if (getTagsController.getTagsLoading.value) {
// //               return centerLoader();
// //             }

// //             final tags = getTagsController.getTagsResponse.value.result;
// //             if (tags != null) {
// //               // Ensure isCheckedList length matches the number of tags
// //               if (isCheckedList.length != tags.length) {
// //                 isCheckedList = List.generate(tags.length, (index) => false);
// //                 WidgetsBinding.instance.addPostFrameCallback((_) {
// //                   _loadTagsFromLocal();
// //                 });
// //               }

// //               return Expanded(
// //                 child: ListView.builder(
// //                   itemCount: tags.length,
// //                   itemBuilder: (context, index) {
// //                     final tag = tags[index];

// //                     return Column(
// //                       children: [
// //                         Container(
// //                           padding: EdgeInsets.symmetric(horizontal: 15),
// //                           child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               PrimaryText(
// //                                 text: tag.tag ?? "", // Display the tag name
// //                                 size: 14,
// //                                 color: AppColors.white,
// //                               ),
// //                               Checkbox(
// //                                 side: BorderSide(color: Colors.white),
// //                                 fillColor: MaterialStateProperty.all(
// //                                     isCheckedList[index]
// //                                         ? AppColors.icontextColor
// //                                         : AppColors.white),
// //                                 checkColor: AppColors.white,
// //                                 value: isCheckedList[index],
// //                                 onChanged: (value) {
// //                                   setState(() {
// //                                     isCheckedList[index] = value!;
// //                                     if (value) {
// //                                       getTagsController.tagvalue
// //                                           .add(tag.tag!); // Add the tag name
// //                                     } else {
// //                                       getTagsController.tagvalue.remove(
// //                                           tag.tag); // Remove the tag name
// //                                     }
// //                                     // Save updated tags
// //                                     _saveTagsLocally();
// //                                   });
// //                                 },
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         Divider(
// //                           height: 5,
// //                           color: AppColors.dividerColor,
// //                         ),
// //                       ],
// //                     );
// //                   },
// //                 ),
// //               );
// //             } else {
// //               return Center(child: Text("No tags available"));
// //             }
// //           },
// //         ),
// //         Container(
// //           child: CustomButton(
// //             width: MediaQuery.of(context).size.width,
// //             padding: EdgeInsets.symmetric(vertical: 15),
// //             onPressed: () {
// //               // Save tags when the button is pressed
// //               _saveTagsLocally();
// //             },
// //             children: [
// //               PrimaryText(
// //                   text: Apptext.Savebutton, size: 14, color: AppColors.white),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// class Tag {
//   final String tagId;
//   final String tagName;

//   Tag({required this.tagId, required this.tagName});

//   // Convert Tag object to JSON
//   Map<String, dynamic> toJson() => {
//         'tagid': tagId,
//         'tagname': tagName,
//       };

//   // Create Tag object from JSON
//   factory Tag.fromJson(Map<String, dynamic> json) => Tag(
//         tagId: json['tagid'],
//         tagName: json['tagname'],
//       );
// }
