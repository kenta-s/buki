// int
int euc(int a, int b){
  int r = a % b;
  while(r != 0){
    a = b;
    b = r;
    r = a % b;
  }
  return b;
}

// long long
long long euc(long long a, long long b){
  long long r = a % b;
  while(r != 0){
    a = b;
    b = r;
    r = a % b;
  }
  return b;
}
