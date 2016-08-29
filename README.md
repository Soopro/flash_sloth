# Flash Sloth: The CRM Agent of Soopro

### Server side config
There is a server_conf.js in /src.
It's real important. but it's ignored on git.
you have to create own one to start on localhost.

on sever side we put it manually.
each server might have different config.

```javascript

  /* -------------------------------
   * sup Server Conf
  /* ------------------------------- */

  if (sup == 'undefined' || !sup){
     var sup= {}
  }

  sup.server = {
    api: "http://api.sup.farm",
    self: "http://sloth.sup.farm"
  }
```


### How to Release

```peon -c release``` 

start make a release.

### Peon Usage

```peon -c release``` to release a version.

-----

```peon -c init``` to install bower components and node_modules

-----

```peon``` to start localhost.
