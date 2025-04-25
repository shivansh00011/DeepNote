import 'package:deepnote/services/chat_service.dart';
import 'package:deepnote/widgets/search_section.dart';
import 'package:deepnote/widgets/side_nav.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  @override
  void initState() { 
    super.initState();
    ChatService().connect(); 
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Row(
        children: [
          const SideNav(),
          Expanded(
            child: Column(children: [
              const Expanded(child: SearchSection()),
            
            
              Container(height: 20,)
            
            ],),
          )
        ],
      ),
    );
  }
}