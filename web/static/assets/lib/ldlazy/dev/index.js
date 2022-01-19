(function(){
  var rn, ldlazy;
  rn = function(s, n){
    s == null && (s = "");
    n == null && (n = "ldlz");
    return (!!/\?/.exec(s) ? '&' : '?') + (n + "=" + Math.random().toString(36).substring(2));
  };
  ldlazy = function(opt){
    var root, debounced, update, this$ = this;
    opt == null && (opt = {});
    root = opt.root;
    this.opt = import$({
      debounce: 10
    }, opt);
    this.root = root = typeof root === 'string'
      ? document.querySelector(root)
      : root ? root : null;
    this.pending = [];
    if (this.opt.debounce && (typeof debounce != 'undefined' && debounce !== null)) {
      debounced = debounce(this.opt.debounce || 10, function(){
        this$.handle(this$.pending);
        return this$.pending = [];
      });
      update = function(ns){
        ns.map(function(it){
          var ref$;
          return ref$ = it.target._lzs, ref$.changed = true, ref$.visible = it.isIntersecting, ref$;
        });
        this$.pending = this$.pending.concat(ns.map(function(it){
          return it.target;
        }));
        return debounced(ns.map(function(it){
          return it.target;
        }));
      };
    } else {
      update = function(ns){
        ns.map(function(it){
          var ref$;
          return ref$ = it.target._lzs, ref$.changed = true, ref$.visible = it.isIntersecting, ref$;
        });
        return this$.handle(ns.map(function(it){
          return it.target;
        }));
      };
    }
    this.obs = new IntersectionObserver(update, {
      root: root
    });
    this.list = [];
    return this;
  };
  ldlazy.prototype = import$(Object.create(Object.prototype), {
    add: function(n){
      var ns, this$ = this;
      ns = Array.isArray(n)
        ? n
        : [n];
      return ns.map(function(n){
        var img;
        this$.obs.observe(n);
        this$.list.push(n);
        n._lzs = {
          src: n.getAttribute('data-src') || n.getAttribute("src")
        };
        if (n.classList.contains('nocache')) {
          n._lzs.src += rn(n._lzs.src);
          if (n.hasAttribute("src")) {
            n.setAttribute("src", n._lzs.src);
          }
        }
        if (n.classList.contains('placeholder')) {
          img = document.createElement("img");
          n.appendChild(img);
          img.src = n._lzs.src + rn(n._lzs.src, "ldlzp");
          return img.style.opacity = 0;
        }
      });
    },
    remove: function(n){
      var ns, this$ = this;
      ns = Array.isArray(n)
        ? n
        : [n];
      return ns.map(function(n){
        var ref$;
        this$.obs.unobserve(n);
        this$.list.splice(this$.list.indexOf(n), 1);
        return ref$ = n._lzs, delete n._lzs, ref$;
      });
    },
    handle: function(l){
      var this$ = this;
      l.map(function(n){
        var o;
        o = n._lzs;
        if (!o.changed) {
          return;
        } else {
          o.changed = false;
        }
        if (o.visible) {
          if (o.src) {
            if (n.nodeName === 'IMG') {
              n.setAttribute('src', o.src);
            } else {
              n.style.backgroundImage = "url(" + o.src + ")";
            }
            delete o.src;
          }
          n.style.opacity = 1;
          return n.style.visibility = 'visible';
        } else {
          n.style.opacity = 0;
          return n.style.visibility = 'hidden';
        }
      });
      if (this.opt.toggle) {
        return l.map(function(n){
          var o;
          o = n._lzs;
          if (!o.changed) {
            return;
          }
          return this$.opt.toggle(n, o.visible);
        });
      }
    }
  });
  import$(ldlazy, {
    px: 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEAAAAALAAAAAABAAEAAAIA',
    init: function(){
      var _, rs;
      _ = function(){
        var _, lzs;
        _ = new ldlazy();
        lzs = Array.from(document.querySelectorAll('.ldlz'));
        return lzs.map(function(it){
          return _.add(it);
        });
      };
      rs = document.readyState;
      if (rs === 'loaded' || rs === 'interactive' || rs === 'complete') {
        return _();
      } else {
        return window.addEventListener('DOMContentLoaded', function(){
          return _();
        });
      }
    }
  });
  if (typeof module != 'undefined' && module !== null) {
    module.exports = ldlazy;
  } else if (typeof window != 'undefined' && window !== null) {
    window.ldlazy = ldlazy;
  }
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}).call(this);
