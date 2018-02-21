module CompanyName

  attr_reader :company_name

  def set_name(name)
    self.company_name = name
  end

  protected
  attr_writer :company_name

end
