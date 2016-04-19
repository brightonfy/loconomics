/**
    LicensesCertifications activity
**/
'use strict';

var ko = require('knockout'),
    $ = require('jquery'),
    Activity = require('../components/Activity');

var A = Activity.extend(function LicensesCertificationsActivity() {

    Activity.apply(this, arguments);

    this.accessLevel = this.app.UserType.serviceProfessional;
    this.viewModel = new ViewModel(this.app);
    // Defaults settings for navBar.
    
    this.navBar = Activity.createSubsectionNavBar('Job Title', {
        backLink: '/marketplaceProfile', helpLink: '/help/sections/201967966-adding-professional-licenses-and-certifications'
    });
    
    // On changing jobTitleID:
    // - load job title name
    this.registerHandler({
        target: this.viewModel.jobTitleID,
        handler: function(jobTitleID) {

            if (jobTitleID) {
                
                ////////////
                // Job Title
                // Get data for the Job title ID
                this.app.model.jobTitles.getJobTitle(jobTitleID)
                .then(function(jobTitle) {

                    // Fill in job title name
                    this.viewModel.jobTitleName(jobTitle.singularName());
                }.bind(this))
                .catch(function(err) {
                    this.app.modals.showError({
                        title: 'There was an error while loading the job title.',
                        error: err
                    });
                }.bind(this));
            }
            else {
                this.viewModel.jobTitleName('Job Title');
            }
        }.bind(this)
    });
});
exports.init = A.init;

A.prototype.show = function show(options) {
    Activity.prototype.show.call(this, options);

    var params = options && options.route && options.route.segments;
    var jobTitleID = params[0] |0;
    this.viewModel.jobTitleID(jobTitleID);
    if (jobTitleID) {
        // Get data for the Job title ID
        this.app.model.userLicensesCertifications.getList(jobTitleID)
        .then(function(list) {
            // Save for use in the view
            this.viewModel.list(this.app.model.userLicensesCertifications.asModel(list));
        }.bind(this))
        .catch(function (err) {
            this.app.modals.showError({
                title: 'There was an error while loading.',
                error: err
            });
        }.bind(this));
    }
    else {
        this.viewModel.list([]);
    }
};

function ViewModel(app) {

    this.jobTitleID = ko.observable(0);
    this.list = ko.observableArray([]);
    this.jobTitleName = ko.observable('Job Title'); 
    
    this.isSyncing = app.model.userLicensesCertifications.state.isSyncing();
    this.isLoading = app.model.userLicensesCertifications.state.isLoading();

    this.addNew = function() {
        var url = '#!licensesCertificationsForm/' + this.jobTitleID(),
            cancelUrl = app.shell.currentRoute.url;
        var request = $.extend({}, this.requestData, {
            cancelLink: cancelUrl
        });
        app.shell.go(url, request);
    }.bind(this);
    
    this.selectItem = function(item) {
        var url = '/licensesCertificationsForm/' + this.jobTitleID() + '/' +
            item.licenseCertificationID() + '?mustReturn=' + 
            encodeURIComponent(app.shell.currentRoute.url) +
            '&returnText=' + encodeURIComponent('Certifications/Licenses');
        app.shell.go(url, this.requestData);
    }.bind(this);
}
