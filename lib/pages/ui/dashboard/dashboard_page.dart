import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muhamadagussupriyantono_elisoft_technology/utils/result.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_text/skeleton_text.dart';
import '../../../cubit/dashboard/dashboard_cubit.dart';
import '../../../injector_container.dart';
import '../../../constants/app_constants.dart';
import '../../common/common.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    sl<DashboardCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardCubit, DashboardState>(
        buildWhen: (previous, current) =>
            previous.result != current.result ||
            previous.favoriteResult != current.favoriteResult,
        builder: (context, state) {
          return SafeArea(
            child: SmartRefresher(
              controller: refreshController,
              header: const WaterDropHeader(),
              footer: const ClassicFooter(),
              onRefresh: () {
                sl<DashboardCubit>().init();
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                sl<DashboardCubit>().getArticles(loadmore: true);
                refreshController.loadComplete();
              },
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.result?.status == Status.LOADING &&
                            state.favoriteResult?.status == Status.LOADING
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              top: 16.h,
                              bottom: 16.h,
                            ),
                            child: SkeletonAnimation(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                width: 200.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Color(
                                    kLightGrey.value,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              top: 16.h,
                              bottom: 16.h,
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Welcome, ',
                                    style: appstyle(
                                      25,
                                      Color(kDark.value),
                                      FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'User',
                                    style: appstyle(
                                      25,
                                      Color(kDark.value),
                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    state.favoriteResult?.status == Status.LOADING
                        ? SizedBox(
                            height: height * .28,
                            child: ListView.separated(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  const WidthSpacer(width: 10),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? 16.w : 0,
                                    right: index == 4 ? 16.w : 0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SkeletonAnimation(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Container(
                                          width: 130.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Color(
                                              kLightGrey.value,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const HeightSpacer(height: 10),
                                      SkeletonAnimation(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Container(
                                          width: 200.w,
                                          height: 180.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Color(
                                              kLightGrey.value,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : SizedBox(
                            height: height * .28,
                            child: ListView.separated(
                              itemCount:
                                  state.favoriteResult?.data?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  const WidthSpacer(width: 10),
                              itemBuilder: (context, index) {
                                final data = state.favoriteResult?.data?[index];
                                final count =
                                    state.favoriteResult?.data?.length ?? 0;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? 16.w : 0,
                                    right: index == count - 1 ? 16.w : 0,
                                  ),
                                  child: ArticleHorizontal(
                                    title: data?.title ?? '',
                                    content: data?.content ?? '',
                                  ),
                                );
                              },
                            ),
                          ),
                    const HeightSpacer(height: 20),
                    state.result?.status == Status.LOADING
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              separatorBuilder: (context, index) =>
                                  const HeightSpacer(height: 20),
                              itemBuilder: (context, index) {
                                return SkeletonAnimation(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 16.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Color(
                                        kLightGrey.value,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 100.w,
                                              height: 100.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: Color(
                                                  kDarkGrey.value,
                                                ),
                                              ),
                                            ),
                                            const WidthSpacer(width: 15),
                                            Container(
                                              width: 195.w,
                                              height: 50.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: Color(
                                                  kDarkGrey.value,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const HeightSpacer(height: 20),
                                        Container(
                                          width: double.infinity,
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Color(
                                              kDarkGrey.value,
                                            ),
                                          ),
                                        ),
                                        const HeightSpacer(height: 20),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            width: 200.w,
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              color: Color(
                                                kDarkGrey.value,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.result?.data?.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  const HeightSpacer(height: 20),
                              itemBuilder: (context, index) {
                                final data = state.result?.data?[index];
                                return ArticleVertical(
                                  title: data?.title ?? '',
                                  content: data?.content ?? '',
                                  date: data?.created?.date ?? '',
                                  image: data?.image ??
                                      'https://picsum.photos/200/300',
                                );
                              },
                            ),
                          ),
                    const HeightSpacer(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
