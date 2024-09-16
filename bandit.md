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

This level would have been really tedious without the `find` command, so it kind of forces you to learn how to use it effectively.
