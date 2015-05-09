var pusher = new Pusher('57dc9c12b6e6fa97febb');
var channel = pusher.subscribe('scores');

resetScores = function () {
  $.ajax({method: 'PUT', url: '/reset_scores', data: ''});
}

$(function() {
  $('#reset').on('click', resetScores);
})
