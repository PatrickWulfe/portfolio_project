import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ActionBar extends HookWidget implements PreferredSizeWidget {
  const ActionBar({
    super.key,
    required this.controller,
  });
  final PageController controller;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final pageAnimationDuration = .4.seconds;
    const pageAnimationCurve = Curves.ease;
    final selectedColor = appTheme.colorScheme.secondary;
    final notSelectedColor = appTheme.colorScheme.primary;

    const homeIcon = Icons.home_rounded;
    const aboutMeIcon = Icons.account_circle_rounded;
    const experienceIcon = Icons.book_rounded;
    const projectsIcon = CommunityMaterialIcons.github;
    const interestsIcon = Icons.info_rounded;

    // Set up state for selected page
    final pageNumber = useState<double>(0);
    controller.addListener(() {
      pageNumber.value = controller.page!;
    });

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // MOBILE/TABLET
        if (sizingInformation.isMobile || sizingInformation.isTablet) {
          return _MobileActionBar(
            controller: controller,
            sizingInformation: sizingInformation,
            pageAnimationDuration: pageAnimationDuration,
            pageAnimationCurve: pageAnimationCurve,
            homeIcon: homeIcon,
            pageNumber: pageNumber,
            selectedColor: selectedColor,
            notSelectedColor: notSelectedColor,
            appTheme: appTheme,
            aboutMeIcon: aboutMeIcon,
            experienceIcon: experienceIcon,
            projectsIcon: projectsIcon,
            interestsIcon: interestsIcon,
          );
        }
        // DESKTOP
        return _DesktopActionBar(
          homeIcon: homeIcon,
          sizingInformation: sizingInformation,
          controller: controller,
          pageNumber: pageNumber,
          aboutMeIcon: aboutMeIcon,
          experienceIcon: experienceIcon,
          projectsIcon: projectsIcon,
          interestsIcon: interestsIcon,
        );
      },
    );
  }
}

class _MobileActionBar extends StatelessWidget {
  const _MobileActionBar({
    super.key,
    required this.controller,
    required this.sizingInformation,
    required this.pageAnimationDuration,
    required this.pageAnimationCurve,
    required this.homeIcon,
    required this.pageNumber,
    required this.selectedColor,
    required this.notSelectedColor,
    required this.appTheme,
    required this.aboutMeIcon,
    required this.experienceIcon,
    required this.projectsIcon,
    required this.interestsIcon,
  });

  final PageController controller;
  final SizingInformation sizingInformation;
  final Duration pageAnimationDuration;
  final Cubic pageAnimationCurve;
  final IconData homeIcon;
  final ValueNotifier<double> pageNumber;
  final Color selectedColor;
  final Color notSelectedColor;
  final ThemeData appTheme;
  final IconData aboutMeIcon;
  final IconData experienceIcon;
  final IconData projectsIcon;
  final IconData interestsIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 12,
            ),
            child: Image.asset(
              'assets/images/header-logo.png',
              width: sizingInformation.screenSize.width * .05,
              height: sizingInformation.screenSize.height * .05,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<int>(
                onSelected: (value) => controller.animateToPage(
                  value,
                  duration: pageAnimationDuration,
                  curve: pageAnimationCurve,
                ),
                itemBuilder: (c) => <PopupMenuEntry<int>>[
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          homeIcon,
                          size: 18,
                          color: pageNumber.value == 0
                              ? selectedColor
                              : notSelectedColor,
                        ),
                        const Gap(8),
                        Text(
                          'Home',
                          style: appTheme.textTheme.labelMedium,
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          aboutMeIcon,
                          size: 18,
                          color: pageNumber.value == 1
                              ? selectedColor
                              : notSelectedColor,
                        ),
                        const Gap(8),
                        Text(
                          'About Me',
                          style: appTheme.textTheme.labelMedium,
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(
                          experienceIcon,
                          size: 18,
                          color: pageNumber.value == 2
                              ? selectedColor
                              : notSelectedColor,
                        ),
                        const Gap(8),
                        Text(
                          'Experience',
                          style: appTheme.textTheme.labelMedium,
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Row(
                      children: [
                        Icon(
                          projectsIcon,
                          size: 18,
                          color: pageNumber.value == 3
                              ? selectedColor
                              : notSelectedColor,
                        ),
                        const Gap(8),
                        Text(
                          'Projects',
                          style: appTheme.textTheme.labelMedium,
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Row(
                      children: [
                        Icon(
                          interestsIcon,
                          size: 18,
                          color: pageNumber.value == 4
                              ? selectedColor
                              : notSelectedColor,
                        ),
                        const Gap(8),
                        Text(
                          'Interests',
                          style: appTheme.textTheme.labelMedium,
                        )
                      ],
                    ),
                  ),
                ],
                child: const Icon(Icons.menu_rounded, size: 24),
              ),
              const Gap(32),
            ],
          ),
        ),
      ],
    );
  }
}

class _DesktopActionBar extends StatelessWidget {
  const _DesktopActionBar({
    super.key,
    required this.homeIcon,
    required this.sizingInformation,
    required this.controller,
    required this.pageNumber,
    required this.aboutMeIcon,
    required this.experienceIcon,
    required this.projectsIcon,
    required this.interestsIcon,
  });

  final IconData homeIcon;
  final SizingInformation sizingInformation;
  final PageController controller;
  final ValueNotifier<double> pageNumber;
  final IconData aboutMeIcon;
  final IconData experienceIcon;
  final IconData projectsIcon;
  final IconData interestsIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 12,
            ),
            child: Image.asset(
              'assets/images/header-logo.png',
              width: sizingInformation.screenSize.width * .10,
              height: sizingInformation.screenSize.height * .10,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _DesktopAppbarButton(
                label: 'Home',
                leading: homeIcon,
                pageId: 0,
                controller: controller,
                pageNumber: pageNumber.value,
              ),
              const Gap(8),
              _DesktopAppbarButton(
                label: 'About Me',
                leading: aboutMeIcon,
                pageId: 1,
                controller: controller,
                pageNumber: pageNumber.value,
              ),
              const Gap(8),
              _DesktopAppbarButton(
                label: 'Experience',
                leading: experienceIcon,
                pageId: 2,
                controller: controller,
                pageNumber: pageNumber.value,
              ),
              const Gap(8),
              _DesktopAppbarButton(
                label: 'Projects',
                leading: projectsIcon,
                pageId: 3,
                controller: controller,
                pageNumber: pageNumber.value,
              ),
              const Gap(8),
              _DesktopAppbarButton(
                label: 'Interests',
                leading: interestsIcon,
                pageId: 4,
                controller: controller,
                pageNumber: pageNumber.value,
              ),
            ],
          ),
        ),
        const Gap(64),
      ],
    );
  }
}

class _DesktopAppbarButton extends StatelessWidget {
  const _DesktopAppbarButton({
    required this.label,
    required this.leading,
    required this.controller,
    required this.pageId,
    required this.pageNumber,
  });

  final String label;
  final IconData leading;
  final PageController controller;
  final int pageId;
  final double pageNumber;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final pageAnimationDuration = .4.seconds;
    const pageAnimationCurve = Curves.ease;
    final selectedColor = appTheme.colorScheme.secondary;
    final notSelectedColor = appTheme.colorScheme.primary;
    final buttonStyle = appTheme.textTheme.labelLarge;

    return TextButton.icon(
      onPressed: () => controller.animateToPage(
        pageId,
        duration: pageAnimationDuration,
        curve: pageAnimationCurve,
      ),
      icon: Icon(
        leading,
        color: pageNumber == pageId ? selectedColor : notSelectedColor,
      ),
      label: Text(
        label,
        style: buttonStyle?.copyWith(
          color: pageNumber == pageId ? selectedColor : notSelectedColor,
        ),
      ),
    );
  }
}
