class Word {
  float x, y;
  String word;
  int r, g, b;
  boolean special;
  Word(String word, float y, boolean special) {
    this.word = word;
    if(special){
     this.word = this.word.toUpperCase();
    }
    this.y = y;
    this.special = special;
    x = 0;
    r = 0;
    g = 255;
    b = 0;
  }

  boolean show(float speed) {
    this.x += speed;
    fill(r, g, b);
    textSize(15);
    if(special){
      textSize(20);
    }
    text(word, x, y);
    return rgbCheck();
  }
  boolean rgbCheck() {
    if (x > width) {
      return true;
    }
    if (x > width-width/4) {
      r = 255;
      g = 0;
      b = 0;
      return false;
    }
    if (x > width/2) {
      r = 245;
      g = 119;
      b = 69;
      return false;
    }
    return false;
  }
}