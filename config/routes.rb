# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :custom_fields_sections, except: %i[show] do
	put :order, on: :member
end
