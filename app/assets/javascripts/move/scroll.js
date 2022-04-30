function scroll2({ offset = 0, duration = 150 }) {
 
  let start = null
  function scroll() {
       window.requestAnimationFrame(timestamp => {
          if (!start) {
              start = timestamp
          }

          const passed = timestamp - start
          let progress = passed / duration
          if (progress > 1) {
              progress = 1
          }
 
          const scrollByYOffset = parseInt((window.pageYOffset - offset) * progress)
 
          window.scrollBy(0, -scrollByYOffset)

          if (progress < 1) {
              scroll()
          }
 
          if (progress === 1) {
            console.log({ start, end: timestamp, passed: timestamp - start, pageYOffset: window.pageYOffset })
          }
      })
  }
  scroll()
}