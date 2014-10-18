#= require vendor/jquery
#= require_self
#= require_directory ./models
#= require_directory ./views

window.rsm = {}

# Apply CSRF token to AJAX requests

$.ajaxPrefilter (options, originalOptions, xhr) ->
  if (!options.crossDomain)
    token = $('meta[name="csrf-token"]').attr('content')
    xhr.setRequestHeader('X_CSRF_TOKEN', token) if(token) 

# Apply CSRF token to form if submitted without JS

$ ->
  token = $('meta[name=csrf-token]').attr('content')
  $('form input[name="_csrf"]').val(token)