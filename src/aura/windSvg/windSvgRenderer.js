/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/
({
    render: function(cmp) {
        // grab attributes from the component markup
        var classname = cmp.get('v.class');
        var xlinkhref = cmp.get('v.xlinkHref');
        var ariaHidden = cmp.get('v.ariaHidden');

        // return an svg element with the attributes
        var svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
        svg.setAttribute('class', classname);
        svg.setAttribute('aria-hidden', ariaHidden);
        svg.innerHTML = '<use xlink:href="'+xlinkhref+'"></use>';

        return svg;
    }
})