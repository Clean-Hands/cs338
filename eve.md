# Diffie-Hellman

To figure out the shared secret `K`, I wrote the following Python script to brute force Alice and Bob's `a` and `b`, which I then used to calculate `K`:

```python
g = 7
p = 97
a = None
b = None

for i in range(p):
    if (pow(g, i, p) == 53):
        a = i
        print("a = " + str(a))
        break

for i in range(p):
    if (pow(g, i, p) == 82):
        b = i
        print("b = " + str(b))
        break

print("K = " + str(pow(g, (a * b), p)))
```

The output of my script is as follows:
```
a = 22
b = 41
K = 65
```

If the secret integers were much bigger, then brute forcing would no longer be a plausible method. Trying every number until you find the correct one would take extremely long if that was the case.

In my specific solution, the two `for` loops would have to run for many more iterations before landing on a solution, rendering it extremely inefficient.

# RSA

In order to decode Alice's message, I first needed to calculate `p` and `q`, which would let me get Bob's `d`. Using the following script, I was able to brute force the answer:

```python
e = 13
n = 162991

for i in range(2,n):
    if n % i == 0:
        p = i
        q = int(n/i)
        print("p = " + str(p) + ", q = " + str(q))
        break

lambda_n = lcm((p-1), (q-1))

for i in range(1,n):
    if (e * i) % lambda_n == 1:
        d = i
        print("d = " + str(d))
        break
```

Once I had `d`, I could then decode the message. I learned the message was not only encrypted, but the ASCII was first encoded in hexadecimal, and then further encoded as decimal numbers. My decryption and decoding is as follows:

```python
cipher = [17645, 100861, 96754, 160977, 120780, 90338, 130962, 74096,
128123, 25052, 119569, 39404, 6697, 82550, 126667, 151824,
80067, 75272, 72641, 43884, 5579, 29857, 33449, 46274,
59283, 109287, 22623, 84902, 6161, 109039, 75094, 56614,
13649, 120780, 133707, 66992, 128221]

decrypted = []

for char in cipher:
    decrypted_char = pow(char, d, n)
    decrypted.append(hex(decrypted_char).split('x')[-1])

message = ''.join(decrypted)

print("MESSAGE: " + bytearray.fromhex(message).decode())
```
The complete output is as follows:

```
p = 389, q = 419
d = 43665
MESSAGE: Dear Bob, check this out. https://www.surveillancewatch.io/ See ya, Alice.
```

Just like before, if `p` and `q` were larger then my brute force method would not be plausible. In my solution, the `for` loops would have to loop for many more times before landing on the correct answer, which would take much longer than it did with the current `p` and `q`.

This method would still be insecure even if Bob used larger integers because each character was encrypted individually. This means that frequency analysis could be used to decrypt individual ciphers without needing to calculate `p`, `q` or `d`.