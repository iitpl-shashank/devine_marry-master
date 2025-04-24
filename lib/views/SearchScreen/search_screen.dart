import 'package:devine_marry/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AuthController/auth_controller.dart';
import '../../controller/SearchController/search_controller.dart';
import '../../helper/date_converter.dart';
import '../../utils/string_texts.dart';
import '../../utils/themes/app_colors.dart';
import '../../widgets/custom_match_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchUserController searchController =
      Get.find<SearchUserController>();

  final AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
    searchController.searchQuery.value = '';
    searchController.searchResultUsers.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringTexts.search.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTheme,
                ),
              ),
              const SizedBox(height: 16),
              CustomSearchBar(
                hintText: "Search...", // Required parameter
                onChanged: (value) {
                  debugPrint("Search query: $value");
                  searchController.searchQuery.value = value;
                  searchController
                      .searchUsersbyKeyword(); // Call the search function
                }, // Optional parameter for handling input changes
              ),
              const SizedBox(height: 16),
              searchController.searchResultUsers.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: searchController.searchResultUsers.length,
                        itemBuilder: (context, index) {
                          final user =
                              searchController.searchResultUsers[index];
                          return CustomMatchCard(
                            imageUrl: user.imageUrl ?? '',
                            name: user.firstName ?? '',
                            age: int.parse(AgeCalculator.calculateAge(
                                user.birthDate.toString())),
                            height: HeightConverter.convertCmToFeetAndInches(
                                user.height ?? 180),
                            religion: authController.religionResponse.religions
                                .firstWhere(
                                    (element) => element.id == user.religion,
                                    orElse: () => authController
                                        .religionResponse.religions.first)
                                .name,
                            userId: user.id.toString(),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          searchController.searchQuery.value.isNotEmpty
                              ? 'No matches found for "${searchController.searchQuery.value}"'
                              : 'Please enter a search term',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.70),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
