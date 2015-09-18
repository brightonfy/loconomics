/** Freelancer Pricing
**/
'use strict';

var FreelancerPricing = require('../models/FreelancerPricing'),
    GroupListRemoteModel = require('../utils/GroupListRemoteModel');

exports.create = function create(appModel) {

    var api = new GroupListRemoteModel({
        // Conservative cache, just 1 minute
        listTtl: { minutes: 1 },
        groupIdField: 'jobTitleID',
        itemIdField: 'freelancerPricingID',
        Model: FreelancerPricing
    });

    api.addLocalforageSupport('freelancer-pricing/');
    api.addRestSupport(appModel.rest, 'freelancer-pricing/');
    
    appModel.on('clearLocalData', function() {
        api.clearCache();
    });
    
    return api;
};