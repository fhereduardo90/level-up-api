class CreateUserForm < BaseForm
  params do
    required(:name).value(:string)
    required(:email).value(:string)
    required(:birthdate).value(:date)
  end
end