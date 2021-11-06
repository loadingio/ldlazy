# ldlazy

Vanilla JS Lazy Show Library


## Usage

install via npm:

    npm install ldlazy


include the required files:

    <link rel="stylesheet" type="text/css" href="path-to-dist/index.min.css">
    <script type="text/javascript" src="path-to-dist/index.min.js"></script>


construct a ldlazy object:

    ldlz = new ldlazy({root: document.body,  toggle: function(n) { ... } });
    ldlz.add( ... );


## Constructor Options

 - `root` - root element for monitoring scroll.
 - `toggle` - when visibility changes, toggle will be called with the target node as param. default null.
 - `debounce` - millisecond delay before handling events. require debounce.js, otherwise will be ignored.


## API

 - `ldlz.add(n)` - start monitoring node n for visibility change.
 - `ldlz.remove(n)` - stop monitoring node n for visibility change.


## License

MIT
