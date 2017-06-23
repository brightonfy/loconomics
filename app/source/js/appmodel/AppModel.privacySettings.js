/** Privacy Settings
**/
'use strict';

var PrivacySettings = require('../models/PrivacySettings');
var session = require('../data/session');
var RemoteModel = require('../utils/RemoteModel');

exports.create = function create(appModel) {
    var rem = new RemoteModel({
        data: new PrivacySettings(),
        ttl: { minutes: 1 },
        localStorageName: 'privacySettings',
        fetch: function fetch() {
            return appModel.rest.get('me/privacy-settings');
        },
        push: function push() {
            return appModel.rest.put('me/privacy-settings', this.data.model.toPlainObject());
        }
    });

    session.on.cacheCleaningRequested.subscribe(function() {
        rem.clearCache();
    });

    return rem;
};
