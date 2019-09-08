(->
  ldLazy = (opt = {}) ->
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

  ldLazy.prototype = Object.create(Object.prototype) <<< do
    add: (n) ->
      ns = if Array.isArray(n) => n else [n]
      ns.map (n) ~>
        @obs.observe n
        @list.push n
        n._lzs = {src: n.getAttribute('data-src')}
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
            n.style.backgroundImage = "url(#{that})"
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
    _ = new ldLazy!
    lzs = Array.from(document.querySelectorAll('.ldlz'))
    lzs.map -> _.add it

  if module? => module.exports = ldLazy
  if window => window.ldLazy = ldLazy
)!
