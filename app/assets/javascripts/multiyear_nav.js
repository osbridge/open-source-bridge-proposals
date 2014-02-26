function bind_multiyear_nav_controls() {
  $('#menu li.event.active a.year').click(function(e) {
    e.preventDefault();
    $(e.target).parents('li.events').toggleClass('expanded');
  });

  $(document).bind('click', function(e) {
      if (! $(e.target).parents().hasClass("events"))
          $("#menu li.events").removeClass('expanded');
  });
}

$(document).ready(function () {
  bind_multiyear_nav_controls();
});

