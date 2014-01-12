FactoryGirl.define do
	factory :user do
		name		"Artem Demko"
		email		"art@mail.ru"
		password	"123456"
		password_confirmation "123456"
	end
end