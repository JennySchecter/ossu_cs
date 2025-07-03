var show = console.log;
var inc = (function () {
    var count = 0;
    return function () {
        return ++count;
    }
})();

show(inc());
show(inc());

var name = "The Window";

var object = {
    name: "My Object",

    getNameFunc: function () {
        var that = this;
        return function () {
            return that.name;
        };

    }

};


show(object.getNameFunc()());