class rsm.SplashView

  constructor: ->
    @form = $("#login-form")
    @submit = @form.find("input[type='submit']")
    @email = @form.find("input[type='email']")
    
    @submit.click @login_clicked

  login_clicked: (e) =>
    e.preventDefault();
    @email.slideUp(200)
    @submit.removeClass("info").addClass("success").attr('disabled', 'disabled');
    @submit.val("Check your inbox!")
    