class MathEncryption

  attr_reader :p_value, :q_value, :e_value, :n_value, :d_value, :thi

  def initialize

    @p_value = 0
    @q_value = 0
    @e_value = 0
    @n_value = 0
    @thi = 0
    @d_value = 0

  end

  def check_e(test_thi = @thi, test_e = @e_value)
    begin
      euclidean_algorithm([test_thi], [test_e], [], [], 0)
    rescue ZeroDivisionError
      return false
    end
    true
  end

  def check_n
    @p_value * @q_value == @n_value
  end

  def calc_thi
    ((@p_value - 1) * (@q_value - 1)).to_i
  end

  def find_d
    @d_value = inverse_mod(@e_value, @thi)
  end

  def inverse_mod(a, n)
    t = 0
    new_t = 1
    r = n
    new_r = a
    while new_r != 0
      quotient = r / new_r
      t, new_t = new_t, t - quotient * new_t
      r, new_r = new_r, r - quotient * new_r
    end
    if r > 1
      return "a is not invertible"
    end
    if t < 0
      t = t + n
    end
    t
  end


  def gcd(a, b)
    res = euclidean_algorithm([a], [b], [], [], 0)
    [res[2][-1], res]
  end

  def euclidean_algorithm(a, b, rem, k, n)
    a << (b[-1])
    k << (a[-2] / b[-1])
    b << (a[-2] % b[-1])
    rem << (a[-2] % b[-2])

    if rem[-1] > 1
      euclidean_algorithm(a, b, rem, k, n + 1)
    else
      k << a[-1]
      rem << 0
    end
    [a, b, k, rem]
  end

  def sqrt(n)
    Math.sqrt(n)
  end

  def calc_primes
    # a^2 - n = b^2
    a = sqrt(@n_value).ceil
    while a < @n_value
      b2 = (a ** 2) - @n_value
      b = sqrt(b2)
      if b % 1 == 0
        break
      end
      a += 1
    end
    @p_value = a - b.to_i
    @q_value = a + b.to_i
    unless check_n
      raise "Error: p and q do not multiply to n"
    end
  end

  public

  def get_public_key
    [@e_value, @n_value]
  end

  def get_private_key
    [@d_value, @n_value]
  end

  def encode_int(m)
    # m ** @e_value % @n_value
    m.pow(@e_value, @n_value)
  end

  def decode_int(c)
    # c ** @d_value % @n_value
    c.pow(@d_value, @n_value)
  end


  def verify_key
    @e_value * @d_value % @thi == 1
  end

  def solve(new_e, new_n)
    @e_value = new_e
    @n_value = new_n
    calc_primes
    @thi = calc_thi
    @d_value = find_d
  end

  def create(p, q, e)
    unless check_e(p*q, e)
      raise("Error: e is not valid")
    end
    @p_value = p
    @q_value = q
    @e_value = e
    @n_value = p * q
    @thi = calc_thi
    @d_value = find_d
  end

  def get_all_data
    {
      p: @p_value,
      q: @q_value,
      e: @e_value,
      n: @n_value,
      thi: @thi,
      d: @d_value
    }
  end
end