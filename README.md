# ldlazy

Vanilla JS Lazy Show Library


## Usage

`
    ldlz = new ldlazy {root: document.body,  toggle: function(n) { ... } }
    ldlz.add( ... );
`

options:

 * root - root element for monitoring scroll.
 * toggle - when visibility changes, toggle will be called with the target node as param. default null.
 * debounce - millisecond delay before handling events. require debounce.js, otherwise will be ignored.


## API

 * ldlz.add(n) - start monitoring node n for visibility change.
 * ldlz.remove(n) - stop monitoring node n for visibility change.


## License

MIT
