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


## How It Works

ldlazy controls the visibility of an element based on the event from IntersectionObserver. Two styles will be touched:

 - `visibility`
 - `opacity`

Alternatively, you can specify a source url for showing / lazy loading an image when the element becomes visible. Use `src` or `data-src` (for lazy loading ) attributes to indicate image url:

    <div src=""></div>
    <img data-src="...">

ldlazy fill the corresponding field ( `style.backgroundImage` for `div`, `src` for `img` ) when the element is visible.

Additionally, specify following css class over an element for additional effect:

 - `nocache`: always load this image with a randomized querystring, which forcily disable the cache.
   - useful for transitional animated SVG 
 - `placeholder`: insert a invisible placeholder image with given URL inside this node.
   - the image may be loaded before visible, so it becomes lazy show instead of lazy load.
   - only applicable for container type node ( such as div ).


## Class API

 - `init()`: ask `ldlazy` to scan and init all elements with `ldlz` classes.


## Best Practice

When using with `img` tag, you may want to fill following attributes to prevent [CLS - Cumulative Layout Shift](https://web.dev/cls/):

 - `width` and `height`: set to the expected size of your image.
   - this will be overwritten if you also specify values in stylesheet, but it helps in keeping aspect ratio.
 - `src`: you can still fill `src` attribute with a 66 bytes long, single pixel, transprent gif:
   - `data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEAAAAALAAAAAABAAEAAAIA`
   - this is available as a mixin named `ldlz` in Pug after including `dist/index.pug`, with `src` as only parameter:

    +ldlz("path-to-your-image")(additional-attribute="here", ...)


## License

MIT
