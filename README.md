# WP-CLI extension for Chassis
The WP-CLI extension automatically sets up your Chassis instance to be able to automatically install WP-CLI packages on your Chassis box.

## Installation
1. Add this extension to your extensions directory `git clone https://github.com/Chassis/WP_CLI.git extensions/wp_cli`
2. Run `vagrant provision`.


## Alternative Installation
1. Add `- chassis/wp_cli` to your `extensions` in one of you [yaml](http://docs.chassis.io/en/latest/config/) files. e.g.
	```
	extensions:
	  - chassis/wp_cli
	```
2. Run `vagrant provision`.

## Installing WP-CLI packages

You can have Chassis automatically run `composer install` in a number of directories in your project by adding a list of directories in one of your [yaml](http://docs.chassis.io/en/latest/config/) files. e.g.
```
wp_cli:
    packages:
        - wp-cli/server-command
        - wp-cli/restful
```

You'll need to run `vagrant provision` for those to be installed if you'd added them after your first initial Chassis `vagrant up`.
