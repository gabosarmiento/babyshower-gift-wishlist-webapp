class CompromisoMailer < ActionMailer::Base
  default from: "notificaciones@lalista.herokuapp.com"
  def nuevo_regalo_comprado(record, regalo, lista)
    @compromiso = record
    @regalo = regalo
    @fiesta = lista.fiesta
    mail(to: @fiesta.users.first.email, subject: "#{User.find(@compromiso.user_id).name.to_s.humanize.titleize} ha comprado un regalo")
  end

end