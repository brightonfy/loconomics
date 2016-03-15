/** UpcomingBookingsSummary model **/
'use strict';

var ko = require('knockout'),
    Model = require('./Model'),
    BookingSummary = require('./BookingSummary');

function UpcomingBookingsSummary(values) {

    Model(this);
    
    // TODO: define today, tomorrow and nextWeek as
    // properties with default Model?
    // Review how update happens on home/dashboard, it can helps
    // to simplify that
    
    this.model.defProperties({
        today: new BookingSummary({
            concept: 'left today',
            timeFormat: ' [ending @] h:mma'
        }),
        tomorrow: new BookingSummary({
            concept: 'tomorrow',
            timeFormat: ' [starting @] h:mma'
        }),
        thisWeek: new BookingSummary({
            concept: 'this week',
            timeFormat: null
        }),
        nextWeek: new BookingSummary({
            concept: 'next week',
            timeFormat: null
        })
    }, values);

    /*
    this.today = new BookingSummary({
        concept: 'left today',
        timeFormat: ' [ending @] h:mma'
    });
    this.tomorrow = new BookingSummary({
        concept: 'tomorrow',
        timeFormat: ' [starting @] h:mma'
    });
    this.thisWeek = new BookingSummary({
        concept: 'this week',
        timeFormat: null
    });
    this.nextWeek = new BookingSummary({
        concept: 'next week',
        timeFormat: null
    });*/
    
    this.items = ko.pureComputed(function() {
        var items = [];
        
        if (this.today().quantity())
        items.push(this.today());
        if (this.tomorrow().quantity())
        items.push(this.tomorrow);
        if (this.thisWeek().quantity())
        items.push(this.thisWeek());
        if (this.nextWeek().quantity())
        items.push(this.nextWeek());

        return items;
    }, this);
    
}

module.exports = UpcomingBookingsSummary;
