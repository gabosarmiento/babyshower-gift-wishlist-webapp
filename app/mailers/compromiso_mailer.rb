class CompromisoMailer < ActionMailer::Base
  default from: "regalos@lalistaderegalos.co"
  def nuevo_regalo_comprado(record)
    @compromiso = record
    @regalo = @compromiso.regalo
    @fiesta = @regalo.lista.fiesta
    mail(to: @fiesta.users.first.email, subject: "#{User.find(@compromiso.user_id).name.to_s.humanize.titleize} ha comprado un regalo")
  end

end