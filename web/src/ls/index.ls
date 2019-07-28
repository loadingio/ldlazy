(->
  ldLazyShow = (opt = {}) ->
    root = opt.root
    @opt = {debounce: 10} <<< opt
    @root = root = if typeof(root) == \string => document.querySelector(root) else if root => root else null

    if @opt.debounce => 
      debounced = debounce (@opt.debounce or 10), ~> @handle @list
      update = (ns) ~>
        ns.map -> it.target._lzs <<< changed: true, visible: it.isIntersecting
        debounced ns.map -> it.target
    else (ns) ~>
      update = (ns) ~>
        ns.map -> it.target._lzs <<< changed: true, visible: it.isIntersecting
        @handle ns.map -> it.target

    @obs = new IntersectionObserver update, {root}
    @list = []
    @

  ldLazyShow.prototype = Object.create(Object.prototype) <<< do
    add: (n) ->
      @obs.observe n
      @list.push n
      n._lzs = {}
    remove: (n) ->
      @obs.unobserve n
      @list.splice @list.indexOf(n), 1
      delete n._lzs
    handle: (l) ->
      l.map (n) ~>
        o = n._lzs
        if !o.changed => return else o.changed = false
        if o.visible =>
          n.style.backgroundImage = "url(#{n.getAttribute('data-src')})"
          n.style.opacity = 1
        else
          n.style.backgroundImage = \none
          n.style.opacity = 0
      if @opt.toggle => l.map (n) ~> 
        o = n._lzs
        if !o.changed => return
        @opt.toggle n, o.visible

  window.addEventListener \DOMContentLoaded, ->
    _ = new ldLazyShow!
    lzs = Array.from(document.querySelectorAll('.img'))
    lzs.map -> _.add it

)!
