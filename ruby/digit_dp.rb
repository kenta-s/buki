# わかりやすい桁DPの説明。混乱したらここを読めばOK。
# http://drken1215.hatenablog.com/entry/2019/02/04/013700


# 考えられる最大の桁数
# この値を変更して使う。
digit_size = 4

# k以下という条件を無視した場合の最大値
# この値を変更して使う。もし桁数が一致していない場合はrjustでdigit_sizeに合わせる
best = "9325"

# k以下という条件を表すk。
# この値を変更して使う。もし桁数が一致していない場合はrjustでdigit_sizeに合わせる
k = "8357"

dp = {}
dp[0] = {}

# 一桁目だけ最初に値をいれておく

# bestのほうが小さい場合はそのままbestを一桁目に入れればよい
# 次の桁ではどんな値を使ってもkの値を超えることはないので、
# 任意の値を使っていいことがわかるようにsmallerをtrueにしておく
# なお、いったんsmallerがtrueになればそれ以降の桁はすべて最大の値を選択したとしてもkを超えることはないので
# すべてsmaller: trueになる
if best[0] < k[0]
  dp[0][:smaller] = true
  dp[0][:value] = best[0]

# bestのほうが大きい場合は、kの値が最大なのでkを使う
# 次の桁では、k以下しか選択できないのでsmallerはfalse
elsif best[0] > k[0]
  dp[0][:smaller] = false
  dp[0][:value] = k[0]

# bestとkが同じであれば、その値を使う
# 次の桁では、k以下しか選択できないのでsmallerはfalse
elsif best[0] == k[0]
  dp[0][:smaller] = false
  dp[0][:value] = k[0]
end

digit_size.times.with_index(1) do |_,i|
  # indexは1始まりなので、最後はnilになる
  break if k[i].nil?
  dp[i] = {}

  # 前の桁がsmallerであれば、任意の値を選択できる。
  # なお、以降もすべてsmallerになる
  if dp[i-1][:smaller]
    dp[i][:smaller] = true
    dp[i][:value] = dp[i-1][:value] + best[i]
  else

    # kのほうが大きければbestの値を使い、smallerはtrueになる
    if k[i] > best[i]
      dp[i][:smaller] = true
      dp[i][:value] = dp[i-1][:value] + best[i]

    # bestのほうが大きければ、kを選択するのがベスト。
    # smallerはfalse
    elsif k[i] < best[i]
      dp[i][:smaller] = false
      dp[i][:value] = dp[i-1][:value] + k[i]

    # bestとkが同一であれば、その値を入れる。
    # smallerはfalse
    elsif k[i] == best[i]
      dp[i][:smaller] = false
      dp[i][:value] = dp[i-1][:value] + best[i]
    end
  end
end

# digit_size-1に最終的に求めたい値が入る
ans = dp[digit_size-1][:value]
puts ans
