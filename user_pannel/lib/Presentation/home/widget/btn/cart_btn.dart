import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/core/services/api/cart/post.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class CartButton extends StatefulWidget {
  final String productId;
  final VoidCallback? onSuccess;
  final String? customText;
  final double width;
  final double height;

  const CartButton({
    super.key,
    required this.productId,
    this.onSuccess,
    this.customText,
    this.width = 140,
    this.height = 40,
  });

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton>
    with SingleTickerProviderStateMixin {
  ButtonState _state = ButtonState.idle;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.1)),
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (_state != ButtonState.idle) return;

    HapticFeedback.lightImpact();

    setState(() => _state = ButtonState.loading);
    _controller.repeat();

    try {
      await Future.wait([
        postCart(productId: widget.productId, quantity: 1),
        Future.delayed(const Duration(milliseconds: 800)), // Min loading time
      ]);

      if (mounted) {
        setState(() => _state = ButtonState.success);
        _controller.stop();
        HapticFeedback.mediumImpact();
        widget.onSuccess?.call();

        // Reset after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => _state = ButtonState.idle);
            _controller.reset();
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _state = ButtonState.error);
        _controller.stop();
        HapticFeedback.heavyImpact();
        _showErrorMessage();

        // Reset after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => _state = ButtonState.idle);
            _controller.reset();
          }
        });
      }
    }
  }

  void _showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text('Failed to add to cart'),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Color get _buttonColor {
    switch (_state) {
      case ButtonState.idle:
      case ButtonState.loading:
        return AppColors.primary;
      case ButtonState.success:
        return Colors.green.shade500;
      case ButtonState.error:
        return Colors.red.shade500;
    }
  }

  Widget get _buttonContent {
    final lang = AppLocalizations.of(context)!;
    switch (_state) {
      case ButtonState.idle:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.customText ?? lang.addtocart,
              style: TextStyle(
                color: AppColors.fontWhite,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.fontWhite,
              size: 18,
            ),
          ],
        );

      case ButtonState.loading:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotationTransition(
              turns: _rotationAnimation,
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(AppColors.fontWhite),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Adding...",
              style: TextStyle(
                color: AppColors.fontWhite,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );

      case ButtonState.success:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Added!",
              style: TextStyle(
                color: AppColors.fontWhite,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.check_circle, color: AppColors.fontWhite, size: 18),
          ],
        );

      case ButtonState.error:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Try Again",
              style: TextStyle(
                color: AppColors.fontWhite,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.refresh, color: AppColors.fontWhite, size: 18),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_buttonColor, _buttonColor.withOpacity(0.8)],
              ),
              boxShadow: [
                BoxShadow(
                  color: _buttonColor.withOpacity(0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                onTap: _handleTap,
                borderRadius: BorderRadius.circular(24),
                splashColor: Colors.white.withOpacity(0.2),
                child: Container(
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _buttonContent,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum ButtonState { idle, loading, success, error }
