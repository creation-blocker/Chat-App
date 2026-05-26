import 'package:chat_tutorial/controllers/user_list_controller.dart';
import 'package:chat_tutorial/theme/app_theme.dart';
import 'package:chat_tutorial/views/widgets/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPeopleView extends StatefulWidget {
  const FindPeopleView({super.key});

  @override
  State<FindPeopleView> createState() => _FindPeopleViewState();
}

class _FindPeopleViewState extends State<FindPeopleView> {
  final UserListController controller = Get.find<UserListController>();
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: controller.searchQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find People')),
      body: Column(
        children: [
          _buildSearchBar(context),
          Expanded(
            child: Obx(() {
              if (controller.filteredUser.isEmpty) {
                return _buildEmptyState(context);
              }
              return ListView.separated(
                padding: EdgeInsets.all(16),
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemCount: controller.filteredUser.length,
                itemBuilder: (context, index) {
                  final user = controller.filteredUser[index];
                  return UserListItem(
                    user: user,
                    onTap: () => controller.handleRelationshipAction(user),
                    controller: controller,
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor.withOpacity(0.5)),
        ),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: controller.updateSearchQuery,
        decoration: InputDecoration(
          hintText: 'Search people',
          prefixIcon: Icon(Icons.search),
          suffixIcon: Obx(() {
            return controller.searchQuery.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      controller.clearSearch();
                      _searchController.clear();
                    },
                    icon: Icon(Icons.clear),
                  )
                : SizedBox.shrink();
          }),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
          ),
          filled: true,
          fillColor: AppTheme.cardColor,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.people_outline,
                color: AppTheme.primaryColor,
                size: 50,
              ),
            ),
            SizedBox(height: 24),
            Text(
              controller.searchQuery.isNotEmpty
                  ? 'No results found'
                  : 'No people found',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              controller.searchQuery.isNotEmpty
                  ? 'Try a different search term'
                  : 'All users will show here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
