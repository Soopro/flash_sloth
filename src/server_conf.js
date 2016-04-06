/* -------------------------------
 * Server Conf: flash sloth
/* ------------------------------- */

if (sup_flash_sloth == 'undefined' || !sup_flash_sloth){
   var sup_flash_sloth = {}
}

var test = {
  'api': 'http://api.sup.farm'
}

var dev = {
  'api': 'http://127.0.0.1:5000'
}

var prd = {
  'api': 'http://api.soopro.com'
}

sup_flash_sloth.server = dev
sup_flash_sloth.cookie_domain = ".sup.local"
sup_flash_sloth.debug = true;
