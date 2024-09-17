# Level 0
I used `cat readme` to get the contents of the file which contained the password. It was `ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If`.

This level is trying to get us to get familiar with Unix and using its commands.

# Level 1
This level added some complexity, requiring me to type `cat ./-` to tell `cat` that `-` is the name of a file and not a flag. The password contained within was `263JGJPfgU6LtdEvgfWU1XP5yac29mFx`.

It wants us to understand a bit more about the Unix filesystem and that `-` is a special character.

# Level 2
To handle the file with spaces in the name, I wrapped the filename in quotes and ran `cat ./"spaces in this filename"`. It contained the string `MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx`.

This level is teaching us that spaces always delineate arguments in a command, which can cause problems if a file we want to reference has spaces in its name. It also teaches us how to deal with it.

# Level 3
I used `cd inhere` to enter the directory that the password was stored and then `ls -a` to find the hidden password file. From there I ran `cat ...Hiding-From-You` and got `2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ`.

We are practicing with changing directories and dealing with hidden files.

# Level 4
After `cd inhere`, I ran `file ~/inhere/-file0[0-9]` to check the filetype of all of the files within the `inhere` directory. It told me that only `-file07` was ASCII text, so I ran `cat ./-file07` and got `4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw`.

This level is teaching us about filetypes and that not all files are human-readable ASCII format. It is also giving us more practice dealing with annoying filenames.

# Level 5
Using the `find` command, I ran `find -size 1033c ! -executable -print` which looks for a file that is 1033 bytes (`-size 1033c`) and is not an executable (`! -executable`) and print the matching results to stdout (`-print`). It thankfully only gave one option, `./maybehere07/.file2`, so I ran `cat ./maybehere07/.file2` and got the password `HWasnPhtq9AVKe0dmk45nxy20cvUa6EG`.

This level would have been really tedious without the `find` command, so it kind of forces you to learn how to use it effectively. At the same time, it teaches you about the types of files and that some files can be executables.

# Level 6
Since we have to search the entire server, before running `find`, I used `cd /` to change directory to the root directory. I then ran `find -user bandit7 -group bandit6 -size 33c -print` which looks for a file that is owned by user `bandit7` (`-user bandit7`), owned by group `bandit6` (`-group bandit6`) and is 33 bytes large (`-size 33c`). This gave me a lot of "Permission denied" errors, but also gave me the path `./var/lib/dpkg/info/bandit7.password`. Running `cat ./var/lib/dpkg/info/bandit7.password` then gave me `morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj`.

We are learning about user and group permissions, and how even though we are logged in as `bandit6` we can still access a file owned by `bandit7` because we are in a group that has permission to read it.


# Level 7
To find the password that is on the same line as "millionth", I ran `cat data.txt | grep millionth` which pipes the contents of `data.txt` into the `grep millionth` command which returns any lines that have the word "millionth" on it. This gave me `dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`.

This is helping us learn how to use `grep`.

# Level 8
I first tried to use `uniq -u data.txt` to find the one unique line, but after reading the `man` pages for `uniq`, I realized that the lines had to be sorted for `uniq` to find unique lines. Therefore, I ran `sort data.txt | uniq -u` and got `4CKMh1JI91bUIZZPXDqGanal4xvAg0JM`.

It is helping us learn how to use `uniq`. 

# Level 9
I used `strings data.txt` to find the strings in `data.txt` and then combed through the output until I found the password `FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey`.

We are learning how to use `strings`.

# Level 10
I ran `base64 -d data.txt` and got the password `dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr`.

It is teaching us how to use `base64`.

# Level 11
I ran the command `cat ./data.txt | tr nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ` to unshift each letter and got `7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4`

We are learning how to use `tr` to deal with data that has been obfuscated by the Caesar cipher.
