$(document).ready (function(){
  $('body').on('show.bs.modal', '#contactModal', function (event) {
    var button = $(event.relatedTarget); // Button that triggered the modal
    var providerId = button.data('providerid');
    var recipient = button.data('providername');// Extract info from data-* attributes
    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    var modal = $(this);
    modal.find('.modal-title').text('New message to ' + recipient);
  });

  $('body').on('click', '#privacy-terms', function() {
    $('#privacy-terms').html('<p>hello world</p>')
  });

  $('body').on('click', '#contact-me-button', function(e){
    e.preventDefault();
    var message = $('#message-text').val();
    var userEmail = $('#user-email').val();

    var request = $.ajax({
      url: '/mailer',
      type: 'POST',
      data: {provider_id: providerId, user_email: userEmail, message: message }
    });

    request.done(function(response){
      console.log(response);
    });

    request.fail(function(response){
      console.log(response);
    });
  });

  $('body').on('hidden.bs.modal', '#contactModal', function (e) {
    $('#privacy-terms').html('<a href="#privacy-terms">Your privacy is important to us.</a>');
  });
});
