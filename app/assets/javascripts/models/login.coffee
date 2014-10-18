class rsm.Login

  @create: (email, success, error) ->
    $.ajax(
      type: "POST",
      url: "/api/logins",
      data: 
        email: email
      success: success
      error: error
      dataType: "json"
    )
