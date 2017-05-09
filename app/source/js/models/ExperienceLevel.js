/** ExperienceLevel model.
 **/
'use strict';

var Model = require('./Model');

function ExperienceLevel(values) {
    
    Model(this);

    this.model.defProperties({
        experienceLevelID: 0,
        name: '',
        description: null,
        //createdDate: null,
        updatedDate: null
    }, values);
}

ExperienceLevel.prototype.hasExperienceLevel = function() {
    return this.experienceLevelID() > 0;
};

module.exports = ExperienceLevel;
