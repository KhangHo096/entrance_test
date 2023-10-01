import 'package:entrance_test/app/data/model/category/category_model.dart';
import 'package:entrance_test/app/msc/colors.dart';
import 'package:entrance_test/app/msc/text_styles.dart';
import 'package:entrance_test/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
        children: [
          _banner(),
          _blackOverlay(),
          _body(),
          _loadingOverlay(),
        ],
      ),
    );
  }

  Widget _loadingOverlay() {
    return Obx(
      () => Visibility(
        visible: controller.loading.value,
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(
              color: colorMain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Positioned.fill(
      child: SafeArea(
        bottom: false,
        child: _BodyPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topBar(),
              _dataList(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _dataList() {
    return Expanded(
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _welcomeText(),
          _listCategories(),
        ],
      ),
    );
  }

  SliverPadding _listCategories() {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 40.dp, top: 20.dp),
      sliver: Obx(
        () => SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.dp,
            crossAxisSpacing: 8.dp,
            childAspectRatio: 110.dp / 70.dp,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final item = controller.listCategories[index];
              // final selected = controller.isSelected(item);
              return _CategoryItem(
                item: item,
                selected: item.selected ?? false,
                onTap: () {
                  controller.onItemTapped(item);
                },
              );
            },
            childCount: controller.listCategories.length,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _welcomeText() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Get.height * .12),
          Text(
            'Welcome to Flutter Test',
            style: textTitle.white,
          ),
          SizedBox(height: 10.dp),
          Text(
            'Please select categories what you would like to see '
            'on your feed. You can set this later on Filter.',
            style: text14.white,
          ),
        ],
      ),
    );
  }

  Widget _blackOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.6, 0.9],
            colors: [
              Colors.black,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
              size: 18.dp,
            ),
          ),
          const Spacer(),
          Obx(
            () => Opacity(
              opacity: controller.hasSelectedItems() ? 1 : 0.5,
              child: GestureDetector(
                onTap: controller.saveSelectedItems,
                child: Text(
                  'Done',
                  style: text12.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _banner() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Assets.images.imgCategoryBanner.image(),
    );
  }
}

class _BodyPadding extends StatelessWidget {
  final Widget child;

  const _BodyPadding({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryModel item;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  BoxDecoration _selectedDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          gradientPurple1,
          gradientPurple2,
        ],
      ),
      borderRadius: BorderRadius.circular(8.dp),
    );
  }

  BoxDecoration _notSelectedDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8.dp),
      border: Border.all(color: Colors.white.withOpacity(0.12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: selected ? _selectedDecoration() : _notSelectedDecoration(),
        child: Center(
          child: Text(
            item.name ?? '',
            style: text14.white,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
