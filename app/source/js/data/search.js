/**
 * Access public marketplace data, by performing searches.
 * Remote only (no cache, no local), once search at a time.
 */
'use strict';

var remote = require('./drivers/restClient');

/**
 * Default location used for searchs.
 * @member {number} lat
 * @member {number} lat
 * @member {number} searchDistance
 * @member {string} city
 */
exports.DEFAULT_LOCATION = {
    lat: '37.788479',
    lng: '-122.40297199999998',
    searchDistance: 30,
    city: 'San Francisco, CA USA'
};

/**
 * Search for service professionals, job titles and categories
 * at the marketplace, by term and location
 * @param {string} searchTerm Job title name or proffesional name
 * @param {number} [lat] Latitude of the location to find nearby
 * @param {number} [lng] Longitude of the location to find nearby
 * @param {number} [searchDistance] Nearby radius
 * @returns {Promise<SearchResult>} Plain object representing the
 * data of a model/SearchResult
 */
exports.byTerm = function(searchTerm, lat, lng, searchDistance) {
    if (exports.byTerm.latestRequest) {
        exports.byTerm.latestRequest.xhr.abort();
    }

    exports.byTerm.latestRequest = remote.get('search', {
        searchTerm: searchTerm,
        origLat: lat || exports.DEFAULT_LOCATION.lat,
        origLong: lng || exports.DEFAULT_LOCATION.lng,
        searchDistance: searchDistance || exports.DEFAULT_LOCATION.searchDistance
    });
    return exports.byTerm.latestRequest;
};

/**
 * Retrieves information for a category
 * @param {number} categoryID Category to retrieve
 * @param {number} [lat] Latitude of the location to find nearby
 * @param {number} [lng] Longitude of the location to find nearby
 * @param {number} [searchDistance] Nearby radius
 * @returns {Promise<CategorySearchResult>}
 */
exports.getCategory = function(categoryID, lat, lng, searchDistance) {
    if (exports.getCategory.latestRequest) {
        exports.getCategory.latestRequest.xhr.abort();
    }

    exports.getCategory.latestRequest = remote.get('search/categories/' + categoryID, {
        origLat: lat,
        origLong: lng,
        searchDistance: searchDistance
    });
    return exports.getCategory.latestRequest;
};

/**
 * Searchs all job titles in a given category
 * @param {number} categoryID Search category to search in
 * @param {number} [lat] Latitude of the location to find nearby
 * @param {number} [lng] Longitude of the location to find nearby
 * @param {number} [searchDistance] Nearby radius
 * @returns {Promise<Array<JobTitleSearchResult>>}
 */
exports.jobTitlesByCategory = function(categoryID, lat, lng, searchDistance) {
    if (exports.jobTitlesByCategory.latestRequest) {
        exports.jobTitlesByCategory.latestRequest.xhr.abort();
    }

    exports.jobTitlesByCategory.latestRequest = remote.get('search/job-titles/by-category', {
        categoryID: categoryID,
        origLat: lat,
        origLong: lng,
        searchDistance: searchDistance
    });
    return exports.jobTitlesByCategory.latestRequest;
};

/**
 * Retrieves information for a search category
 * @param {number} jobTitleID Job title to retrieve
 * @param {number} [lat] Latitude of the location to find nearby
 * @param {number} [lng] Longitude of the location to find nearby
 * @param {number} [searchDistance] Nearby radius
 * @returns {Promise<JobTitleSearchResult>}
 */
exports.getJobTitle = function(jobTitleID, lat, lng, searchDistance) {
    if (exports.getJobTitle.latestRequest) {
        exports.getJobTitle.latestRequest.xhr.abort();
    }

    exports.getJobTitle.latestRequest = remote.get('search/job-titles/' + jobTitleID, {
        origLat: lat,
        origLong: lng,
        searchDistance: searchDistance
    });
    return exports.getJobTitle.latestRequest;
};

/**
 * Searchs all service professionals in a given job title
 * @param {number} jobTitleID Job title to search in
 * @param {number} [lat] Latitude of the location to find nearby
 * @param {number} [lng] Longitude of the location to find nearby
 * @param {number} [searchDistance] Nearby radius
 * @returns {Promise<Array<ServiceProfessionalSearchResult>>}
 */
exports.serviceProfessionalsByJobTitle = function(jobTitleID, lat, lng, searchDistance) {
    if (exports.serviceProfessionalsByJobTitle.latestRequest) {
        exports.serviceProfessionalsByJobTitle.latestRequest.xhr.abort();
    }

    exports.serviceProfessionalsByJobTitle.latestRequest =remote.get('search/service-professionals/by-job-title', {
        jobTitleID: jobTitleID,
        origLat: lat,
        origLong: lng,
        searchDistance: searchDistance
    });
    return exports.serviceProfessionalsByJobTitle.latestRequest;
};
