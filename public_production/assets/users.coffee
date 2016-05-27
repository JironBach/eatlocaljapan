#users.coffee
$ ->

  # users/sign_up
  if $('body').hasClass('registrations new')
    $('#new_user').validate
      rules:
        'user[email]': 'required'
        'user[password]': 'required'
        'user[password_confirmation]': 'required'

  # users/sign_in
  if $('body').hasClass('sessions new')
    $('#new_user').validate
      rules:
        'user[email]': 'required'
        'user[password]': 'required'

  # users/password
  if $('body').hasClass('passwords')
    $('#new_user').validate
      rules:
        'user[email]': 'required'
        'user[password]': 'required'
        'user[password_confirmation]': 'required'

  # users/confirmations
  if $('body').hasClass('confirmations')
    $('#new_user').validate
      rules:
        'user[email]': 'required'
