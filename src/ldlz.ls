(->
  lzs = Array.from(document.querySelectorAll('.ldlz'))
  document.addEventListener \scroll, ->
    for i from 0 til lzs.length => 
      n = lzs[i]
      box = n.getBoundingClientRect!
      if box.y >= 0 and box.y + box.height <= window.innerHeight =>
	n.style.background = "url(#{n.getAttribute('data-src')})"
      else n.style.background = \#f00

  obs = new IntersectionObserver update, do
    root: document.body
    rootMargin: '0px'
    threshold: 1.0

  lzs.map -> 
  obs = lzs.map (n) ->
    opt = do
      root: n
      rootMargin: '0px'
      threshold: 1.0
    return new IntersectionObserver (-> console.log \ok), opt
)!

