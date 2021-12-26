DefaultTabController
(
length: pages.length,child: Scaffold
(
body: NestedScrollView
(
headerSliverBuilder: (

BuildContext context, bool
innerBoxIsScrolled) {
return <Widget>[
SliverAppBar(
title: AppText(
'my_orders'.tr,
fontSize: 16,
),
pinned: true,
floating: true,
bottom: TabBar(
controller: _tabController,
isScrollable: true,
indicatorColor: Theme.of(context).primaryColor,
unselectedLabelColor: kUnSelectedColor,
labelColor: Theme.of(context).primaryColor,
tabs: [
Tab(
child: Text(
'new_orders'.tr,
style: const TextStyle(
fontFamily: fontMedium,
),
),
),
Tab(
child: Text(
'completed_orders'.tr,
style: const TextStyle(
fontFamily: fontMedium,
),
),
),
Tab(
child: Text(
'cancelled_orders'.tr,
style: const TextStyle(
fontFamily: fontMedium,
),
),
),
],
),
),
];
},
body: TabBarView
(
children: pages,controller: _tabController,)
,
)
,
)
,
);