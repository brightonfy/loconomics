/**
    TimeSlot view model (aka: CalendarSlot) for use
    as part of the template/component time-slot-tile or activities
    providing data for the template.
**/
'use strict';

var getObservable = require('../utils/getObservable');

function TimeSlotViewModel(params) {
    /*jshint maxcomplexity:9*/

    this.startTime = getObservable(params.startTime || null);
    this.endTime = getObservable(params.endTime || null);
    this.subject = getObservable(params.subject || null);
    this.description = getObservable(params.description || null);
    this.link = getObservable(params.link || null);
    this.actionIcon = getObservable(params.actionIcon || null);
    this.actionText = getObservable(params.actionText || null);
    this.classNames = getObservable(params.classNames || null);
}

module.exports = TimeSlotViewModel;

var numeral = require('numeral');

/**
    Static constructor to convert an Appointment model into 
    a TimeSlot instance following UI criteria for preset values/setup.
**/
TimeSlotViewModel.fromAppointment = function fromAppointment(apt) {
    /*jshint maxcomplexity:8 */
    return new TimeSlotViewModel({
        startTime: apt.startTime,
        endTime: apt.endTime,
        subject: apt.summary,
        description: apt.description,
        link: '#!appointment/' + apt.id(),
        actionIcon: (apt.sourceBooking() ? null : apt.sourceEvent() ? 'glyphicon glyphicon-chevron-right' : !apt.id() ? 'glyphicon glyphicon-plus' : null),
        actionText: (
            apt.sourceBooking() && 
            apt.sourceBooking().bookingRequest() && 
            apt.sourceBooking().bookingRequest().pricingEstimate() ? 
            numeral(apt.sourceBooking().bookingRequest().pricingEstimate().totalPrice() || 0).format('$0.00') :
            null
        ),
        classNames: (apt.id() ? null : 'ListView-item--tag-success')
    });
};
