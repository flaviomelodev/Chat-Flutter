import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  //mais seguro para a passagem das rotas
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //CRIANDO ANIMAÇÕES
  /*A Animação vai ocorrer em qualquer parte em que tenha possibilidade
  de mudança de estado. Por exemplo: colocando uma cor de background com
  opacidade ela irá do transparente para a cor total, ou seja de 0.0 a 1.0.*/
  AnimationController controller;

  //Animação com curva de aparição
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(seconds: 3),
        //usa "this" por ser a mesma classe onde o controle está - WelcomeScreen
        //por isso coloca SingleTicker....
        vsync: this);

    //animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    //animação para transição de cores
    animation =
        ColorTween(begin: Colors.blue, end: Colors.white).animate(controller);

    controller.forward();

    /*fazer a animação aumentar e diminuir de tamanho, na verdade verifica o
    status do controller e altera o caminho*/
    /*animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });*/
    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                //criando animação para outras telas = Welcome para Registration
                Hero(
                  //serve como âncora para o início da animação
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Chat Box'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Entrar',
              color1: Colors.lightBlueAccent,
              onPressed: () {
                //rota para tela de login
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              color1: Colors.blueAccent,
              title: 'Registrar',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
