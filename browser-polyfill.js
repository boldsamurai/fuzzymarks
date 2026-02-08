/* Browser API compatibility shim for Chrome/Chromium */
if (typeof browser === 'undefined') {
  window.browser = chrome;
}
