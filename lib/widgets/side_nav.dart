import 'package:deepnote/theme/colors.dart';
import 'package:flutter/material.dart';

class SideNav extends StatefulWidget {
  
  
  const SideNav({super.key});

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  bool isCollapsed = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 130),
      width: isCollapsed ? 66:155,
      color: AppColors.sideNav,
      child: Column(
        crossAxisAlignment: isCollapsed ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: isCollapsed? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
             Container(
               
                margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                child: const Icon(Icons.auto_awesome_mosaic, color: AppColors.whiteColor, size: 30,)),
               isCollapsed?const SizedBox(): const Text("DeepNote", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
            ],
          ),
          const SizedBox(height: 22,),
          Row(
            mainAxisAlignment: isCollapsed? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                child: const Icon(Icons.add, color: AppColors.iconGrey, size: 22,),
                
              ),
                 isCollapsed?const SizedBox(): const Text("Add", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
            ],
          ),
           Row(
            mainAxisAlignment: isCollapsed? MainAxisAlignment.center : MainAxisAlignment.start,
             children: [
               Container(
                margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                child: const Icon(Icons.search, color: AppColors.iconGrey, size: 22,),
               
                         ),
                            isCollapsed?const SizedBox(): const Text("Search", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
             ],
           ),
           Row(
            mainAxisAlignment: isCollapsed? MainAxisAlignment.center : MainAxisAlignment.start,
             children: [
               Container(
                margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                child: const Icon(Icons.language, color:AppColors.iconGrey, size: 22,),
                         ),
                            isCollapsed?const SizedBox(): const Text("Spaces", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
             ],
           ),
           Row(
            mainAxisAlignment: isCollapsed? MainAxisAlignment.center : MainAxisAlignment.start,
             children: [
               Container(
                margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                child: const Icon(Icons.auto_awesome, color: AppColors.iconGrey, size: 22,),
                         ),
                            isCollapsed?const SizedBox(): const Text("Discover", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
             ],
           ),
           Row(
            mainAxisAlignment: isCollapsed? MainAxisAlignment.center : MainAxisAlignment.start,
             children: [
               Container(
                margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                child: const Icon(Icons.cloud_outlined, color: AppColors.iconGrey, size: 22,),
                         ),
                            isCollapsed?const SizedBox(): const Text("Library", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
             ],
           ),
          const Spacer(),
           GestureDetector(
            onTap: () {
              setState(() {
                isCollapsed = !isCollapsed;
              });
            },
             child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              margin: const EdgeInsets.symmetric(vertical: 14),
              child: Icon(isCollapsed? Icons.keyboard_arrow_right: Icons.keyboard_arrow_left, color: AppColors.iconGrey, size: 22,),
                       ),
           ),
          

        ],
      ),
    );
  }
}