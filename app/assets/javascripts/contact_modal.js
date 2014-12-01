var providerData = function() {
  this.id;
}

var provider = new providerData()

$(document).ready (function(){
  $('body').on('show.bs.modal', '#contactModal', function (event) {
    var button = $(event.relatedTarget);
    provider.id = button.data('providerid');
    var recipient = button.data('providername');
    var modal = $(this);
    modal.find('.modal-title').text('New message to ' + recipient);
  });

  $('body').on('click', '#privacy-terms', function() {
    $('#privacy-terms').html('<p>We do not read or retain your e-mail. A copy will be sent to you for your records. Spam filters may prevent your e-mail from reaching the therapist. The therapist should respond to you by e-mail, although we recommend that you follow up with a phone call. If you prefer corresponding via phone, please leave your contact number.</p>')
  });

  $('body').on('click', '#contact-me-button', function(e){
    e.preventDefault();
    var message = $('#message-text').val();
    var clientEmail = $('#client-email').val();
    var clientName = $('#client-name').val();

    var request = $.ajax({
      url: '/mailer',
      type: 'POST',
      data: {provider_id: provider.id, client_email: clientEmail, client_name: clientName, message: message }
    });

    request.success(function(response){
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
