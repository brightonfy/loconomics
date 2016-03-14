/**
    Search results returned for job titles.
**/
'use strict';

var Model = require('./Model');

function JobTitleSearchResult(values) {
    
    Model(this);
    
    this.model.defProperties({
        jobTitleID: 0,
        singularName: '',
        pluralName: '',
        description: '',
        searchDescription: '',
        averageRating: '',
        totalRatings: '',
        averageResponseTimeMinutes: 0,
        averageHourlyRate: 0,
        minServicePrice: 0,
        minHourlyRate: 0,
        minServiceValue: '',
        serviceProfessionalsCount: 0
    }, values);
}

module.exports = JobTitleSearchResult;

