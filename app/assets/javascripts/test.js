

$(document).ready(function(){
  $("#micropost_content").keyup(function(e) {
    len = $(this).val().length;
    remaining = 140 - len;
    remaining_text = remaining == 1 ? "character" : "characters";
    warning = "";
    if(remaining <= 0){
      remaining = "<font color='red'>" + remaining + "</font>";
      warning = "<font color='red'> - What's up!!!</font>";
    }
    $("#content_counter").html(remaining + " " + remaining_text +  " remaining" + warning);
  })
});
