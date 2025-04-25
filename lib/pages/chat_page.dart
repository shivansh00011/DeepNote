import 'package:deepnote/theme/colors.dart';
import 'package:deepnote/widgets/answer_section.dart';
import 'package:deepnote/widgets/side_nav.dart';
import 'package:deepnote/widgets/sources_section.dart';
import 'package:flutter/material.dart';
 class ChatPage extends StatefulWidget {
  final String question;
   const ChatPage({super.key, required this.question});
 
   @override
   State<ChatPage> createState() => _ChatPageState();
 }
 
 class _ChatPageState extends State<ChatPage> {
  
   @override
   Widget build(BuildContext context) {
     return Scaffold(
      body: Row(
        children: [
          const SideNav(), 
          const SizedBox(width: 100,),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.question,style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),),
                    const SizedBox(height: 24,),
                    const SourcesSection(),
                     const SizedBox(height: 24,),
                    const AnswerSection()
              
                  ],
                ),
              ),
            ),
          ),
          const Placeholder(
            strokeWidth: 0,
            color: AppColors.background,
          )

        ],
      ),
     );
   }
 }