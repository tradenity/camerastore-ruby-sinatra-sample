error Tradenity::SessionExpiredException do
  Tradenity.reset_current_session
  redirect to('/')
end