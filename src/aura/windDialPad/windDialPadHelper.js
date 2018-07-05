/*
Copyright 2018 WindmillSoft, inc. All rights reserved.
*/

({
    getKeyList: function() {
        var keys = [];

        // create 1-9 buttons (first three rows)
        var text = { 1: ' ', 2:'ABC', 3:'DEF', 4:'GHI', 5:'JKL', 6:'MNO', 7:'PQRS', 8:'TUV', 9:'WXYZ' };

        for (var i = 1; i < 10; i++) {
            keys.push({
                value: i,
                text: text[i]
            });
        }

        // create *, 0, # (fourth row)
        keys.push({
            value: '*',
            text: ' '
        });
        keys.push({
            value: '0',
            text: '+'
        });
        keys.push({
            value: '#',
            text: ' '
        });

        return keys;
    }
})