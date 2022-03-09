module RegexConstants
	PasswordRegex = /\A(?=.*).{8,72}\z/
	EmailRegex = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/
end
