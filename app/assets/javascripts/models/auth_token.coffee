class rsm.AuthToken

  @create: (email, success, error) ->
    $.ajax(
      type: "POST",
      url: "/api/auth_tokens",
      data: 
        email: email
      success: success
      error: error
      dataType: "json"
    )
