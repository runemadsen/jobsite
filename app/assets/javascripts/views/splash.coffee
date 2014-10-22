class rsm.SplashView

  constructor: ->
    @form = $("#login-form")
    @submit = @form.find("input[type='submit']")
    @email = @form.find("input[type='email']")
    
    @submit.click @login_clicked

  login_clicked: (e) =>
    e.preventDefault();
    @submit.val("Sending email...")

    rsm.AuthToken.create(@email.val(), 
      =>
        @email.slideUp(200)
        @submit.removeClass("info")
          .addClass("success")
          .attr('disabled', 'disabled')
          .val("Check your inbox!")
      ,
      =>
        @submit.removeClass("info")
          .addClass("error")
          .val("Invalid email")
          
        setTimeout( => 
          @email.val('')
          @submit.removeClass("error")
            .addClass("info")
            .val("Try again")
        , 2000)
    )

    
    