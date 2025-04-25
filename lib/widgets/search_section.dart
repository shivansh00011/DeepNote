import 'package:deepnote/pages/chat_page.dart';
import 'package:deepnote/services/chat_service.dart';
import 'package:deepnote/theme/colors.dart';
import 'package:deepnote/widgets/search_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchSection extends StatefulWidget {
  
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final queryController = TextEditingController();
  @override
 
  void dispose() { 
    super.dispose();
    queryController.dispose();
    
  }
   @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Fueling Your Questions with Smart Answers', style: GoogleFonts.ibmPlexMono(fontSize: 32,fontWeight: FontWeight.w400, height: 1.2, letterSpacing: -0.5),),
        const SizedBox(height: 32,),
         Container(
          width: 700,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.searchBarBorder,
              width: 1.5
            )
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: queryController,
                  decoration: const InputDecoration(
                    hintText: 'Search Anything...',
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row (
                  children: [
                   Container(
                     height: 29,
                     width: 80,
                     decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 27, 145, 242),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5)
                        )
                      ]
                     ),
                     child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Icon(Icons.public_outlined, color: Colors.white,),
                        ),
                        const SizedBox(width: 3,),
                        Text("Search", style: TextStyle(fontSize: 13),)
                      ],
                     ),
                   ),
                    const SizedBox(width: 12,),
                    
                    const Spacer(),
                    GestureDetector(
                      onTap: (){
                        ChatService().chat(queryController.text.trim());
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatPage(question: queryController.text.trim())));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColors.submitButton,
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Icon(Icons.arrow_forward, color: AppColors.background, size: 16,),
                      ),
                    )
                
                  ],
                ),
              )
            ],
          ),
         )
      ],
    );
  }
}