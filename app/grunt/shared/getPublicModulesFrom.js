'use strict';

/**
    Extract external modules from the config require and shim's.
**/
function getPublicModulesFrom(config) {
    var list = [];
    
    if (config.options) {
        if (config.options.require) {
            config.options.require.forEach(function(v){
                var i = v.indexOf(':');
                if (i > -1)
                    list.push(v.substr(i + 1));
                else
                    list.push(v);
            });
        }
        if (config.options.shim) {
            list = list.concat(Object.keys(config.options.shim));
        }
    }
    
    return list;
}

module.exports = getPublicModulesFrom;
