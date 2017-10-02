
* Start

```
    docker run -it -d -p22 -w /Users/karl/workspace/ejabberd:/usr/local/src/ejabberd karlma/ejabberd_dev
```

* Change password

```
    docker exec -it 643fa67ea0b2 /bin/bash
    root@643fa67ea0b2:~# passwd
```

* Compile 

 compile out of container

```
    docker run -it --rm -v /Users/karl/workspace/ejabberd:/usr/local/src/ejabberd karlma/ejabberd_dev ./rebar get-deps compile generate
```
 
 or ssh and exec

```
    ./autogen.sh
    ./configure
    ./make
    ./rebar compile generate
```

