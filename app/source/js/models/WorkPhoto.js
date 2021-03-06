/**
    WorkPhoto Model
**/
'use strict';
var Model = require('./Model');
var ko = require('knockout');
var FIXED_IMAGE_WIDTH = 442;
var FIXED_IMAGE_HEIGHT = 332;
var FIXED_IMAGE_RATE = FIXED_IMAGE_HEIGHT / FIXED_IMAGE_WIDTH;

function WorkPhoto(values) {
    Model(this);

    this.model.defProperties({
        workPhotoID: 0,
        userID: 0,
        jobTitleID: 0,
        caption: '',
        fileName: '',
        url: '',
        rankPosition: 0,
        updatedDate: null,
        rotationAngle: 0,
        // Additional local data:
        // path to local file, unsaved/not-uploaded still (native file/camera support)
        localTempFilePath: null,
        // data of local file, unsaved/not-uploaded still (web file picker support)
        localTempFileData: null,
        // data for generated preview for the localTempFileData (web file picker support; generated by the fileuploader plugin)
        localTempPhotoPreview: null
    }, values);

    /**
     * Computed helper that return the CSS values for use inline
     * visually rotating the image, to preview result.
     */
    this.photoRotationStyle = ko.pureComputed(function() {
        // We need to rotate, but too to scale the image by the original proportion,
        // since the behavior implemented is to keep image as landscape with
        // fixed width and height even if rotated or originally portrait.
        var r = this.rotationAngle() |0;
        var sr = 'rotate(' + r + 'deg)';
        // Since we know the fixed size, we calculated the ratio and apply it as
        // a downscale when image is rotated in portrait.
        // It's simple since we only allow 90 degrees rotations at UI
        var s = 1;
        if (r === 90 || r === 270) {
            s = FIXED_IMAGE_RATE;
        }
        var ss = 'scale(' + s + ', ' + s + ')';

        return 'transform: ' + sr + ' ' + ss;
    }, this);
}
module.exports = WorkPhoto;
