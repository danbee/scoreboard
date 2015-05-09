<scores>
  <div class="scores">
    <div id="red-score">
      <span class="name">{ players.red.name }</span>
      <span class="score">{ players.red.score }</span>
      <span class="games">{ players.red.games }</span>
    </div>
    <div id="blue-score">
      <span class="name">{ players.blue.name }</span>
      <span class="score">{ players.blue.score }</span>
      <span class="games">{ players.blue.games }</span>
    </div>
  </div>

  <script>
    this.players = opts.players;

    channel.bind('update_scores', function(data) {
      this.players = data;
      this.update();
    }.bind(this));

  </script>
</scores>
