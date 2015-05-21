/**
    DomItemsManager class, that manage a collection 
    of HTML/DOM items under a root/container, where
    only one element at the time is visible, providing
    tools to uniquerly identify the items,
    to create or update new items (through 'inject'),
    get the current, find by the ID and more.
**/
'use strict';

var $ = require('jquery');
var escapeSelector = require('../escapeSelector');

function DomItemsManager(settings) {

    this.idAttributeName = settings.idAttributeName || 'id';
    this.allowDuplicates = !!settings.allowDuplicates || false;
    this.root = settings.root || 'body';
    this.$root = null;
}

module.exports = DomItemsManager;

DomItemsManager.prototype.getAllItems = function getAllItems() {
    return this.$root.children('[' + this.idAttributeName + ']');
};

DomItemsManager.prototype.find = function find(containerName, root) {
    var $root = $(root || this.$root);
    return $root.find('[' + this.idAttributeName + '="' + escapeSelector(containerName) + '"]');
};

DomItemsManager.prototype.getActive = function getActive() {
    return this.$root.find('[' + this.idAttributeName + ']:visible');
};

/**
    It adds the item in the html provided (can be only the element or 
    contained in another or a full html page).
    Replaces any existant if duplicates are not allowed.
**/
DomItemsManager.prototype.inject = function inject(name, html) {

    // Filtering input html (can be partial or full pages)
    // http://stackoverflow.com/a/12848798
    html = html.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '');

    // Creating a wrapper around the html
    // (can be provided the innerHtml or outerHtml, doesn't matters with next approach)
    var $html = $('<div/>', { html: html }),
        // We look for the container element (when the outerHtml is provided)
        $c = this.find(name, $html);

    if ($c.length === 0) {
        // Its innerHtml, so the wrapper becomes the container itself
        $c = $html.attr(this.idAttributeName, name);
    }

    if (!this.allowDuplicates) {
        // No more than one container instance can exists at the same time
        // We look for any existent one and its replaced with the new
        var $prev = this.find(name);
        if ($prev.length > 0) {
            $prev.replaceWith($c);
            $c = $prev;
        }
    }

    // Add to the document
    // (on the case of duplicated found, this will do nothing, no worry)
    $c.appendTo(this.$root);
};

/** 
    The switch method receive the items to interchange as active or current,
    the 'from' and 'to', and the shell instance that MUST be used
    to notify each event that involves the item:
    willClose, willOpen, ready, opened, closed.
    It receives as latest parameter the 'notification' object that must be
    passed with the event so handlers has context state information.
    
    It's designed to be able to manage transitions, but this default
    implementation is as simple as 'show the new and hide the old'.
**/
DomItemsManager.prototype.switch = function switchActiveItem($from, $to, shell, state) {

    var toName = state.route.name;
    //console.log('switch to', toName);
    
    this.disableAccess();
    
    function hideit() {
        var fromIsHidden = $from.is('[hidden]');
        if ($from.length > 0 && !fromIsHidden) {
            shell.emit(shell.events.willClose, $from, state);
            // Do 'unfocus' on the hidden element after notify 'willClose'
            // for better UX: hidden elements are not reachable and has good
            // side effects like hidding the on-screen keyboard if an input was
            // focused
            $from.find(':focus').blur();
            // hide and notify it ended
            $from
            .attr('hidden', 'hidden')
            // For browser that don't support attr
            .css('display', 'none')
            // Reset z-index to avoid overlapping effect
            .css('z-index', '');

            shell.emit(shell.events.closed, $from, state);
        }
        else {
            // Just unfocus to avoid keyboard problems
            $from.find(':focus').blur();
        }
    }

    var toIsHidden = $to.is('[hidden]'); // !$to.is(':visible')

    if (toIsHidden) {
        shell.emit(shell.events.willOpen, $to, state);
        // Put outside screen
        $to.css({
            position: 'absolute',
            zIndex: -1,
            top: 0,
            bottom: 0,
            left: 0,
            right: 0
        });
        // Show it:
        $to
        .removeAttr('hidden')
        // For browser that don't support attr
        .css('display', 'block');

        // Its enough visible and in DOM to perform initialization tasks
        // that may involve layout information
        shell.emit(shell.events.itemReady, $to, state);

        // Finish in a small delay, enough to allow some initialization
        // set-up that take some time to finish avoiding flickering effects
        setTimeout(function() {
            //console.log('ending switch to', toName, 'and current is', shell.currentRoute.name);
            // Race condition, redirection in the middle, abort:
            if (toName !== shell.currentRoute.name)
                return;
            
            // Hide the from
            hideit();
            
            // Ends opening, reset transitional styles
            $to.css({
                position: '',
                top: '',
                bottom: '',
                left: '',
                right: '',
                zIndex: 2
            });
            
            this.enableAccess();

            // When its completely opened
            shell.emit(shell.events.opened, $to, state);
        }.bind(this), 80);
    } else {
        //console.log('ending switch to', toName, 'and current is', shell.currentRoute.name, 'INSTANT (to was visible)');
        // Race condition, redirection in the middle, abort:
        if (toName !== shell.currentRoute.name)
            return;
        
        // Its ready; maybe it was but sub-location
        // or state change need to be communicated
        shell.emit(shell.events.itemReady, $to, state);
        
        this.enableAccess();
        
        hideit();
    }
};

/**
    Initializes the list of items. No more than one
    must be opened/visible at the same time, so at the 
    init all the elements are closed waiting to set
    one as the active or the current one.
    
    Execute after DOM ready.
**/
DomItemsManager.prototype.init = function init() {
    // On ready, get the root element:
    this.$root = $(this.root || 'body');

    this.getAllItems()
    .attr('hidden', 'hidden')
    // For browser that don't support attr
    .css('display', 'none');
    //this.getActive().hide();
    
    // A layer to visually hide an opening item while not completed opened
    $('<div class="items-backstage"/>').css({
        background: this.$root.css('background-color') || 'white',
        position: 'absolute',
        top: 0,
        right: 0,
        bottom: 0,
        left: 0,
        zIndex: 0
    }).appendTo(this.$root);
    
    // A layer to disable access to an item (disabling events)
    // NOTE: Tried CSS pointer-events:none has some strange side-effects: auto scroll-up.
    // TODO: After some testing with this, scroll-up happens again with this (??)
    var $disableLayer = $('<div class="items-disable-layer"/>').css({
        background: 'White',
        opacity: 0,
        position: 'absolute',
        top: 0,
        right: 0,
        bottom: 0,
        left: 0,
        zIndex: -1
    }).appendTo(this.$root);
    this.disableAccess = function() {
        $disableLayer.css('zIndex', 90900);
    };
    this.enableAccess = function() {
        $disableLayer.css('zIndex', -2);
    };
};
