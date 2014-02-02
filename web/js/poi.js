var animationTime = 500;
var colours = ["DFAA25", "E97E37", "E95B37", "BD2C33", "AA2222"];
var ratingInfobox = $("<div />")
        .attr("id", "ratinginfo")
        .insertAfter($("#rating"));
var colourizeRatings = function(nrOfRatings) {
    $("#rating li a").each(function() {
        if ($(this).parent().index() <= nrOfRatings) {
            $(this).stop().animate({backgroundColor: "#" + colours[nrOfRatings]}, animationTime);
        }
    });
};

$("#rating li a").hover(function() {
    ratingInfobox.empty().stop().animate({opacity: 1}, animationTime);

    $("<p />").html($(this).html()).appendTo(ratingInfobox);

    colourizeRatings($(this).parent().index());
}, function() {
    ratingInfobox.stop().animate({opacity: 0}, animationTime);
    $("#rating li a").stop().animate({backgroundColor: "#333"}, animationTime);
});

$("#rating li a").click(function(e) {
//                    e.preventDefault();
//                    alert("You voted on item number " + ($(this).parent().index() + 1));
});