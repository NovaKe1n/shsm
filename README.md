# Shell Script Manager

ssm is a simple script to organize and search different kind of scripts.

### Installation

No need to install it, just run it.
If you want to specify a different directory than for your scripts
just modify the variable ```script_dir``` inside ssm.


### How-to organize your scripts

If you wish ssm to keep track of your scripts you can insert this template
at the top of each files:

```
#!/SHEBANG

#title|myscript
#version|0.1
#author|yourself
#info|This is a test

```


### Usage

```
Usage: ssm [options] [package/keyword]

  -l, --list                list all scripts
  -s, --search <keyword>    search script using a keyword
  -i, --info [-a all]       script info
  -h, --help                print this help
  -v, --version             current version
```

