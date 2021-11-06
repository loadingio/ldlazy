rn = (s = "", n = "ldlz") -> (if !!/\?/.exec(s) => \& else \?) + "#n=#{Math.random!toString(36).substring(2)}"
ldlazy = (opt = {}) ->
  root = opt.root
  @opt = {debounce: 10} <<< opt
  @root = root = if typeof(root) == \string => document.querySelector(root) else if root => root else null
  @pending = []

  if @opt.debounce and debounce? =>
    debounced = debounce (@opt.debounce or 10), ~>
      @handle @pending
      @pending = []
    update = (ns) ~>
      ns.map -> it.target._lzs <<< changed: true, visible: it.isIntersecting
      @pending ++= (ns.map -> it.target)
      debounced ns.map -> it.target
  else
    update = (ns) ~>
      ns.map -> it.target._lzs <<< changed: true, visible: it.isIntersecting
      @handle ns.map -> it.target

  @obs = new IntersectionObserver update, {root}
  @list = []
  @

ldlazy.prototype = Object.create(Object.prototype) <<< do
  add: (n) ->
    ns = if Array.isArray(n) => n else [n]
    ns.map (n) ~>
      @obs.observe n
      @list.push n
      n._lzs = {src: n.getAttribute('data-src') or n.getAttribute("src")}
      if n.classList.contains \nocache =>
        n._lzs.src += rn(n._lzs.src)
        if n.hasAttribute("src") => n.setAttribute("src", n._lzs.src)
      if n.classList.contains \placeholder =>
        img = document.createElement("img")
        n.appendChild img
        img.src = n._lzs.src + rn(n._lzs.src, "ldlzp")
        img.style.opacity = 0


  remove: (n) ->
    ns = if Array.isArray(n) => n else [n]
    ns.map (n) ~>
      @obs.unobserve n
      @list.splice @list.indexOf(n), 1
      delete n._lzs
  handle: (l) ->
    l.map (n) ~>
      o = n._lzs
      if !o.changed => return else o.changed = false
      if o.visible =>
        if o.src =>
          if n.nodeName == \IMG => n.setAttribute \src, o.src
          else n.style.backgroundImage = "url(#{o.src})"
          delete o.src
        n.style.opacity = 1
        n.style.visibility = \visible
      else
        n.style.opacity = 0
        n.style.visibility = \hidden
    if @opt.toggle => l.map (n) ~>
      o = n._lzs
      if !o.changed => return
      @opt.toggle n, o.visible

window.addEventListener \DOMContentLoaded, ->
  _ = new ldlazy!
  lzs = Array.from(document.querySelectorAll('.ldlz'))
  lzs.map -> _.add it

if module? => module.exports = ldlazy
if window => window.ldlazy = ldlazy
