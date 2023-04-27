class Dice{
  final int size;
  late final List<int> dice = [];
  Dice({required this.size}){
    for(var k = 1  ; k <= size ; k++){
      dice.add(k);   
    }
  }

  List<int> shuffle(){
    dice.shuffle();
    return dice;
  }

  int pick(){
    int result = dice[0];
    dice.removeAt(0);
    return result;
  }



}