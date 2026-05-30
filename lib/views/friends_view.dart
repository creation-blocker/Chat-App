import 'package:chat_tutorial/controllers/friends_controller.dart';
import 'package:chat_tutorial/theme/app_theme.dart';
import 'package:chat_tutorial/views/widgets/friend_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsView extends GetView<FriendsController> {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Friends'),
        actions: [
          IconButton(
            onPressed: controller.openFriendRequests,
            icon: Icon(
              Icons.person_add_alt_1,
              color: AppTheme.primaryColor,
              size: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.borderColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
              child: TextField(
                onChanged: controller.updateSearchQuery,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search Friends',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Obx(() {
                    return controller.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: controller.clearSearch,
                          )
                        : const SizedBox.shrink();
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
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: AppTheme.cardColor,
                ),
              ),
            ),

            /// FRIEND LIST
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refreshFriends,
                child: Obx(() {
                  /// FIXED CONDITION
                  if (controller.isLoading && controller.friends.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.filteredFriends.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: _buildEmptyState(),
                      ),
                    );
                  }

                  return ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.filteredFriends.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemBuilder: (context, index) {
                      final friend = controller.filteredFriends[index];

                      return FriendListItem(
                        friend: friend,
                        lastSeenText: controller.getLastSeenText(friend),
                        onTap: () => controller.startChat(friend),
                        onRemove: () => controller.removeFriend(friend),
                        onBlock: () => controller.blockFriend(friend),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
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

            const SizedBox(height: 24),

            Text(
              controller.searchQuery.isNotEmpty
                  ? 'No friend found'
                  : 'No friend yet',
              style: Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              controller.searchQuery.isNotEmpty
                  ? 'Try a different search term'
                  : 'Add friends to start chatting with them',
              style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),

            if (controller.searchQuery.isEmpty) ...[
              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: controller.openFriendRequests,
                icon: const Icon(Icons.person_search),
                label: const Text('View Friend Requests'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
