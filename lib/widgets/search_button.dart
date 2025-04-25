import 'package:deepnote/theme/colors.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatefulWidget {
  final IconData icon;
  final String text;
  const SearchButton({super.key, required this.icon, required this.text});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event){
        setState(() {
          isHovered =true;
        });
      },
      onExit: (event){
        setState(() {
          isHovered = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color:isHovered?AppColors.proButton: Colors.transparent
        ),
        child: Row(
          children: [
            Icon(widget.icon, color: AppColors.iconGrey, size: 20,),
            const SizedBox(width: 8,),
            Text(widget.text, style: const TextStyle(color: AppColors.textGrey,)),
          ],
        ),
      ),
    );
  }
}