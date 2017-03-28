'use strict';

var ServiceCollection = require('../models/ServiceCollection'),
    ServiceListGroup = require('./ServiceListGroup'),
    $ = require('jquery');

var Factories = {};

Factories.clientBookedServices = function(services, pricingTypes) {
    var listTitle = function(options) {
        var pricingType = options.pricingType,
            pricingTypeLabel = (pricingType && pricingType.pluralName()) || 'Services',
            postFix = this.isClientSpecific ? ' Just For You' : '';

        return 'Select From ' + pricingTypeLabel + postFix;
    };

    var newButtons = function() {
        return []; // no new buttons when client books services
    };

    var serviceCollection = new ServiceCollection(services),
        options = {
                pricingTypes: pricingTypes,
                listTitleFunction: listTitle,
                newButtonFunction: newButtons
            };

    var clientListGroup = new ServiceListGroup($.extend(options, {
            services: serviceCollection.clientSpecificServices(),
            isClientSpecific: true
        }));

    var publicListGroup = new ServiceListGroup($.extend(options, {
            services: serviceCollection.publicServices(),
            isClientSpecific: false
        }));

    return [clientListGroup, publicListGroup];
};

Factories.providerBookedServices = function(services, pricingTypes, clientName) {
    var listTitle = function(options) {
        var pricingType = options.pricingType,
            pricingTypeLabel = (pricingType && pricingType.pluralName()) || 'Services',
            clientLabel = this.isClientSpecific ? (' Just For ' + clientName) : '';

        return 'Select From ' + pricingTypeLabel + clientLabel;
    };

    var addNewLabel = function(options) {
        var clientPostfix = this.isClientSpecific ? (' just for ' + clientName) : '';

        return options.pricingType.addNewLabel() + clientPostfix;
    };

    services = new ServiceCollection(services);

    var options = {
            pricingTypes: pricingTypes,
            defaultPricingTypes: pricingTypes,  // show a pricing type even if it has no services
            listTitleFunction: listTitle,
            addNewLabelFunction: addNewLabel
        };

    var clientListGroup = new ServiceListGroup($.extend(options, {
            services: services.clientSpecificServices(),
            isClientSpecific: true
        }));

    var publicListGroup = new ServiceListGroup($.extend(options, {
            services: services.publicServices(),
            isClientSpecific: false
        }));

    return [clientListGroup, publicListGroup];
};

/*
*/
Factories.providerManagedServices = function(services, pricingTypes, clientName, isClientSpecific) {
    var listTitle = function(options) {
        var clientPostfix = clientName.length > 0 ? (' for ' + clientName) : '',
            pricingType = options.pricingType,
            pricingTypeLabel = (pricingType && pricingType.pluralName() || 'Services');

        return pricingTypeLabel + clientPostfix;
    };

    var serviceListGroup = new ServiceListGroup({
            services: services,
            pricingTypes: pricingTypes,
            defaultPricingTypes: pricingTypes, // show a pricing type even if it has no services
            isClientSpecific: isClientSpecific,
            listTitleFunction: listTitle       // listTitle relies on client name
        });

    return [serviceListGroup];
};

module.exports = Factories;