
* Start

    docker run -it -d -p22 -w /Users/karl/workspace/ejabberd:/usr/local/src/ejabberd karlma/ejabberd_dev

* Compile 

    ./autogen.sh
    ./configure
    ./make
    ./rebar compile generate
