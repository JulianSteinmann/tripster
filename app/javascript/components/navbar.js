function menuBackground() {
  let prevScrollpos = window.pageYOffset;
  window.onscroll = function() {
    let currentScrollPos = window.pageYOffset;
    if (currentScrollPos > 200) {
      document.getElementById("navbar").classList.add('scroll-bg');
    } else {
      document.getElementById("navbar").classList.remove('scroll-bg');
    }
    prevScrollpos = currentScrollPos;
  }
}
export { menuBackground }
