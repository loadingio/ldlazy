document.addEventListener \scroll, ->
  Array.from(document.querySelectorAll(".img")).map ->
    box = it.getBoundingClientRect!
    #if box.y + box.height >= 0 and box.y <= window.innerHeight =>
    if box.y >= 0 and box.y + box.height <= window.innerHeight =>
      it.style.background = "url(#{it.getAttribute('data-src')})"
    else it.style.background = \#f00
