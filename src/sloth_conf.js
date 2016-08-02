/* -------------------------------
 * Server Conf: flash sloth
/* ------------------------------- */

if (sup_flash_sloth == 'undefined' || !sup_flash_sloth){
   var sup_flash_sloth = {}
}

var dev = {
  'api': 'http://127.0.0.1:5000',
  'self': 'http://sup.local:9528'
}

var test = {
  'api': 'http://api.sup.farm',
  'self': 'http://agent.sup.farm'
}

var prd = {
  'api': 'http://api.soopro.io',
  'self': 'http://agent.soopro.com'
}

sup_flash_sloth.server = test
sup_flash_sloth.debug = true;
