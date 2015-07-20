/**
    WorkPhotos activity
**/
'use strict';

var ko = require('knockout'),
    $ = require('jquery'),
    Activity = require('../components/Activity');

var A = Activity.extends(function WorkPhotosActivity() {

    Activity.apply(this, arguments);

    this.accessLevel = this.app.UserType.Freelancer;
    this.viewModel = new ViewModel(this.app);
    // Defaults settings for navBar.
    this.navBar = Activity.createSubsectionNavBar('Job Title');

    // On changing jobTitleID:
    // - load photos
    /* TODO Uncomment and update on implementing REST API AppModel
    this.registerHandler({
        target: this.viewModel.jobTitleID,
        handler: function(jobTitleID) {
            if (jobTitleID) {
                // Get data for the Job title ID
                this.app.model.workphotos.getList(jobTitleID)
                .then(function(list) {
                    // Save for use in the view
                    this.viewModel.list(list);
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
        }.bind(this)
    });*/
    // TODO Remove on implemented REST API
    this.viewModel.list(testdata());
    
    // Event handlers for photo list management
    this.registerHandler({
        target: this.$activity,
        selector: '.WorkPhotos-imgBtn',
        event: 'click',
        handler: function(event) {
            $(event.target).closest('li').toggleClass('is-selected');
        }.bind(this)
    });
});

exports.init = A.init;

A.prototype.show = function show(options) {
    Activity.prototype.show.call(this, options);

    var params = options && options.route && options.route.segments;
    this.viewModel.jobTitleID(params[0] |0);
};

function ViewModel(app) {

    this.jobTitleID = ko.observable(0);
    this.list = ko.observableArray([]);
    
    this.isSyncing = app.model.licensesCertifications.state.isSyncing();
    this.isLoading = app.model.licensesCertifications.state.isLoading();

    this.addNew = function() {
        // Pick a new photo
        var newItem = {
            url: '',
            title: ''
        };
        this.openPhotoPicker(newItem);
    }.bind(this);
    
    this.changeImg = function(item) {
        // Pick another photo to replace on 'item'
        this.openPhotoPicker(item);
    }.bind(this);

    this.openPhotoPicker = function(item) {
        /*global navigator,Camera*/
        if (navigator.camera && navigator.camera.getPicture) {
            navigator.camera.getPicture(function(img) {
                item.url = img;
            }, function(err) {
                // bug iOS note: http://plugins.cordova.io/#/package/org.apache.cordova.camera
                setTimeout(function() {
                    app.modals.showError({ title: 'Error getting photo.', error: err });
                }, 0);
            }, {
                destinationType: Camera.DestinationType.FILE_URI,
                targetWidth: 446,
                targetHeight: 332,
                saveToPhotoAlbum: true,
                mediaType: Camera.MediaType.PICTURE,
                correctOrientation: true
            });
        }
        else {
            // bug iOS note: http://plugins.cordova.io/#/package/org.apache.cordova.camera
            setTimeout(function() {
                app.modals.showError({ error: 'Impossible to get photo from device.' });
            }, 0);
        }
    };
    
    this.updateSort = function(/*info*/) {
        // TODO
    };
}



/// TESTDATA

function testdata() {
    return [
        { url: 'https://loconomics.com/img/userphotos/u296/0c95dbccafd14953a94bde86eff4d34a-442x332.jpg', title: 'Testing photo 1' },
        { url: 'https://loconomics.com/img/userphotos/u296/3eb14073cb6a45138b6fd96b459bf3a1-442x332.jpg', title: 'Testing photo 2' },
        { url: 'https://loconomics.com/img/userphotos/u296/0c95dbccafd14953a94bde86eff4d34a-442x332.jpg', title: 'Testing photo 3' },
        { url: 'https://loconomics.com/img/userphotos/u296/3eb14073cb6a45138b6fd96b459bf3a1-442x332.jpg', title: 'Testing photo 4' }
    ];
}