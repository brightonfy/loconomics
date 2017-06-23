/**
**/
'use strict';

var SchedulingPreferences = require('../models/SchedulingPreferences');
var session = require('../data/session');
var RemoteModel = require('../utils/RemoteModel');

exports.create = function create(appModel) {
    var rem = new RemoteModel({
        data: new SchedulingPreferences(),
        ttl: { minutes: 1 },
        localStorageName: 'schedulingPreferences',
        fetch: function fetch() {
            return appModel.rest.get('me/scheduling-preferences');
        },
        push: function push() {
            return appModel.rest.put('me/scheduling-preferences', this.data.model.toPlainObject())
            .then(function(result) {
                // We need to recompute availability as side effect of scheduling preferences changes
                appModel.calendar.clearCache();
                // Forward the result
                return result;
            });
        }
    });

    session.on.cacheCleaningRequested.subscribe(function() {
        rem.clearCache();
    });

    return rem;
};
