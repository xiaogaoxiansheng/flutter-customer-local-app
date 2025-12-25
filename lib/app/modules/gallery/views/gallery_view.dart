import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../global_widgets/custom_navbar.dart';
import '../controllers/gallery_controller.dart';
import './gallery_styles.dart';

/// 图库列表页
/// 展示在线图片九宫格，支持触底分页与点击预览
class GalleryView extends GetView<GalleryController> {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GalleryStyles.pageBackground,
      appBar: const CustomNavbar(
        title: '图库',
      ),
      body: Padding(
        padding: GalleryStyles.listPadding(),
        child: ConstraintLayout(
          children: [
            Obx(
              () => _GalleryGrid(controller: controller).applyConstraint(
                id: ConstraintId('grid'),
                left: parent.left,
                right: parent.right,
                top: parent.top,
                bottom: parent.bottom,
                margin: GalleryStyles.listTopMargin(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 图库九宫格
/// 负责处理加载态、空态，并渲染列表与“正在加载...”尾部
class _GalleryGrid extends StatelessWidget {
  final GalleryController controller;
  const _GalleryGrid({required this.controller});

  @override
  Widget build(BuildContext context) {
    final items = controller.items;
    final isInitialLoading = controller.isInitialLoading.value;
    final isLoadingMore = controller.isLoadingMore.value;

    if (isInitialLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (items.isEmpty) {
      return Center(
        child: Text(
          '暂无图片',
          style: GalleryStyles.emptyText(context),
        ),
      );
    }

    return CustomScrollView(
      controller: controller.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverGrid(
          gridDelegate: GalleryStyles.gridDelegate(),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = items[index];
              return _GalleryTile(
                item: item,
                onTap: () => Get.dialog(
                  GalleryPreviewDialog(
                    items: items.toList(growable: false),
                    initialIndex: index,
                  ),
                  barrierDismissible: true,
                  barrierColor: const Color(0x99000000),
                  useSafeArea: true,
                ),
              );
            },
            childCount: items.length,
          ),
        ),
        if (isLoadingMore)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Text(
                  '正在加载...',
                  style: GalleryStyles.loadingMoreText(context),
                ),
              ),
            ),
          ),
        SliverToBoxAdapter(
          child: SizedBox(height: 24.h),
        ),
      ],
    );
  }
}

/// 图库图片卡片
/// 展示图片缩略图与底部日期遮罩，点击进入预览
class _GalleryTile extends StatelessWidget {
  final GalleryItem item;
  final VoidCallback onTap;

  const _GalleryTile({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: GalleryStyles.tileRadius(),
        child: ConstraintLayout(
          children: [
            Image.network(
              item.url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: GalleryStyles.imagePlaceholder,
                alignment: Alignment.center,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: GalleryStyles.textSecondary,
                  size: GalleryStyles.brokenImageIconSize(),
                ),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: GalleryStyles.imagePlaceholder,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: GalleryStyles.loadingIndicatorSize(),
                    height: GalleryStyles.loadingIndicatorSize(),
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
            ).applyConstraint(
              id: ConstraintId('img'),
              left: parent.left,
              right: parent.right,
              top: parent.top,
              bottom: parent.bottom,
            ),
            Container(
              padding: GalleryStyles.dateOverlayPadding(),
              decoration: BoxDecoration(
                gradient: GalleryStyles.dateOverlayGradient(),
              ),
              child: Text(
                item.dateTimeText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GalleryStyles.dateOverlayText(context),
              ),
            ).applyConstraint(
              id: ConstraintId('date'),
              left: parent.left,
              right: parent.right,
              bottom: parent.bottom,
            ),
          ],
        ),
      ),
    );
  }
}

/// 图库预览页
/// 使用 PhotoView 支持缩放/滑动，底部展示日期与总数
class GalleryPreviewView extends StatefulWidget {
  final List<GalleryItem> items;
  final int initialIndex;

  const GalleryPreviewView({
    super.key,
    required this.items,
    required this.initialIndex,
  });

  @override
  State<GalleryPreviewView> createState() => _GalleryPreviewViewState();
}

class _GalleryPreviewViewState extends State<GalleryPreviewView> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final total = items.length;
    final current = items[_currentIndex];

    return Scaffold(
      backgroundColor: GalleryStyles.previewBackground,
      appBar: const CustomNavbar(
        title: '图库',
      ),
      body: ConstraintLayout(
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            backgroundDecoration: const BoxDecoration(
              color: GalleryStyles.previewBackground,
            ),
            itemCount: total,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            builder: (context, index) {
              final item = items[index];
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(item.url),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes: PhotoViewHeroAttributes(tag: 'gallery_$index'),
              );
            },
          ).applyConstraint(
            id: ConstraintId('preview'),
            left: parent.left,
            right: parent.right,
            top: parent.top,
            bottom: parent.bottom,
          ),
          Container(
            padding: GalleryStyles.previewBarPadding(),
            decoration: const BoxDecoration(
              color: GalleryStyles.dateOverlayBackground,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    current.dateTimeText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GalleryStyles.previewBarText(context),
                  ),
                ),
                Text(
                  '${_currentIndex + 1}/$total  共$total张',
                  style: GalleryStyles.previewBarText(context),
                ),
              ],
            ),
          ).applyConstraint(
            id: ConstraintId('bar'),
            left: parent.left,
            right: parent.right,
            bottom: parent.bottom,
          ),
        ],
      ),
    );
  }
}

/// 图库预览对话框
/// 在当前页以对话框形式打开图片预览，支持滑动与缩放
class GalleryPreviewDialog extends StatefulWidget {
  final List<GalleryItem> items;
  final int initialIndex;

  const GalleryPreviewDialog({
    super.key,
    required this.items,
    required this.initialIndex,
  });

  @override
  State<GalleryPreviewDialog> createState() => _GalleryPreviewDialogState();
}

class _GalleryPreviewDialogState extends State<GalleryPreviewDialog> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final total = items.length;
    final current = items[_currentIndex];

    return Material(
      color: GalleryStyles.previewBackground.withValues(alpha: 0.96),
      child: SafeArea(
        child: ConstraintLayout(
          children: [
            PhotoViewGallery.builder(
              pageController: _pageController,
              backgroundDecoration: const BoxDecoration(
                color: GalleryStyles.previewBackground,
              ),
              itemCount: total,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              builder: (context, index) {
                final item = items[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(item.url),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: 'gallery_dialog_$index'),
                );
              },
            ).applyConstraint(
              id: ConstraintId('preview'),
              left: parent.left,
              right: parent.right,
              top: parent.top,
              bottom: parent.bottom,
            ),
            // 底部信息栏：日期 + 序号/总数
            Container(
              padding: GalleryStyles.previewBarPadding(),
              decoration: const BoxDecoration(
                color: GalleryStyles.dateOverlayBackground,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      current.dateTimeText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GalleryStyles.previewBarText(context),
                    ),
                  ),
                  Text(
                    '${_currentIndex + 1}/$total  共$total张',
                    style: GalleryStyles.previewBarText(context),
                  ),
                ],
              ),
            ).applyConstraint(
              id: ConstraintId('bar'),
              left: parent.left,
              right: parent.right,
              bottom: parent.bottom,
            ),
            // 右上角关闭按钮
            Container(
              width: 80.w,
              height: 80.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: GalleryStyles.dateOverlayBackground,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: Get.back,
              ),
            ).applyConstraint(
              id: ConstraintId('close'),
              right: parent.right,
              top: parent.top,
              margin: EdgeInsets.only(top: 20.h, right: 20.w),
            ),
          ],
        ),
      ),
    );
  }
}
