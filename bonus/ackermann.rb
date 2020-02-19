# Inspired by https://www.youtube.com/watch?v=i7sm9dzFtEI
# Don't launch the function with args m or n higher than 4 :)

def ack(m, n)
  if m == 0
    n + 1
  elsif n == 0
    ack(m - 1, 1)
  else
    ack(m - 1, ack(m, n - 1))
  end
end

t = Time.now
puts ack(2, 1)
duration = (Time.now - t).to_i
puts duration