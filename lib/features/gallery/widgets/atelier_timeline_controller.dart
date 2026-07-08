import 'package:flutter/material.dart';
import '../models/era_state.dart';

class AtelierTimelineController extends StatelessWidget {
  final int currentIndex;
  final Function(int) onEraSelected;
  final bool isDesktop;

  const AtelierTimelineController({
    super.key,
    required this.currentIndex,
    required this.onEraSelected,
    this.isDesktop = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isDesktop) {
      return _buildMobileIndicator();
    }

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Horizontal Line
          Container(
            height: 1,
            color: Colors.white24,
            width: double.infinity,
          ),

          // Tick Marks
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: EraState.eras.asMap().entries.map((entry) {
              bool isSelected = entry.key == currentIndex;
              return GestureDetector(
                onTap: () => onEraSelected(entry.key),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isSelected ? 12 : 6,
                        height: isSelected ? 12 : 6,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFD4AF37) : Colors.white54,
                          shape: BoxShape.circle,
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: const Color(0xFFD4AF37).withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ] : [],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.value.century,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white38,
                          fontSize: 10,
                          letterSpacing: 1,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: EraState.eras.asMap().entries.map((entry) {
        bool isSelected = entry.key == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isSelected ? 24 : 8,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFD4AF37) : Colors.white24,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }).toList(),
    );
  }
}
