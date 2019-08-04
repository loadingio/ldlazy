# ldLazyShow

Vanilla JS Lazy Show Library


## Usage

`
    ldlz = new ldLazyShow {root: document.body,  toggle: function(n) { ... } }
    ldlz.add( ... );
`

options:

 * root - root element for monitoring scroll.
 * toggle - when visibility changes, toggle will be called with the target node as param. default null.


## API

 * ldlz.add(n) - start monitoring node n for visibility change.
 * ldlz.remove(n) - stop monitoring node n for visibility change.


## License

MIT
