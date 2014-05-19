class ConvidadoMailer < ActionMailer::Base
  default from: "no-reply@lalista.herokuapp.com"
  def nuevo_usuario_convidado(record, url)
    @convidado = record
    @url = url
    mail(to: @convidado.email, subject: "Has recibido una invitación de #{User.find(@convidado.anfitrion_id).name.to_s.humanize.titleize}")
  end

  def usuario_existente_convidado(record)
    @convidado = record
     mail(to: @convidado.email, subject: "Has recibido una invitación de #{User.find(@convidado.anfitrion_id).name.to_s.humanize.titleize}")
  end
end
