class ConvidadoMailer < ActionMailer::Base
  default from: "invitaciones@lalistaderegalos.co"
  def nuevo_usuario_convidado(record, url)
    @convidado = record
    @url = url
    mail(to: @convidado.email, subject: "#{User.find(@convidado.anfitrion_id).name.to_s.humanize.titleize} te invita al #{@convidado.fiesta.nombre.to_s.humanize.titleize}")
  end

  def usuario_existente_convidado(record)
    @convidado = record
    mail(to: @convidado.email, subject: "Has recibido una invitación de #{User.find(@convidado.anfitrion_id).name.to_s.humanize.titleize}")
  end
end
