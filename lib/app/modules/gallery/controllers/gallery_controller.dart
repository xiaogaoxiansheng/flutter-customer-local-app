import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GalleryItem {
  final String url;
  final String dateTimeText;

  const GalleryItem({
    required this.url,
    required this.dateTimeText,
  });
}

class GalleryController extends GetxController {
  static const String tempImageUrl =
      'https://img0.baidu.com/it/u=2002460238,2194016748&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=620';
  static const String tempDateTimeText = '2025-09-28 12:06:49';

  final items = <GalleryItem>[].obs;
  final isInitialLoading = true.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  final ScrollController scrollController = ScrollController();

  int _page = 0;
  final int _pageSize = 30;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    loadFirstPage();
  }

  @override
  void onClose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.onClose();
  }

  Future<void> loadFirstPage() async {
    _page = 0;
    hasMore.value = true;
    isInitialLoading.value = true;
    items.clear();

    final fetched = await _fetchPage(page: 1);
    items.addAll(fetched);
    _page = 1;
    isInitialLoading.value = false;
    if (fetched.length < _pageSize) {
      hasMore.value = false;
    }
  }

  Future<void> loadNextPage() async {
    if (!hasMore.value || isLoadingMore.value || isInitialLoading.value) {
      return;
    }

    isLoadingMore.value = true;
    final nextPage = _page + 1;
    final fetched = await _fetchPage(page: nextPage);
    items.addAll(fetched);
    _page = nextPage;
    isLoadingMore.value = false;
    if (fetched.length < _pageSize) {
      hasMore.value = false;
    }
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;
    if (position.maxScrollExtent <= 0) return;

    final shouldLoadMore =
        position.pixels >= position.maxScrollExtent - 200;
    if (shouldLoadMore) {
      loadNextPage();
    }
  }

  Future<List<GalleryItem>> _fetchPage({required int page}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return List.generate(
      _pageSize,
      (_) => const GalleryItem(
        url: tempImageUrl,
        dateTimeText: tempDateTimeText,
      ),
    );
  }
}
