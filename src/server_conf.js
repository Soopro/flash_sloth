/* -------------------------------
 * Server Conf: sup ext url4cc 
/* ------------------------------- */

if (sup_ext_url4cc == 'undefined' || !sup_ext_url4cc){
   var sup_ext_url4cc = {}
}

var test = {
  'api': 'http://ext.sup.farm/url4/server'
}

var dev = {
  'api': 'http://127.0.0.1:6002'
}

var prd = {
  'api': 'http://ext.soopro.net/url4/server'
}

sup_ext_url4cc.server = dev
sup_ext_url4cc.cookie_domain = ".sup.local"
sup_ext_url4cc.is_debug = true;
