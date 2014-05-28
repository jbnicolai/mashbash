# Mashbash

Mashbash is a "language" that compiles down into Bash. The idea for the compiler was taken from Coffeescript. Eventually I would like to write a compiler in Bash, but for the time being for compatibility sake I am using Node.JS and Grunt for the compiler.

### Documentation

You can write Mash just like Bash; Mash just adds some new functionality, just remember "when in doubt just use Bash".

There are three segments to Mash commands and functions.

```
invocation:command:arguments
```

There is the invocation which is two characters long, this decides what command it will run. At the moment the available invocation codes there are is `> `, `<=` and `>=`

### Command Line

*`> `:*

Run a named command. Named commands will be able to be defined.





### Output

*`=> Hello World`:*

Echo text to out to stdout (file descriptor 1).

*`!> text`:*

Echo text to out to stderr (file descriptor 2). Default color: Red.

*`3> text`:*

Echo text to file descriptor 3 (you may also use this to output the text to stdout and stderr using 1 and 2 respectively).

*`=[red,bg-red]> text`:*

Echo text to stdout with ANSI colors.

*`![red,bg-red]> text`:*

Echo text to stderr with ANSI colors.

*`3[red,bg-red]> text`:*

Echo text to file descriptor 3 with ANSI colors.

### Input

*`<[/path/to/file]-INPUT`:*

Read a the contents of the file and assign and export to $INPUT.6

*`<[/path/to/file]=`:*

Include a file. Effectively `. /path/to/file`.

*`<0-INPUT`:*

Import from stdin and assign and export to $INPUT (you may also use this to input other file descriptors into variables using 0, 3, 4, j, etc... respectively; at this moment only single letter file descriptors will be supported).

*`<0=`:*

Import from stdin and evaluate (you may also use this to input other file descriptors into variables using 0, 3, 4, j, etc... respectively; at this moment only single letter file descriptors will be supported).

### User Input

*`<?-INPUT Prompt?`:*

Request input from user.

*`<!-INPUT Prompt?`:*

Request input from user (password mode).

*`<?= Prompt?`:*

Request input from user and evaluate it.

*`<!= Prompt?`:*

Request input from user and evaluate it. (password mode).

