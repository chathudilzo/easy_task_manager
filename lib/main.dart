import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

 

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/background.jpeg'),fit: BoxFit.cover)
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 30,top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                    Text('😉',style: TextStyle(fontSize: 40),),
                    Text('Welcome',style: TextStyle(color:Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
                    Text('Manage Tasks easly',style: TextStyle(color:Colors.white,fontSize: 30,),),
                    Text('For ever!',style: TextStyle(color:Color.fromARGB(255, 255, 255, 255),fontSize: 25,),),
                    
                    Expanded(child: Container()),
                    
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: () {
                              
                            },
                            child: Container(
                              width: 100,
                              height: 38,
                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(
                                  color: Color.fromARGB(255, 28, 48, 82),
                                  blurRadius: 5,spreadRadius: 1,offset: Offset(3, 2)
                                )],
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 19, 19, 19)
                              ),
                              child: Center(child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('Next ',style: TextStyle(fontSize: 16,color: Colors.white),),Icon(Icons.keyboard_double_arrow_right_outlined,color: Colors.white,)],
                              )),
                            ),
                          ),
                        ],
                      ),
                    )
              ],
            ),
          ),
        ),
      )
    );
    
  }
}