function scrollSmoothToBottom (id) {
   var div = document.getElementById(id);
   $('#' + id).animate({
      scrollTop: div.scrollHeight - div.clientHeight
   }, 500);
}
function total_peers() {
  $.post('/total_peers',null,function(result){
    $("#total_peers").html(result)
  });
}
setInterval(function() {
  total_peers()
  $.post('/get_messages', null, function(result) { 
    $('#messages_display').html(null);    
    parsed_response = JSON.parse(result)
    parsed_response.forEach(function(item){
      if((item['from']+'/') == window.location.href) {
        $('#messages_display').append("<div class='chat_bubble yours'><p>" + item['message'] + "</p></div>")
      } else {
        $('#messages_display').append("<div class='chat_bubble'><p><span class='name'>" + item['from'] + "</span>" + item['message'] + "</p></div>")
      }
    });   
  });
  scrollSmoothToBottom('messages_display')
},2000)
$(document).ready(function() {
  $("#messages_display").niceScroll({cursorcolor: "#989898",axis: "yx"});
  $('#send-button').click(function() {
    var message = $('#text-input').val();
    var post_data = { message: message };
    $.post('/send_message', post_data);
    $.post('/my_messages', post_data);
    $('#messages_display').append("<div class='chat_bubble yours'><p>" + message + "</p></div>")
    $('#text-input').val(null);
  });
  particlesJS.load('background', './particlesjs.json');
});