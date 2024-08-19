[comment]: # (Do not edit this file as it is autogenerated. Go to docs/individual-docs if you want to make edits.)


[comment]: # (Please add your documentation on top of this line)

## languages\.php\.enable



Whether to enable tools for PHP development\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `



## languages\.php\.package



Allows you to [override the default used package](https://nixos\.org/manual/nixpkgs/stable/\#ssec-php-user-guide)
to adjust the settings or add more extensions\. You can find the
extensions using ` devenv search 'php extensions' `



*Type:*
package



*Default:*
` pkgs.php `



*Example:*

```
pkgs.php.buildEnv {
  extensions = { all, enabled }: with all; enabled ++ [ xdebug ];
  extraConfig = ''
    memory_limit=1G
  '';
};

```



## languages\.php\.packages



Attribute set of packages including composer



*Type:*
submodule



*Default:*
` pkgs `



## languages\.php\.packages\.composer



composer package



*Type:*
null or package



*Default:*
` pkgs.phpPackages.composer `



## languages\.php\.disableExtensions

PHP extensions to disable\.



*Type:*
list of string



*Default:*
` [ ] `



## languages\.php\.extensions



PHP extensions to enable\.



*Type:*
list of string



*Default:*
` [ ] `



## languages\.php\.fpm\.extraConfig



Extra configuration that should be put in the global section of
the PHP-FPM configuration file\. Do not specify the options
` error_log ` or ` daemonize ` here, since they are generated by
NixOS\.



*Type:*
null or strings concatenated with “\\n”



*Default:*
` null `



## languages\.php\.fpm\.phpOptions



Options appended to the PHP configuration file ` php.ini `\.



*Type:*
strings concatenated with “\\n”



*Default:*
` "" `



*Example:*

```
''
  date.timezone = "CET"
''
```



## languages\.php\.fpm\.pools



PHP-FPM pools\. If no pools are defined, the PHP-FPM
service is disabled\.



*Type:*
attribute set of (submodule)



*Default:*
` { } `



*Example:*

```
{
  mypool = {
    user = "php";
    group = "php";
    phpPackage = pkgs.php;
    settings = {
      "pm" = "dynamic";
      "pm.max_children" = 75;
      "pm.start_servers" = 10;
      "pm.min_spare_servers" = 5;
      "pm.max_spare_servers" = 20;
      "pm.max_requests" = 500;
    };
  }
}
```



## languages\.php\.fpm\.pools\.\<name>\.extraConfig



Extra lines that go into the pool configuration\.
See the documentation on ` php-fpm.conf ` for
details on configuration directives\.



*Type:*
null or strings concatenated with “\\n”



*Default:*
` null `



## languages\.php\.fpm\.pools\.\<name>\.listen



The address on which to accept FastCGI requests\.



*Type:*
string



*Default:*
` "" `



*Example:*
` "/path/to/unix/socket" `



## languages\.php\.fpm\.pools\.\<name>\.phpEnv



Environment variables used for this PHP-FPM pool\.



*Type:*
attribute set of string



*Default:*
` { } `



*Example:*

```
{
  HOSTNAME = "$HOSTNAME";
  TMP = "/tmp";
  TMPDIR = "/tmp";
  TEMP = "/tmp";
}

```



## languages\.php\.fpm\.pools\.\<name>\.phpOptions



Options appended to the PHP configuration file ` php.ini ` used for this PHP-FPM pool\.



*Type:*
strings concatenated with “\\n”



## languages\.php\.fpm\.pools\.\<name>\.phpPackage



The PHP package to use for running this PHP-FPM pool\.



*Type:*
package



*Default:*
` phpfpm.phpPackage `



## languages\.php\.fpm\.pools\.\<name>\.settings



PHP-FPM pool directives\. Refer to the “List of pool directives” section of
[https://www\.php\.net/manual/en/install\.fpm\.configuration\.php"](https://www\.php\.net/manual/en/install\.fpm\.configuration\.php%22)
the manual for details\. Note that settings names must be
enclosed in quotes (e\.g\. ` "pm.max_children" ` instead of
` pm.max_children `)\.



*Type:*
attribute set of (string or signed integer or boolean)



*Default:*
` { } `



*Example:*

```
{
  "pm" = "dynamic";
  "pm.max_children" = 75;
  "pm.start_servers" = 10;
  "pm.min_spare_servers" = 5;
  "pm.max_spare_servers" = 20;
  "pm.max_requests" = 500;
}

```



## languages\.php\.fpm\.pools\.\<name>\.socket



Path to the Unix socket file on which to accept FastCGI requests\.

This option is read-only and managed by NixOS\.



*Type:*
string *(read only)*



*Example:*
` config.env.DEVENV_STATE + "/php-fpm/<name>.sock" `



## languages\.php\.fpm\.settings



PHP-FPM global directives\.

Refer to the “List of global php-fpm\.conf directives” section of
[https://www\.php\.net/manual/en/install\.fpm\.configuration\.php](https://www\.php\.net/manual/en/install\.fpm\.configuration\.php)
for details\.

Note that settings names must be enclosed in
quotes (e\.g\. ` "pm.max_children" ` instead of ` pm.max_children `)\.

You need not specify the options ` error_log ` or ` daemonize ` here, since
they are already set\.



*Type:*
attribute set of (string or signed integer or boolean)



*Default:*

```
{
  error_log = config.env.DEVENV_STATE + "/php-fpm/php-fpm.log";
}

```



## languages\.php\.ini



PHP\.ini directives\. Refer to the “List of php\.ini directives” of PHP’s



*Type:*
null or strings concatenated with “\\n”



*Default:*
` "" `



## languages\.php\.version



The PHP version to use\.



*Type:*
string



*Default:*
` "" `