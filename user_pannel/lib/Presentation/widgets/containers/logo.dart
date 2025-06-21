import 'package:flutter/material.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/main.dart';

class LanguageSelector extends StatefulWidget {
  final String currentLanguage;

  const LanguageSelector({super.key, this.currentLanguage = 'en'});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late String _selectedLang;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isExpanded = false;

  final List<LanguageOption> _languages = const [
    LanguageOption(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      flag: '🇺🇸',
    ),
    LanguageOption(
      code: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      flag: '🇸🇦',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedLang = widget.currentLanguage;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isExpanded) {
      _removeOverlay();
      _animationController.reverse();
    } else {
      _showOverlay();
      _animationController.forward();
    }
    setState(() => _isExpanded = !_isExpanded);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    
    // Get screen width and check text direction
    final screenWidth = MediaQuery.of(context).size.width;
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    const dropdownWidth = 150.0;
    const padding = 16.0;
    
    // Calculate horizontal position
    double left;
    if (isRTL) {
      // For RTL, align dropdown to the right edge of the button
      left = offset.dx + size.width - dropdownWidth;
      // Ensure it doesn't go off the left edge
      if (left < padding) {
        left = padding;
      }
    } else {
      // For LTR, align dropdown to the left edge of the button
      left = offset.dx;
      // Ensure it doesn't go off the right edge
      if (left + dropdownWidth > screenWidth - padding) {
        left = screenWidth - dropdownWidth - padding;
      }
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: left,
        top: offset.dy + size.height + 8,
        width: dropdownWidth,
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _languages.map((lang) {
                final isSelected = lang.code == _selectedLang;
                return InkWell(
                  onTap: () {
                    _selectLanguage(lang.code);
                    _toggleDropdown();
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          lang.flag,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                lang.nativeName,
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                lang.name,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _selectLanguage(String langCode) {
    setState(() => _selectedLang = langCode);
    MyApp.setLocale(context, Locale(langCode));
    
    // Show feedback with proper RTL support
    final selectedLang = _languages.firstWhere((lang) => lang.code == langCode);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectedLang.flag, style: TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              langCode == 'ar' 
                  ? 'تم تغيير اللغة إلى العربية' 
                  : 'Language changed to English',
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = _languages.firstWhere(
      (lang) => lang.code == _selectedLang,
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isExpanded ? AppColors.primary : Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(currentLang.flag, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 4),
              AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value * 3.14159,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageOption {
  final String code;
  final String name;
  final String nativeName;
  final String flag;

  const LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
  });
}