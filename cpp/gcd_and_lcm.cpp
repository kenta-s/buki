long long gcd(long long a, long long b) { return b ? gcd(b,a%b) : a;}
long long lcm(long long a, long long b) { return a/gcd(a,b)*b;}
