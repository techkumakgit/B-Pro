class Util {
  static String formateNumber(int i) {

    if(i<9){
      return "0$i";
    }else{
      return "$i";
    }
  }
}