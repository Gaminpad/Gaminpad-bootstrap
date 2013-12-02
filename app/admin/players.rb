ActiveAdmin.register Player do
  
  index do
		column :username
		column :email
		column :created_at
		column :sign_in_count
		column :last_sign_in_at
		default_actions
	end

	filter :email
	
  
  form do |f|
    f.semantic_errors *f.object.errors.keys
		f.inputs "Player Details" do
			f.input :email
			f.input :username
			f.input :password
			f.input :password_confirmation
		end
		f.actions
	end
	
  
end
