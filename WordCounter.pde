float difficulty =30;
Word[] words;
ArrayList<Word> toShow = new ArrayList<Word>();
String typed = "";
int score = 0;
int guesses = 0;
int correctGuesses = 0;

void setup() {
  frameRate(30);
  size(720, 720);
  //load the english words
  String lines[] = loadStrings("words.txt");
  words = new Word[lines.length];
  //now load them into the Word objects
  for (int i = 0; i < lines.length; i++) {
    //determine if this one will be special
    float rnd = random(0, 100);
    boolean special = false;
    if (rnd < 10) {
      special = true;
    }  
    //create the new word
    words[i] = new Word(lines[i], int(random(20, height-50)), special);
  }
}
void draw() {
  //if it's a game over
  if (score < 0) {
    background(255);
    textAlign(CENTER);
    textSize(25);
    text("GAME OVER", width/2, height/2);
    text("You guessed " + guesses + " times and got " + correctGuesses + " right!", width/2, height/2+80); 
    return;
  }

  background(255);
  //add a new word every frameRate%difficulty 
  if (frameCount%difficulty == 0 || frameCount == 1) {
    toShow.add(words[int(random(0, words.length))]);
  }
  //show the words
  for (int i = 0; i < toShow.size(); ) {
    //returns true if it's offscreen
    boolean remove = toShow.get(i).show(2);
    if (remove) {
      //remove the score and delete the word
      if (!toShow.get(i).special) {
        score -= toShow.get(i).word.length()*2;
      }
      toShow.remove(i);
    } else {
      i++;
    }
  }
  //display game information
  fill(0);
  textSize(20);
  text(typed, 20, height-10);
  text("SCORE: "+score, width/2, height-10);
}

void keyPressed() {
  if (key == ENTER) {
    for (int i = 0; i < toShow.size(); ) {
      if (typed.equals(toShow.get(i).word)) {
        //double score for specials
        if (toShow.get(i).special) {
          score += typed.length()*1.5;
        }
        score += typed.length()*1.5;
        toShow.remove(i);
        correctGuesses++;
        break;
      } else {
        i++;
      }
    }
    //reset the typed chache
    typed = "";
    guesses++;
    return;
  }
  //remove the last char in typed
  if (key == BACKSPACE) {
    if (typed.length() >= 1) {
      typed = typed.substring(0, typed.length()-1);
    }
    return;
  }
  //add the new key to typed
  typed += key;
}