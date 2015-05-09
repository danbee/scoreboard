var pusher = new Pusher(pusherKey);
var channel = pusher.subscribe('scores');

resetScores = function () {
  $.ajax({method: 'PUT', url: '/reset_scores', data: ''});
}

$(function() {
  $('#reset').on('click', resetScores);
})
