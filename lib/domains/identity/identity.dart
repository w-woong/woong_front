class Identity {
  String tid;
  String idToken;
  int expiry;

  Identity({required this.tid, required this.idToken, required this.expiry});
  Identity.empty()
      : tid = '',
        idToken = '',
        expiry = 0;

  bool isEmpty() {
    if (tid == '' || idToken == '' || expiry == 0) {
      return true;
    }

    return false;
  }
}
