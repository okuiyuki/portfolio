class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      flash[:success] = 'お問い合わせを送信しました'
      redirect_to root_path
    else
      flash[:danger] = 'お問い合わせの送信に失敗しました'
      render :new
    end
  end

  def contact_params
    params.require(:contact).permit(:name, :message)
  end
end
