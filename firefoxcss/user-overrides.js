//user.js overrides

// Enable customChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Enable CSD
user_pref("browser.tabs.drawInTitlebar", true);

// Set UI density to normal
user_pref("browser.uidensity", 0);

// DNS
// //Quad 9: https://dns.quad9.net/dns-query
user_pref("network.trr.uri", "https://dns.quad9.net/dns-query");
user_pref("network.trr.mode", 2);

// Disable Safebrowsing
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);

// ipv6
user_pref("network.dns.disableIPv6", false);

//WebRTC settings, things like video calls
user_pref("media.peerconnection.enabled", false);
// Disable Media Plugins
user_pref("media.gmp-provider.enabled", false);
// Disable DRM, FCKDRM
user_pref("media.gmp-widevinecdm.enabled", false);
user_pref("media.eme.enabled", false);

//Autoplaying settings
//0=Allow all, 1=Block non-muted media (default), 5=Block all
user_pref("media.autoplay.default", 5);
//If some websites REALLY need autoplaying...
//0=sticky (default), 1=transient, 2=user
user_pref("media.autoplay.blocking_policy", 2);

user_pref("network.cookie.lifetimePolicy", 2);
//Disabling disk cache is better, but try this if you like performance
user_pref("privacy.clearsitedata.cache.enabled", true);

// Set Startup page
user_pref("browser.startup.page", 1);
// Set custom startpage
user_pref("browser.startup.homepage", "file:///media/P1/startpage/index.html");
// Enable new tab page
user_pref("browser.newtabpage.enabled", true);

// Enable searching through search bar using keywords
user_pref("keyword.enabled", true);

// Disable WebGL
user_pref("webgl.disabled", true)

// Disable Signons (password manager)
user_pref("signon.rememberSignons", false);
// Disable Pocket
user_pref("extensions.pocket.enabled", false);
// Disable Mozilla Account
user_pref("identity.fxaccounts.enabled", false);

// toggle search suggestions
// user_pref("browser.search.suggest.enabled", true);
// user_pref("browser.urlbar.suggest.searches", true);

//  toggle letterboxing
// user_pref("privacy.resistFingerprinting.letterboxing", false); // [HIDDEN PREF]

