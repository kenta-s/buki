class Segtree
  # 頂点の値は dat[0] で取得できる
  attr_reader :dat
  def initialize(n)
    @n = 1
    while @n < n
      @n *= 2
    end
    @dat = {}
  
    (@n * 2 - 1).times do |i|
      # 初期値をセット
      # @dat[i] = Float::INFINITY
    end
  end

  # k番目(0-indexed)の値をaに変更
  def update(k, a)
    k += @n - 1
    @dat[k] = a

    while k > 0
      k = (k - 1) / 2
      # 二つの値から、親の値をどのように更新するのか。例えば、二つの値のminなのかgcdなのか
      # @dat[k] = [@dat[k * 2 + 1], @dat[k * 2 + 2]].min
    end
  end

  # # RMQの場合
  #
  # # [a, b)の最小値を求める
  # def query(a, b, k = 0,l = 0, r = @n)
  #   return Float::INFINITY if r <= a || b <= l
  #   return @dat[k] if a <= l && r <= b
  #   vl = query(a,b,k * 2 + 1, l, (l + r) / 2)
  #   vr = query(a,b,k * 2 + 2, (l + r) / 2, r)
  #   [vl, vr].min
  # end
end
