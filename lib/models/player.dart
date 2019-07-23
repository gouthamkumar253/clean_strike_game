class Player {
  int _score = 0;
  bool _isFoul = false;
  int _foulCount = 0;

  int getScore() {
    return _score;
  }

  int getFoulCount() {
    return _foulCount;
  }

  bool getIsFoul() {
    return _isFoul;
  }

  void setScore(int score){
    _score=score;
  }
  void setFoulCount(int fouls){
    _foulCount=fouls;
  }
  void setIsFoul(bool isFoul){
    _isFoul=isFoul;
  }
}